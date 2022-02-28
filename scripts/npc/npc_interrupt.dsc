

# | ---------------------------------------------- NPC INTERRUPT | ASSIGNMENTS ---------------------------------------------- | #
			
				
npc_interrupt_fishermen:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: false
    actions:
		#############################################
		# |------- set triggers & defaults -------| #
		#############################################
		on assignment:
			- trigger name:proximity state:true radius:5
			- flag <npc> interrupted:false
			- flag <npc> ignored:!|:li@
			- lookclose <npc> false
			- pose id:static
			- fish <npc.cursor_on>
			- lookclose <npc> true
			- if <player.flag[flag_proximity]>:
				- narrate "<gray>[<aqua><bold>NPC.<npc.id><gray>] <white>Interrupted: <aqua><npc.flag[interrupted]>"
		
		#########################################
		# |------- interrupt fishermen -------| #
		#########################################
		on enter proximity:
			- if ( <player.gamemode> == 'spectator' || <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
				- if <player.flag[flag_proximity]>:
					- narrate "<gray>[<aqua><bold>NPC.<npc.id><gray>] <white>Ignoring: <aqua><npc.flag[ignored].size>"
			- if ( not <npc.flag[ignored].contains[<player>]> && not <npc.flag[interrupted]> ):
				- fish stop
				- flag <npc> interrupted:true
			- if <player.flag[flag_proximity]>:
				- narrate "<gray>[<aqua><bold>NPC.<npc.id><gray>] <white>Interrupted: <aqua><npc.flag[interrupted]>"
		
		######################################
		# |------- resume fishermen -------| #
		######################################
		on exit proximity:
			- wait 1s
			- if ( not <npc.flag[ignored].contains[<player>]> && <npc.flag[interrupted].is_truthy> && <npc.location.find_players_within[5].is_empty> ) || ( not <npc.flag[ignored].contains[<player>]> && <npc.flag[interrupted].is_truthy> && <npc.location.find_players_within[5]> == <npc.flag[ignored]> ):
				- fish <npc.cursor_on>
				- flag <npc> interrupted:false
			- if <npc.flag[ignored].contains[<player>]>:
				- flag <npc> ignored:<-:<player>
				- if <player.flag[flag_proximity]>:
					- narrate "<gray>[<aqua><bold>NPC.<npc.id><gray>] <white>Ignoring: <aqua><npc.flag[ignored].size>"
			- if <player.flag[flag_proximity]>:
				- narrate "<gray>[<aqua><bold>NPC.<npc.id><gray>] <white>Interrupted: <aqua><npc.flag[interrupted]>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #


npc_interrupt_guard:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: false
    actions:	
		#############################################
		# |------- set triggers & defaults -------| #
		#############################################
		on assignment:
			- trigger name:proximity state:true radius:5



# | ---------------------------------------------- NPC INTERRUPT | EVENTS ---------------------------------------------- | #


npc_interrupt_fishermen_events:
	######################################
	# |------- event properties -------| #
	######################################
	type: world
	debug: false
	events:
		#################################################
		# |------- player join npc range check -------| #
		#################################################
		after player joins:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if ( <player.gamemode> == 'spectator' || <player.has_effect[INVISIBILITY]> ) && ( not <[npc].flag[ignored].contains[<player>]> ):
						- flag <[npc]> ignored:->:<player>
						- if <player.flag[flag_proximity]>:
							- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Ignoring: <aqua><[npc].flag[ignored].size>"
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>" silent
						- execute as_server "npc stopfishing" silent
						- flag <[npc]> interrupted:true
					- if <player.flag[flag_proximity]>:
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Interrupted: <aqua><[npc].flag[interrupted]>"
		
		##################################################
		# |------- player leave npc range check -------| #
		##################################################
		on player quits:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if ( <[npc].flag[ignored].contains[<player>]> ):
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
						- execute as_server "npc select <[npc].id>" silent
						- execute as_server "npc fish" silent
						- flag <[npc]> interrupted:false
		
		#########################################################
		# |------- player invisibility npc range check -------| #
		#########################################################	
		after player consumes potion:
			- if <player.has_effect[INVISIBILITY]>:
				- wait 1s
				- if not <player.location.find_npcs_within[5].is_empty>:
					- foreach <player.location.find_npcs_within[5]> as:npc:
						- if not <[npc].flag[ignored].contains[<player>]>:
							- flag <[npc]> ignored:->:<player>
						- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
							- execute as_server "npc select <[npc].id>" silent
							- execute as_server "npc fish" silent
							- flag <[npc]> interrupted:false
						- if <player.flag[flag_proximity]>:
							- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Interrupted: <aqua><[npc].flag[interrupted]>"
							- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Ignoring: <aqua><[npc].flag[ignored].size>"
		
		######################################################
		# |------- player spectator npc range check -------| #
		######################################################
		after player changes gamemode to spectator:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if not <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:->:<player>
					- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
						- execute as_server "npc select <[npc].id>" silent
						- execute as_server "npc fish" silent
						- flag <[npc]> interrupted:false
					- if <player.flag[flag_proximity]>:
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Interrupted: <aqua><[npc].flag[interrupted]>"
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Ignoring: <aqua><[npc].flag[ignored].size>"
		
		#####################################################
		# |------- player creative npc range check -------| #
		#####################################################	
		after player changes gamemode to creative:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>" silent
						- execute as_server "npc stopfishing" silent
						- flag <[npc]> interrupted:true
					- if <player.flag[flag_proximity]>:
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Interrupted: <aqua><[npc].flag[interrupted]>"
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Ignoring: <aqua><[npc].flag[ignored].size>"
		
		#####################################################
		# |------- player survival npc range check -------| #
		#####################################################
		after player changes gamemode to survival:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>" silent
						- execute as_server "npc stopfishing" silent
						- flag <[npc]> interrupted:true
					- if <player.flag[flag_proximity]>:
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Interrupted: <aqua><[npc].flag[interrupted]>"
						- narrate "<gray>[<aqua><bold>NPC.<[npc].id><gray>] <white>Ignoring: <aqua><[npc].flag[ignored].size>"



# | ---------------------------------------------- NPC INTERRUPT | COMMANDS ---------------------------------------------- | #

