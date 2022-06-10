


# | ---------------------------------------------- CITIZENS EDITOR | ASSIGNMENTS ---------------------------------------------- | #



npc_interrupt_navigating:
	#######################################
	# |------- assignment script -------| #
	#######################################
	type: assignment
	debug: false
	actions:
		on assignment:
			- ratelimit <player> 1t
			# |------- dependency check -------| #
			- inject npc_interrupt_dependency_check
			# |------- set default flags -------| #
			- flag <npc> type:<[npc_type]>
			- flag <npc> interrupted:false
			- flag <npc> ignored:!|:<list[]>
			# |------- set triggers -------| #
			- trigger name:proximity state:true radius:5
			# |------- proximity check -------| #
			- define in_range <npc.location.find_players_within[5]>
			- if ( <[in_range].is_empty> ):
				# |------- resume navigating -------| #
				- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
				- resume waypoints
				- resume activity
				- if ( <npc.lookclose> ):
					- lookclose <npc> false
				- look yaw:<npc.eye_location.yaw> pitch:0.0
				- flag <npc> interrupted:false
			- else if not ( <[in_range].is_empty> ):
				# |------- ignore check -------| #
				- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
				- else:
					- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
					# |------- state check -------| #
					- if ( <[in_range].exclude[<player>].equals[<npc.flag[ignored]>]> ) && ( not <npc.flag[interrupted]> ):
						# |------- interrupt navigating -------| #
						- pause waypoints
						- pause activity
						- flag <npc> interrupted:true
						- if not ( <npc.lookclose> ):
							- lookclose <npc> true

		on enter proximity:
			- ratelimit <player> 1t
			# |------- ignore check -------| #
			- if ( <player.gamemode.equals[spectator]> ) || ( <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
			# |------- state check -------| #
			- else if ( not <npc.flag[ignored].contains[<player>]> ) && ( not <npc.flag[interrupted]> ):
				# |------- interrupt navigating -------| #
				- pause waypoints
				- pause activity
				- if not ( <npc.lookclose> ):
					- lookclose <npc> true
				- flag <npc> interrupted:true
			- customevent id:npc_interrupt_proximity_event
		
		on exit proximity:
			- ratelimit <player> 1t
			# |------- ignored check -------| #
			- if ( <npc.flag[ignored].contains[<player>]> ):
				- flag <npc> ignored:<-:<player>
			- else:
				- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
				# |------- flag data -------| #
				- define type <npc.flag[type]>
				- define interrupted <npc.flag[interrupted]>
				- define ignored <npc.flag[ignored]>
				- define in_range <npc.location.find_players_within[5]>
				# |------- state check -------| #
				- if ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].is_empty> ) || ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].equals[<[ignored]>]> ):
					# |------- resume navigating -------| #
					- resume waypoints
					- resume activity
					- if ( <npc.lookclose> ):
						- lookclose <npc> false
					- look yaw:<npc.eye_location.yaw> pitch:0.0
					- flag <npc> interrupted:false
			- customevent id:npc_interrupt_proximity_event



# | ------------------------------------------------------------------------------------------------------------------------------ | #



