


# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



npc_interrupt_handlers:
	###################################
	# |------- event handler -------| #
	###################################
	type: world
	debug: false
	events:
		#####################################
		# |------- presence events -------| #
		#####################################
		after player joins:
			- ratelimit <player> 1t
			# |------- proximity check -------| #
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					# |------- dependency check -------| #
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						# |------- ignore check -------| #
						- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:->:<player>
						- else:
							- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
							# |------- flag data -------| #
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							# |------- state check -------| #
							- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
								# |------- interrupt npc -------| #
								- choose <[type]>:
									- case navigating:
										- pause waypoints
										- pause activity
										- if not ( <npc.lookclose> ):
											- lookclose <npc> true
										- flag <npc> interrupted:true
									- case fishing:
										- fish stop
										- flag <npc> interrupted:true
							- customevent id:npc_interrupt_proximity_event
		
		on player quits:
			- ratelimit <player> 1t
			# |------- proximity check -------| #
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ) && ( not <player.has_flag[npce_fishing_select_mode]> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					# |------- dependency check -------| #
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						# |------- ignored check -------| #
						- if ( <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:<-:<player>
						- else:
							- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
							# |------- flag data -------| #
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							# |------- state check -------| #
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								# |------- resume npc -------| #
								- choose <[type]>:
									- case navigating:
										- resume waypoints
										- resume activity
										- if ( <npc.lookclose> ):
											- lookclose <npc> false
										- look yaw:<npc.eye_location.yaw> pitch:0.0
										- flag <npc> interrupted:false
									- case fishing:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false

		on player flagged:npce_fishing_select_mode quits:
			- ratelimit <player> 1t
			# |------- flag check -------| #
			- if ( <player.has_flag[npce_fishing_select_mode].if_null[false]> ):
				# |------- event data -------| #
				- adjust <queue> linked_npc:<player.flag[npce_fishing_select_mode]>
				- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]||null>
				# |------- cancel queue -------| #
				- foreach <script[npc_interrupt_fishing].queues> as:queue:
					- if ( <[queue].player> == <player> ):
						- queue <[queue]> clear
						- flag <npc> type:!
						- flag <npc> interrupted:!
						- flag <npc> ignored:!
						- flag <player> npce_fishing_select_mode:!
						- lookclose <npc> true range:5
						- bossbar remove id:npc_interrupt_fishermen
						- assignment remove script:<[queue].script.name> to:<npc>

		#####################################
		# |------- gamemode events -------| #
		#####################################
		after player flagged:npce_fishing_select_mode changes gamemode to spectator:
			- ratelimit <player> 1t
			# |------- flag check -------| #
			- if ( <player.has_flag[npce_fishing_select_mode].if_null[false]> ):
				# |------- event data -------| #
				- adjust <queue> linked_npc:<player.flag[npce_fishing_select_mode]>
				- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]||null>
				# |------- cancel queue -------| #
				- foreach <script[npc_interrupt_fishing].queues> as:queue:
					- if ( <[queue].player> == <player> ):
						- queue <[queue]> clear
						- flag <npc> type:!
						- flag <npc> interrupted:!
						- flag <npc> ignored:!
						- flag <player> npce_fishing_select_mode:!
						- lookclose <npc> true range:5
						- bossbar remove id:npc_interrupt_fishermen
						- narrate "<[prefix]> <&c>Fishing location selection <&f>cancelled<&c>."
						- assignment remove script:<[queue].script.name> to:<npc>
		
		after player changes gamemode to spectator:
			- ratelimit <player> 1t
			# |------- proximity check -------| #
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ) && ( not <player.has_flag[npce_fishing_select_mode]> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					# |------- dependency check -------| #
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						# |------- ignored check -------| #
						- if not ( <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:->:<player>
						- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
						# |------- flag data -------| #
						- define type <npc.flag[type]>
						- define interrupted <npc.flag[interrupted]>
						- define ignored <npc.flag[ignored]>
						- define nearby <npc.location.find_players_within[5]>
						# |------- state check -------| #
						- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
							# |------- resume npc -------| #
							- choose <[type]>:
								- case navigating:
									- resume waypoints
									- resume activity
									- if ( <npc.lookclose> ):
										- lookclose <npc> false
									- look yaw:<npc.eye_location.yaw> pitch:0.0
									- flag <npc> interrupted:false
								- case fishing:
									- fish <npc.cursor_on>
									- flag <npc> interrupted:false
						- customevent id:npc_interrupt_proximity_event

		after player changes gamemode to survival||adventure||creative:
			- ratelimit <player> 1t
			# |------- proximity check -------| #
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					# |------- dependency check -------| #
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						# |------- ignored check -------| #
						- if ( <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:<-:<player>
						- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
						# |------- flag data -------| #
						- define type <npc.flag[type]>
						- define interrupted <npc.flag[interrupted]>
						- define ignored <npc.flag[ignored]>
						- define nearby <npc.location.find_players_within[5]>
						# |------- state check -------| #
						- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
							# |------- interrupt npc -------| #
							- choose <[type]>:
								- case navigating:
									- pause waypoints
									- pause activity
									- if not ( <npc.lookclose> ):
										- lookclose <npc> true
									- flag <npc> interrupted:true
								- case fishing:
									- fish stop
									- flag <npc> interrupted:true
						- customevent id:npc_interrupt_proximity_event

		###################################
		# |------- effect events -------| #
		###################################
		after player flagged:npce_fishing_select_mode consumes potion:
			- ratelimit <player> 1t
			# |------- validate effect -------| #
			- if <player.has_effect[INVISIBILITY]>:
				# |------- flag check -------| #
				- if ( <player.has_flag[npce_fishing_select_mode].if_null[false]> ):
					# |------- event data -------| #
					- adjust <queue> linked_npc:<player.flag[npce_fishing_select_mode]>
					- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]||null>
					# |------- cancel queue -------| #
					- foreach <script[npc_interrupt_fishing].queues> as:queue:
						- if ( <[queue].player> == <player> ):
							- queue <[queue]> clear
							- flag <npc> type:!
							- flag <npc> interrupted:!
							- flag <npc> ignored:!
							- flag <player> npce_fishing_select_mode:!
							- lookclose <npc> true range:5
							- bossbar remove id:npc_interrupt_fishermen
							- narrate "<[prefix]> <&c>Fishing location selection <&f>cancelled<&c>."
							- assignment remove script:<[queue].script.name> to:<npc>
		
		after player consumes potion:
			- ratelimit <player> 1t
			# |------- validate effect -------| #
			- if <player.has_effect[INVISIBILITY]>:
				# |------- proximity check -------| #
				- define in_range <player.location.find_npcs_within[5]>
				- if not ( <[in_range].is_empty> ) && ( not <player.has_flag[npce_fishing_select_mode]> ):
					- foreach <[in_range]> as:npc:
						- adjust <queue> linked_npc:<[npc]>
						# |------- dependency check -------| #
						- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
							# |------- ignored check -------| #
							- if not ( <npc.flag[ignored].contains[<player>]> ):
								- flag <npc> ignored:->:<player>
							- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
							# |------- flag data -------| #
							- define type <npc.flag[type]>
							- define interrupted <npc.flag[interrupted]>
							- define ignored <npc.flag[ignored]>
							- define nearby <npc.location.find_players_within[5]>
							# |------- state check -------| #
							- if ( <[interrupted].equals[true]> && <[nearby].exclude[<[ignored]>].size.equals[0]> ) || ( <[interrupted].equals[true]> ) && ( <[ignored].is_empty> && <[nearby].is_empty> ):
								# |------- resume npc -------| #
								- choose <[type]>:
									- case navigating:
										- resume waypoints
										- resume activity
										- if ( <npc.lookclose> ):
											- lookclose <npc> false
										- look yaw:<npc.eye_location.yaw> pitch:0.0
										- flag <npc> interrupted:false
									- case fishing:
										- fish <npc.cursor_on>
										- flag <npc> interrupted:false
							- customevent id:npc_interrupt_proximity_event

		after player potion effects cleared|removed:
			- ratelimit <player> 1t
			# |------- proximity check -------| #
			- define in_range <player.location.find_npcs_within[5]>
			- if not ( <[in_range].is_empty> ) && ( <context.effect_type> == INVISIBILITY ):
				- foreach <[in_range]> as:npc:
					- adjust <queue> linked_npc:<[npc]>
					# |------- dependency check -------| #
					- if ( <npc.has_flag[type]> ) && ( <npc.has_flag[interrupted]> ) && ( <npc.has_flag[ignored]> ):
						# |------- ignored check -------| #
						- if ( <npc.flag[ignored].contains[<player>]> ):
							- flag <npc> ignored:<-:<player>
						- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
						# |------- flag data -------| #
						- define type <npc.flag[type]>
						- define interrupted <npc.flag[interrupted]>
						- define ignored <npc.flag[ignored]>
						- define nearby <npc.location.find_players_within[5]>
						# |------- state check -------| #
						- if ( <[nearby].exclude[<player>].equals[<[ignored]>]> ) && ( not <[interrupted]> ):
							# |------- interrupt npc -------| #
							- choose <[type]>:
								- case navigating:
									- pause waypoints
									- pause activity
									- if not ( <npc.lookclose> ):
										- lookclose <npc> true
									- flag <npc> interrupted:true
								- case fishing:
									- fish stop
									- flag <npc> interrupted:true
						- customevent id:npc_interrupt_proximity_event

		###################################
		# |------- custom events -------| #
		###################################
		on custom event id:npc_interrupt_proximity_event:
			# |------- interrupt data -------| #
			- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[proximity]||null>
			- define permission <player.has_permission[<script[citizens_editor_config].data_key[permissions].get[use-command]>].global.if_null[false]>
			# |------- view npc interrupt data -------| #
			- if ( <player.flag[npce_debug_mode].if_null[false]> ):
				- if ( <[permission]> ):
					- if ( <npc.has_flag[type]> ) || ( <npc.has_flag[interrupted]> ) || ( <npc.has_flag[ignored]> ):
						- narrate "<&nl><[prefix]> <&f>Type: <&b><npc.flag[type]>"
						- narrate "<[prefix]> <&f>Interrupted: <&b><npc.flag[interrupted]>"
						- narrate "<[prefix]> <&f>Ignoring: <&b><npc.flag[ignored].size>"
					- else:
						# |------- null container -------| #
						- narrate "<[prefix]> <&c>The target does not have the required <&f>flags <&c>to view <&f>proximity <&c>data."
				- else:
					# |------- unauthorized -------| #
					- narrate "<[prefix]> <&c>You do not have permission to use npc editor's <&f>debug <&c>mode."
					- stop

		on npc assigned:npc_interrupt_fishing|npc_interrupt_navigating stuck:
			- narrate "<npc.id> is stuck"
			- if ( <context.action> == NONE ):
				- narrate "NPC Stuck, teleport set to false."
				- adjust <npc> teleport_on_stuck:true
				- narrate "NPC Stuck, teleport set to true."
				- wait 10s
				- adjust <npc> teleport_on_stuck:false
				- narrate "NPC Stuck, teleport set to false."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


