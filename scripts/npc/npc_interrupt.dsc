

# | ---------------------------------------------- NPC INTERRUPT | DATA --------------------------------------------- | #


npc_interrupt_config:
	######################################
	# |------- interrupt config -------| #
	######################################
	type: data
	prefixes:
		# | --- prefixes --- | #
		main: "<&7>[<&b><&l>NPC.<npc.id><&7>]"
	# | --- default pose --- | #
	pose: static
	# | --- compatible scripts --- | #
	scripts:
		# | --- flag editor by HollowTheSilver --- | #
		- flag_editor_command
		


# | ---------------------------------------------- NPC INTERRUPT | ASSIGNMENTS ---------------------------------------------- | #


npc_interrupt_fishermen:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: true
    actions:
		on assignment:
			######################################
			# |------- dependency check -------| #
			######################################
			- define npc_type fishermen
			- inject npc_interrupt_dependency_check
			#################################
			# |------- define data -------| #
			#################################
			- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
			- define pose <script[npc_interrupt_config].data_key[pose]||null>
			################################
			# |------- pose check -------| #
			################################
			- if ( <npc.has_pose[<[pose]>]> ):
				##################################
				# |------- set defaults -------| #
				##################################
				# | --- these server commands prevent errors relating to unset default pose --- | #
				- execute as_server "npc select <npc.id>" silent
				- execute as_server "npc pose --default <[pose]>" silent
				- trigger name:proximity state:true radius:5
				- lookclose <npc> true
				#####################################
				# |------- proximity check -------| #
				#####################################
				- define in_range <npc.location.find_players_within[5]>
				- if ( <[in_range].is_empty> ):
					- wait 1s
					- fish <npc.cursor_on>
				- else if not ( <[in_range].is_empty> ):
					- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
						- flag <npc> ignored:->:<player>
						- wait 1s
						- fish <npc.cursor_on>
					- else if ( <[in_range].exclude[<player>].equals[<npc.flag[ignored]>]> ) && ( not <npc.flag[interrupted]> ):
						- flag <npc> interrupted:true
			- else:
				- narrate "<[prefix]> <&c>This NPC does not have the required <&f><[pose]> <&c>pose. Please add the pose and try again."
				- assignment remove script:<script.name>

		on enter proximity:
			#################################
			# |------- define data -------| #
			#################################
			- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
			#########################################
			# |------- interrupt fishermen -------| #
			#########################################
			- if ( <player.gamemode.equals[spectator]> ) || ( <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
			- else if ( not <npc.flag[ignored].contains[<player>]> ) && ( not <npc.flag[interrupted]> ):
				- fish stop
				- flag <npc> interrupted:true
			- if ( <player.flag[flag_proximity]> ):
				- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
				- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
				- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"
		
		on exit proximity:
			- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
			- if ( <npc.flag[ignored].contains[<player>]> ):
				- flag <npc> ignored:<-:<player>
			- else:
				#################################
				# |------- define data -------| #
				#################################
				- wait 1s
				- define type <npc.flag[type]>
				- define interrupted <npc.flag[interrupted]>
				- define ignored <npc.flag[ignored]>
				- define in_range <npc.location.find_players_within[5]>
				######################################
				# |------- resume fishermen -------| #
				######################################
				- if ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].is_empty> ) || ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].equals[<[ignored]>]> ):
					- fish <npc.cursor_on>
					- flag <npc> interrupted:false
			- if ( <player.flag[flag_proximity]> ):
				- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
				- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
				- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #


npc_interrupt_guard:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: false
    actions:
		on assignment:
		################################
		# |------- Placholder -------| #
		################################
			- narrate placeholder



# | ---------------------------------------------- NPC INTERRUPT | EVENTS ---------------------------------------------- | #


