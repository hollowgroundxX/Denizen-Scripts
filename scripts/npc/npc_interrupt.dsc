

# | ---------------------------------------------- NPC.INTERRUPT | TYPE.COMMANDS ---------------------------------------------- | #


list_npc_flags:
	# |------- set command properties -------| #
	type: command
	debug: false
	name: listnpcflags
	usage: /listnpcflags
	permission: script.dev.commands
	permission message: Sorry, <player.name>, you cannot use this command because you don't have the authorized permissions.
	script:
		# |------- list nearby npc flags -------| #
		- if not <player.location.find_npcs_within[5].is_empty>:
			- foreach <player.location.find_npcs_within[5]> as:npc:
				- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
				- narrate "NPC-<[npc].id> Ignoring: <[npc].flag[ignored].size>"
		- else: 
			- narrate "No NPCs in range..."


clear_npc_flags:
	# |------- set command properties -------| #
	type: command
	debug: false
	name: clearnpcflags
	usage: /clearnpcflags
	permission: script.dev.commands
	permission message: Sorry, <player.name>, you cannot use this command because you don't have the authorized permissions.
	script:
		# |------- clear nearby npc flags -------| #
		- if not <player.location.find_npcs_within[5].is_empty>:
			- foreach <player.location.find_npcs_within[5]> as:npc:
				- flag <[npc]> interrupted:false
				- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
				- flag <[npc]> ignored:!|:li@
				- narrate "NPC-<[npc].id> Ignoring: <[npc].flag[ignored].size>"
				- if <player.has_flag[npcs_interrupted]>:
					- flag <player> npcs_interrupted:!
		- else: 
			- narrate "No NPCs in range..."



# | ---------------------------------------------- NPC.INTERRUPT | TYPE.EVENTS ---------------------------------------------- | #


npc_interrupt_fishermen_events:
	# |------- set event properties -------| #
	type: world
	debug: false
	events:
		# |------- player join npc range check -------| #				
		after player joins:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if ( <player.gamemode> == 'spectator' || <player.has_effect[INVISIBILITY]> ) && ( not <[npc].flag[ignored].contains[<player>]> ):
						- flag <[npc]> ignored:->:<player>
						- if <player.flag[hdb]>:
							- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>"
						- execute as_server "npc stopfishing"
						- flag <[npc]> interrupted:true
		
		# |------- player leave npc range check -------| #				
		on player quits:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if ( <[npc].flag[ignored].contains[<player>]> ):
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
						- execute as_server "npc select <[npc].id>"
						- execute as_server "npc fish"
						- flag <[npc]> interrupted:false
		
		# |------- player invisibility npc range check -------| #		
		after player consumes potion:
			- if <player.has_effect[INVISIBILITY]>:
				- wait 1s
				- if not <player.location.find_npcs_within[5].is_empty>:
					- foreach <player.location.find_npcs_within[5]> as:npc:
						- if not <[npc].flag[ignored].contains[<player>]>:
							- flag <[npc]> ignored:->:<player>
						- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
							- execute as_server "npc select <[npc].id>"
							- execute as_server "npc fish"
							- flag <[npc]> interrupted:false
						- if <player.flag[hdb]>:
							- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
							- narrate "NPC-<[npc].id> Ignoring: <[npc].flag[ignored].size>"
		
		# |------- player spectator npc range check -------| #
		after player changes gamemode to spectator:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if not <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:->:<player>
					- if ( <[npc].location.find_players_within[5]> == <[npc].flag[ignored]> && <[npc].flag[interrupted].is_truthy> ) || ( <[npc].flag[ignored].is_empty> && <[npc].location.find_players_within[5].is_empty> && <[npc].flag[interrupted].is_truthy> ):
						- execute as_server "npc select <[npc].id>"
						- execute as_server "npc fish"
						- flag <[npc]> interrupted:false
					- if <player.flag[hdb]>:
						- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
						- narrate "NPC-<[npc].id> Ignoring: <[npc].flag[ignored].size>"
		
		# |------- player creative npc range check -------| #			
		after player changes gamemode to creative:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>"
						- execute as_server "npc stopfishing"
						- flag <[npc]> interrupted:true
					- if <player.flag[hdb]>:
						- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"
		
		# |------- player survival npc range check -------| #				
		after player changes gamemode to survival:
			- wait 1s
			- if not <player.location.find_npcs_within[5].is_empty>:
				- foreach <player.location.find_npcs_within[5]> as:npc:
					- if <[npc].flag[ignored].contains[<player>]>:
						- flag <[npc]> ignored:<-:<player>
					- if ( <[npc].location.find_players_within[5].exclude[<player>]> == <[npc].flag[ignored]> && not <[npc].flag[interrupted]> ):
						- execute as_server "npc select <[npc].id>"
						- execute as_server "npc stopfishing"
						- flag <[npc]> interrupted:true
					- if <player.flag[hdb]>:
						- narrate "NPC-<[npc].id> Interrupted: <[npc].flag[interrupted]>"


# | ---------------------------------------------- NPC.INTERRUPT | TYPE.ASSIGNMENTS ---------------------------------------------- | #
			
				
npc_interrupt_fishermen:
	# |------- set assignment properties -------| #
    type: assignment
    debug: false
    actions:	
		# |------- set assignment triggers and defaults -------| #
		on assignment:
			- trigger name:proximity state:true radius:5
			- flag <npc> interrupted:false
			- flag <npc> ignored:!|:li@
			- lookclose <npc> false
			- pose id:static
			- fish <npc.cursor_on>
			- lookclose <npc> true
			- if <player.flag[hdb]>:
				- narrate "NPC-<npc.id> Interrupted: <npc.flag[interrupted]>"
		
		# |------- interrupt fishermen npc -------| #
		on enter proximity:
			- if ( <player.gamemode> == 'spectator' || <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
				- if <player.flag[hdb]>:
					- narrate "NPC-<npc.id> Ignoring: <npc.flag[ignored].size>"
			- if ( not <npc.flag[ignored].contains[<player>]> && not <npc.flag[interrupted]> ):
				- fish stop
				- flag <npc> interrupted:true
			- if <player.flag[hdb]>:
				- narrate "NPC-<npc.id> Interrupted: <npc.flag[interrupted]>"
		
		# |------- resume fishermen npc -------| #
		on exit proximity:
			- wait 1s
			- if ( not <npc.flag[ignored].contains[<player>]> && <npc.flag[interrupted].is_truthy> && <npc.location.find_players_within[5].is_empty> ) || ( not <npc.flag[ignored].contains[<player>]> && <npc.flag[interrupted].is_truthy> && <npc.location.find_players_within[5]> == <npc.flag[ignored]> ):
				- fish <npc.cursor_on>
				- flag <npc> interrupted:false
			- if <npc.flag[ignored].contains[<player>]>:
				- flag <npc> ignored:<-:<player>
				- if <player.flag[hdb]>:
					- narrate "NPC-<npc.id> Ignoring: <npc.flag[ignored].size>"
			- if <player.flag[hdb]>:
				- narrate "NPC-<npc.id> Interrupted: <npc.flag[interrupted]>"


# | ------------------------------------------------------------------------------------------------------------------------------ | #


