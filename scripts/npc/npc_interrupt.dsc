

# | ---------------------------------------------- NPC INTERRUPT | DATA --------------------------------------------- | #


npc_interrupt_config:
	######################################
	# |------- interrupt config -------| #
	######################################
	type: data
	prefixes:
		# | --- prefixes --- | #
		ID: "<&7>[<&b><&l>NPC.<npc.id><&7>]"
	# | --- default pose --- | #
	pose-id: static
	# | --- compatible scripts --- | #
	scripts:
		# | --- flag editor by HollowTheSilver --- | #
		- flag_editor_command
		


# | ---------------------------------------------- NPC INTERRUPT | ASSIGNMENTS ---------------------------------------------- | #



npc_interrupt_navigating:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: false
    actions:
		on assignment:
			######################################
			# |------- dependency check -------| #
			######################################
			- define npc_type navigating
			- inject npc_interrupt_dependency_check
			- trigger name:proximity state:true radius:5
			#####################################
			# |------- proximity check -------| #
			#####################################
			- define in_range <npc.location.find_players_within[5]>
			- if not ( <[in_range].is_empty> ):
				- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
				- else:
					- wait 1s
					- if ( <[in_range].exclude[<player>].equals[<npc.flag[ignored]>]> ) && ( not <npc.flag[interrupted]> ):
						- pause waypoints
						- flag <npc> interrupted:true
						- if not ( <npc.lookclose> ):
							- lookclose <npc> true

		on enter proximity:
			##########################################
			# |------- interrupt navigating -------| #
			##########################################
			- if ( <player.gamemode.equals[spectator]> ) || ( <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
			- else if ( not <npc.flag[ignored].contains[<player>]> ) && ( not <npc.flag[interrupted]> ):
				- pause waypoints
				- if not ( <npc.lookclose> ):
					- lookclose <npc> true
				- flag <npc> interrupted:true
			- if ( <script[flag_editor_command].exists> ):
				- customevent id:npc_interrupt_proximity_event
		
		on exit proximity:
			- if ( <npc.flag[ignored].contains[<player>]> ):
				- flag <npc> ignored:<-:<player>
			- else:
				###############################
				# |------- flag data -------| #
				###############################
				- wait 1s
				- define type <npc.flag[type]>
				- define interrupted <npc.flag[interrupted]>
				- define ignored <npc.flag[ignored]>
				- define in_range <npc.location.find_players_within[5]>
				#######################################
				# |------- resume navigating -------| #
				#######################################
				- if ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].is_empty> ) || ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].equals[<[ignored]>]> ):
					- resume waypoints
					- if ( <npc.lookclose> ):
						- lookclose <npc> false
					- look yaw:<npc.eye_location.yaw> pitch:0.0
					- flag <npc> interrupted:false
			- if ( <script[flag_editor_command].exists> ):
				- customevent id:npc_interrupt_proximity_event



# | ------------------------------------------------------------------------------------------------------------------------------ | #



npc_interrupt_fishing:
	###########################################
	# |------- assignment properties -------| #
	###########################################
    type: assignment
    debug: false
    actions:
		on assignment:
			######################################
			# |------- dependency check -------| #
			######################################
			- define npc_type fishing
			- inject npc_interrupt_dependency_check
			#################################
			# |------- define data -------| #
			#################################
			- define pose <script[npc_interrupt_config].data_key[pose-id]||null>
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
				- if not ( <npc.lookclose> ):
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
				- narrate "<[prefix]> <&c>This NPC does not have the required <&f>'<[pose]>' <&c>pose. Please add the pose and try again."
				- assignment remove script:<script.name>

		on enter proximity:
			#########################################
			# |------- interrupt fishermen -------| #
			#########################################
			- if ( <player.gamemode.equals[spectator]> ) || ( <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
			- else if ( not <npc.flag[ignored].contains[<player>]> ) && ( not <npc.flag[interrupted]> ):
				- fish stop
				- flag <npc> interrupted:true
			- if ( <script[flag_editor_command].exists> ):
				- customevent id:npc_interrupt_proximity_event
		
		on exit proximity:
			- if ( <npc.flag[ignored].contains[<player>]> ):
				- flag <npc> ignored:<-:<player>
			- else:
				###############################
				# |------- flag data -------| #
				###############################
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
			- if ( <script[flag_editor_command].exists> ):
				- customevent id:npc_interrupt_proximity_event



# | ---------------------------------------------- NPC INTERRUPT | EVENTS ---------------------------------------------- | #



npc_interrupt_events:
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
							###############################
							# |------- flag data -------| #
							###############################
							- wait 1s
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							###################################
							# |------- interrupt npc -------| #
							###################################
							- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
								- choose <[type]>:
									- case navigating:
										- pause waypoints
										- if not ( <npc.lookclose> ):
											- lookclose <npc> true
										- flag <npc> interrupted:true
									- case fishing:
										- fish stop
										- flag <npc> interrupted:true
							- if ( <script[flag_editor_command].exists> ):
								- customevent id:npc_interrupt_proximity_event
		
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
							###############################
							# |------- flag data -------| #
							###############################
							- wait 1s
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case navigating:
										- resume waypoints
										- if ( <npc.lookclose> ):
											- lookclose <npc> false
										- look yaw:<npc.eye_location.yaw> pitch:0.0
										- flag <npc> interrupted:false
									- case fishing:
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
							###############################
							# |------- flag data -------| #
							###############################
							- wait 1s
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case navigating:
										- resume waypoints
										- if ( <npc.lookclose> ):
											- lookclose <npc> false
										- look yaw:<npc.eye_location.yaw> pitch:0.0
										- flag <npc> interrupted:false
									- case fishing:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
							- if ( <script[flag_editor_command].exists> ):
								- customevent id:npc_interrupt_proximity_event

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
							###############################
							# |------- flag data -------| #
							###############################
							- wait 1s
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							################################
							# |------- resume npc -------| #
							################################
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								- choose <[type]>:
									- case navigating:
										- resume waypoints
										- if ( <npc.lookclose> ):
											- lookclose <npc> false
										- look yaw:<npc.eye_location.yaw> pitch:0.0
										- flag <npc> interrupted:false
									- case fishing:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
							- if ( <script[flag_editor_command].exists> ):
								- customevent id:npc_interrupt_proximity_event
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
							###############################
							# |------- flag data -------| #
							###############################
							- wait 1s
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							###################################
							# |------- interrupt npc -------| #
							###################################
							- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
								- choose <npc.flag[type].if_null[null]>:
									- case navigating:
										- pause waypoints
										- if not ( <npc.lookclose> ):
											- lookclose <npc> true
										- flag <npc> interrupted:true
									- case fishing:
										- fish stop
										- flag <npc> interrupted:true
							- if ( <script[flag_editor_command].exists> ):
								- customevent id:npc_interrupt_proximity_event



# | ---------------------------------------------- NPC INTERRUPT | TASKS ---------------------------------------------- | #


npc_interrupt_dependency_check:
	type: task
	debug: false
	script:
		#################################
		# |------- define data -------| #
		#################################
		- define scripts <script[npc_interrupt_config].data_key[scripts]||null>
		- define loaded <list[]>

		##################################
		# |------- script check -------| #
		##################################
		- if not ( <[scripts].equals[null]> ):
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
		- flag <npc> type:<[npc_type]>
		- flag <npc> interrupted:false
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