npc_interrupt_fishing:
	#######################################
	# |------- assignment script -------| #
	#######################################
    type: assignment
    debug: false
    actions:
		on assignment:
			- ratelimit <player> 1t
			# |------- assignment data -------| #
			- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]||null>
			- define npc_type fishing
			# |------- ignore check -------| #
			- if ( not <player.gamemode.equals[spectator]> ) && ( not <player.has_effect[INVISIBILITY]> ):
				# |------- dependency check -------| #
				- inject npc_interrupt_dependency_check
				# |------- set default flags -------| #
				- flag <npc> type:<[npc_type]>
				- flag <npc> interrupted:false
				- flag <npc> ignored:!|:<list[]>
				# |------- select data -------| #
				- define timeout <script[citizens_editor_config].data_key[interrupt.fishermen].get[select-location-timeout]||null>
				- define count <[timeout]>
				- define buffer 0
				- define valid false
				- lookclose <npc> true range:15
				# |------- select location -------| #
				- if ( not <player.has_flag[npce_fishing_select_mode]> ):
					- flag <player> npce_fishing_select_mode:<npc>
				- title title:<&b><&l>Stand<&sp>in<&sp>Water subtitle:<&d><&l>to<&sp>select<&sp>a<&sp>fishing<&sp>location stay:5s fade_in:3s fade_out:3s targets:<player>
				- while ( true ):
					# |------- location data -------| #
					- define location <player.location.if_null[null]>
					- define nearby <player.location.find_npcs_within[15].contains[<npc>]>
					- define buffer:++
					# |------- display countdown -------| #
					- if ( <[loop_index]> == 1 ):
						- bossbar create id:npc_interrupt_fishermen players:<player> progress:0 color:green style:solid
					- if ( <[buffer]> == 20 ):
						- if ( <[location].material> == <material[water]> ) && ( <[nearby]> ):
							- bossbar update id:npc_interrupt_fishermen title:<&b><&l>Location:<&sp><&a><&l>valid<&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:1 color:green
						- else:
							- bossbar update id:npc_interrupt_fishermen title:<&b><&l>Location:<&sp><&c><&l>invalid<&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
						- define count:--
						- define buffer 0
					# |------- cycle check -------| #
					- if ( not <[valid]> ) && ( <[loop_index]> <= <[timeout].mul_int[20]> ):
						# |------- validate location -------| #
						- if ( <[location].equals[null]> ):
							- wait 1t
							- while next
						- else if ( <[location].material> == <material[water]> ):
							# |------- display location -------| #
							- debugblock <[location].above> color:green alpha:1.0 d:2t
							- wait 1t
							- while next
						- else:
							- wait 1t
							- while next
					- else:
						# |------- finalize selection -------| #
						- if ( <[location].material> == <material[water]> ) && ( <[nearby]> ):
							- define valid true
							- wait 1s
							- bossbar update id:npc_interrupt_fishermen title:<&b><&l>Location:<&sp><&a><&l>valid<&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:1 color:green
						- else:
							- define valid false
							- wait 1s
							- bossbar update id:npc_interrupt_fishermen title:<&b><&l>Location:<&sp><&c><&l>invalid<&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
						- wait 1s
						- bossbar remove id:npc_interrupt_fishermen
						- while stop
				# |------- validation check -------| #
				- if ( <[valid]> ):
					# |------- set pose -------| #
					- pose add id:<[npc_type]> <npc> <npc.location>
					- execute as_server "npc select <npc.id>" silent
					- execute as_server "npc pose --default <[npc_type]>" silent
					# |------- set triggers -------| #
					- trigger name:proximity state:true radius:5
					- title title:<&b><&l>Fishing<&sp>Location subtitle:<&a><&l>successfully<&sp>selected stay:3s fade_in:3s fade_out:3s targets:<player>
					# |------- proximity check -------| #
					- define in_range <npc.location.find_players_within[5]>
					- if ( <[in_range].is_empty> ):
						# |------- resume npc -------| #
						- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
						- fish <npc.cursor_on>
					- else if not ( <[in_range].is_empty> ):
						# |------- ignore check -------| #
						- if ( <player.gamemode.equals[spectator]> || <player.has_effect[INVISIBILITY]> ) && ( not <npc.flag[ignored].contains[<player>]> ):
							# |------- resume npc -------| #
							- flag <npc> ignored:->:<player>
							- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
							- fish <npc.cursor_on>
						# |------- state check -------| #
						- else if ( <[in_range].exclude[<player>].equals[<npc.flag[ignored]>]> ) && ( not <npc.flag[interrupted]> ):
							# |------- interrupt npc -------| #
							- flag <npc> interrupted:true
					# |------- assignment cleanup -------| #
					- flag <player> npce_fishing_select_mode:!
					- lookclose <npc> true range:5
					- customevent id:npc_interrupt_proximity_event
				- else:
					- flag <npc> type:!
					- flag <npc> interrupted:!
					- flag <npc> ignored:!
					- flag <player> npce_fishing_select_mode:!
					- lookclose <npc> true range:5
					- title title:<&b><&l>Invalid<&sp>Location subtitle:<&c><&l>you<&sp>must<&sp>stand<&sp>in<&sp>a<&sp>water<&sp>source stay:3s fade_in:3s fade_out:3s targets:<player>
					- narrate "<[prefix]> <&c>You were not located in a valid <&f>water <&c>source."
					- assignment remove script:<script.name>
			- else:
				- assignment remove script:<script.name> to:<npc>
				- narrate "<[prefix]> <&c>You cannot set a <&f>fishermen <&c>assignment while invisible."

		on enter proximity:
			- ratelimit <player> 1t
			# |------- ignore check -------| #
			- if ( <player.gamemode.equals[spectator]> ) || ( <player.has_effect[INVISIBILITY]> ):
				- if ( not <npc.flag[ignored].contains[<player>]> ):
					- flag <npc> ignored:->:<player>
			# |------- state check -------| #
			- else if ( not <npc.flag[ignored].contains[<player>]> ) && ( not <npc.flag[interrupted]> ):
				# |------- interrupt fishermen -------| #
				- fish stop
				- flag <npc> interrupted:true
			- customevent id:npc_interrupt_proximity_event
		
		on exit proximity:
			- ratelimit <player> 1t
			# |------- ignored check -------| #
			- if ( <npc.flag[ignored].contains[<player>]> ):
				- flag <npc> ignored:<-:<player>
			- else:
				- wait <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]||1s>
				# |------- flag data -------| #
				- define type <npc.flag[type]>
				- define interrupted <npc.flag[interrupted]>
				- define ignored <npc.flag[ignored]>
				- define in_range <npc.location.find_players_within[5]>
				# |------- state check -------| #
				- if ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].is_empty> ) || ( <[interrupted].equals[true]> && not <[ignored].contains[<player>]> && <[in_range].equals[<[ignored]>]> ):
					# |------- resume fishermen -------| #
					- fish <npc.cursor_on>
					- flag <npc> interrupted:false
			- customevent id:npc_interrupt_proximity_event



# | ------------------------------------------------------------------------------------------------------------------------------ | #