npc_interrupt_fishermen_events:
	######################################
	# |------- event properties -------| #
	######################################
	type: world
	debug: false
	events:
		after player joins:
			###############################################
			# |------- npc range interrupt check -------| #
			###############################################
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:->:<player>
						- else:
							#################################
							# |------- define data -------| #
							#################################
							- wait 1s
							- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							###################################
							# |------- interrupt npc -------| #
							###################################
							- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
								- choose <[type]>:
									- case null:
										- narrate placeholder
									- case fishermen:
										- fish stop
										- flag <npc> interrupted:true
							- if ( <player.flag[flag_proximity]> ):
								- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
								- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
								- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"
		
		on player quits:
			############################################
			# |------- npc range resume check -------| #
			############################################
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						- if ( <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:<-:<player>
						- else:
							#################################
							# |------- define data -------| #
							#################################
							- wait 1s
							- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case fishermen:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
			
		after player consumes potion:
			############################################
			# |------- npc range resume check -------| #
			############################################
			- if <player.has_effect[INVISIBILITY]>:
				- define in_range <player.location.find_npcs_within[5]>
				- if not ( <[in_range].is_empty> ):
					- foreach <[in_range]> as:npc:
						- adjust <queue> linked_npc:<[npc]>
						- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
							- if not ( <npc.flag[ignored].contains[<player>]> ):
								- flag <npc> ignored:->:<player>
							#################################
							# |------- define data -------| #
							#################################
							- wait 1s
							- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case fishermen:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
							- if ( <script[flag_editor_command].exists> ):
								- if ( <player.flag[flag_proximity]> ):
									- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
									- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
									- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"

		after player changes gamemode:
			- define gamemode <player.gamemode>
			- if ( <[gamemode].equals[spectator]> ):
				############################################
				# |------- npc range resume check -------| #
				############################################
				- define in_range <player.location.find_npcs_within[5]>
				- if not ( <[in_range].is_empty> ):
					- foreach <[in_range]> as:npc:
						- adjust <queue> linked_npc:<[npc]>
						- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
							- if not ( <npc.flag[ignored].contains[<player>]> ):
								- flag <npc> ignored:->:<player>
							#################################
							# |------- define data -------| #
							#################################
							- wait 1s
							- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case fishermen:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
							- if ( <script[flag_editor_command].exists> ):
								- if ( <player.flag[flag_proximity]> ):
									- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
									- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
									- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"
			- else if ( <[gamemode].equals[survival]> ) ||  ( <[gamemode].equals[adventure]> ) || ( <[gamemode].equals[creative]> ):
				###############################################
				# |------- npc range interrupt check -------| #
				###############################################
				- define in_range <player.location.find_npcs_within[5]>
				- if not ( <[in_range].is_empty> ):
					- foreach <[in_range]> as:npc:
						- adjust <queue> linked_npc:<[npc]>
						- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
							- if ( <npc.flag[ignored].contains[<player>]> ):
								- flag <npc> ignored:<-:<player>
							#################################
							# |------- define data -------| #
							#################################
							- wait 1s
							- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							###################################
							# |------- interrupt npc -------| #
							###################################
							- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
								- choose <npc.flag[type].if_null[null]>:
									- case null:
										- narrate placeholder
									- case fishermen:
										- fish stop
										- flag <npc> interrupted:true
							- if ( <player.flag[flag_proximity]> ):
								- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
								- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
								- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"



# | ---------------------------------------------- NPC INTERRUPT | TASKS ---------------------------------------------- | #


npc_interrupt_dependency_check:
	type: task
	debug: false
	script:
		#################################
		# |------- define data -------| #
		#################################
		- define prefix <script[npc_interrupt_config].parsed_key[prefixes].get[main]||null>
		- define scripts <script[npc_interrupt_config].data_key[scripts]||null>

		##################################
		# |------- script check -------| #
		##################################
		- if not ( <[scripts].equals[null]> ):
			- define loaded <list[]>
			- foreach <[scripts]> as:script:
				- if ( <[script].equals[<empty>]> ) || ( <[script].equals[null]> ) || ( not <script[<[script]>].exists> ):
					- foreach next
				- else:
					- define script_path <script[<[script]>].relative_filename>
					- if ( <server.has_file[<[script_path]>].if_null[false]> ):
						- define loaded:->:<[script]>

		#######################################
		# |------- set default flags -------| #
		#######################################
		- if not ( <npc.has_flag[type]> ):
			- flag <npc> type:<[npc_type]>
		- if not ( <npc.has_flag[interrupted]> ):
			- flag <npc> interrupted:false
		- if not ( <npc.has_flag[ignored]> ):
			- flag <npc> ignored:!|:<list[]>

		########################################
		# |------- set external flags -------| #
		########################################
		- if not ( <[loaded].is_empty> ):
			- foreach <[loaded]> as:script:
				- choose <[script]>:
					- case flag_editor_command:
						####################################################
						# |------- flag editor by HollowTheSilver -------| #
						####################################################
						- if not ( <npc.has_flag[private_flags]> ):
							- flag <npc> private_flags:!|:<list[public_flags|private_flags|fragile_flags]>
						- if not ( <npc.has_flag[public_flags]> ):
							- flag <npc> public_flags:!|:<list[]>
							- if not ( <npc.flag[private_flags].contains[public_flags].if_null[true]> ):
								- flag <npc> private_flags:->:public_flags
						- if not ( <npc.has_flag[fragile_flags]> ):
							- flag <npc> fragile_flags:!|:<list[]>
							- if not ( <npc.flag[private_flags].contains[fragile_flags].if_null[true]> ):
								- flag <npc> private_flags:->:fragile_flags
						- if not ( <npc.flag[public_flags].contains[type].if_null[true]> ):
							- flag <npc> public_flags:->:type
						- if not ( <npc.flag[public_flags].contains[interrupted].if_null[true]> ):
							- flag <npc> public_flags:->:interrupted
						- if not ( <npc.flag[public_flags].contains[ignored].if_null[true]> ):
							- flag <npc> public_flags:->:ignored
					
					- case compatible_script_id:
						#################################################################################
						# |-------  You can set custom configured script flag conditions here. -------| #
						# |-------                                                             -------| #
						# |-------  The case needs to match the script id and the id must be   -------| #
						# |-------  listed under the scripts section in the interrupt config.  -------| #
						#################################################################################
						- narrate "your external script conditions here..."
		


# | ---------------------------------------------- NPC INTERRUPT | COMMANDS ---------------------------------------------- | #

