


# | ----------------------------------------------  CITIZENS EDITOR | TASKS  ---------------------------------------------- | #



citizens_editor_validate_command:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	definitions: app
	script:
		- ratelimit <player> 1t
		# |------- container check -------| #
		- if ( not <server.has_flag[citizens_editor]> ):
			- flag server citizens_editor:<map[]>
		- if ( not <player.has_flag[citizens_editor]> ):
			- flag <player> citizens_editor:<map[]>
		# |------- sub-container check -------| #
		- if ( not <player.has_flag[citizens_editor.debug_mode]> ):
			- flag <player> citizens_editor.debug_mode:false
		- if ( not <server.has_flag[citizens_editor.inventories]> ):
			- flag server citizens_editor.inventories:<list[]>
		# |------- reset flags -------| #
		- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
			- flag <player> citizens_editor.awaiting_dialog:!
		- if ( <player.has_flag[citizens_editor.awaiting_input]> ):
			- flag <player> citizens_editor.awaiting_input:!
		- if ( <player.has_flag[citizens_editor.received_input]> ):
			- flag <player> citizens_editor.received_input:!
		# |------- set settings -------| #
		- if ( not <server.has_flag[citizens_editor.settings]> ):
			- definemap default_settings:
				prefixes:
					main: <script[citizens_editor_config].parsed_key[prefixes].get[main]>
					debug: <script[citizens_editor_config].parsed_key[prefixes].get[debug]>
					npc: <script[citizens_editor_config].data_key[prefixes].get[npc]>
				permissions: <script[citizens_editor_config].data_key[permissions]>
				editor: <script[citizens_editor_config].data_key[editor]>
				dependencies: <script[citizens_editor_config].data_key[dependencies]>
				interface: <script[citizens_editor_config].data_key[interface]>
			# |------- store settings flag -------| #
			- flag server citizens_editor.settings:<[default_settings]>
		
		# |------- build inventories -------| #
		- if ( not <server.has_flag[citizens_editor.ast]> ):
			- flag server citizens_editor.ast:<[app].get_ast>
		
		# |------- validate guis -------| #
		- flag <player> citizens_editor.gui.current:<[app].get_root>
		- flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
		- flag <player> citizens_editor.gui.previous:!|:<list[<[app].get_root>]>

		# |------- validate dependency data -------| #
		- inject citizens_editor_validate_dependencies
		
		# |------- set permissions handler -------| #
		- foreach <server.flag[citizens_editor.dependencies.plugins]> as:plugin:
			- choose <[plugin]>:
				- case default:
					- foreach next
				- case UltraPermissions:
					- flag server citizens_editor.permissions_handler:<[plugin]>
					- foreach stop
				- case LuckPerms:
					- flag server citizens_editor.permissions_handler:<[plugin]>
					- foreach stop
				- case Essentials:
					- flag server citizens_editor.permissions_handler:<[plugin]>
					- foreach stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_dependencies:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	definitions: prefix
	script:
		- ratelimit <player> 1t
		# |------- define data -------| #
		- define plugins <server.flag[citizens_editor.settings.dependencies.plugins]||null>
		- define scripts <server.flag[citizens_editor.settings.dependencies.scripts]||null>
		- define loaded_plugins <list[]>
		- define loaded_scripts <list[]>

		# |------- plugin check -------| #
		- if not ( <[plugins].equals[null]> ):
			- foreach <[plugins]> as:plugin:
				- if ( <[plugin].equals[<empty>]> ) || ( <[plugin].equals[null]> ) || ( not <plugin[<[plugin]>].exists> ):
					- foreach next
				- else:
					- define listed <server.plugins.if_null[<list[]>]>
					- if ( <[listed]> contains <plugin[<[plugin]>]> ):
						- define loaded_plugins:->:<[plugin]>
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' was successfully loaded."
					- else:
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' could not be located and was subsequently skipped."

		# |------- script check -------| #
		- if not ( <[scripts].equals[null]> ):
			- foreach <[scripts]> as:script:
				- if ( <[script].equals[<empty>]> ) || ( <[script].equals[null]> ) || ( not <script[<[script]>].exists> ):
					- foreach next
				- else:
					- define script_path <script[<[script]>].relative_filename>
					- if ( <server.has_file[<[script_path]>].if_null[false]> ):
						- define loaded_scripts:->:<[script]>
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Scripts<&rb> - The script '<[script]>' was successfully loaded."
					- else:
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Scripts<&rb> - The script '<[script]>' could not be located and was subsequently skipped."
		
		# |------- set loaded dependencies -------| #
		- flag server citizens_editor.dependencies.plugins:<[loaded_plugins]>
		- flag server citizens_editor.dependencies.scripts:<[loaded_scripts]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_gui:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
    definitions: prefix|gui_name
	script:
		- ratelimit <player> 1t
        # |------- inventory data -------| #
		- define ast <server.flag[citizens_editor.ast].if_null[false]>
        - define inventories citizens_editor.inventories
		- if ( <[ast]> != null ):
			# |------- build inventory -------| #
			- foreach <[ast]> as:category:
				- if ( <[category]> contains <[gui_name]> ):
					# |------- cached data -------| #
					- define noted <server.notes[inventories].contains[<inventory[<[gui_name]>].if_null[false]>]>
					- define flagged <server.flag[<[inventories]>].contains[<[gui_name]>].if_null[false]>
					# |------- presence check -------| #
					- if ( <[flagged]> ) && ( <[noted]> ):
						# |------- delete inventory -------| #
						- flag server <[inventories]>:<-:<[gui_name]>
						- note remove as:<[gui_name]>
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[gui_name]>]>]> as:<[gui_name]>
						- flag server <[inventories]>:->:<[gui_name]>
					- else if ( not <[flagged]> ) && ( not <[noted]> ):
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[gui_name]>]>]> as:<[gui_name]>
						- flag server <[inventories]>:->:<[gui_name]>
						# |------- log message -------| #
						- narrate "<[prefix]> Inventory.<[gui_name]> successfully cached."
					- else:
						# |------- invalid inventory -------| #
						- narrate "<[prefix]> <&c>The inventory '<[gui_name]>' is not properly cached within the inventories database."
					- foreach stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_all_guis:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
    definitions: prefix
	script:
		- ratelimit <player> 1t
        # |------- inventory data -------| #
		- define ast <server.flag[citizens_editor.ast].if_null[false]>
        - define inventories citizens_editor.inventories
		- if ( <[ast]> != null ):
			- foreach <[ast]> as:category:
				- foreach <[category].keys> as:inventory:
					# |------- cached data -------| #
					- define noted <server.notes[inventories].contains[<inventory[<[inventory]>].if_null[false]>]>
					- define flagged <server.flag[<[inventories]>].contains[<[inventory]>].if_null[false]>
					# |------- presence check -------| #
					- if ( <[flagged]> ) && ( <[noted]> ):
						# |------- delete inventory -------| #
						- flag server <[inventories]>:<-:<[inventory]>
						- note remove as:<[inventory]>
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[inventory]>]>]> as:<[inventory]>
						- flag server <[inventories]>:->:<[inventory]>
					- else if ( not <[flagged]> ) && ( not <[noted]> ):
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[inventory]>]>]> as:<[inventory]>
						- flag server <[inventories]>:->:<[inventory]>
						# |------- log message -------| #
						- narrate "<[prefix]> Inventory.<[inventory]> successfully cached."
					- else:
						# |------- invalid inventory -------| #
						- narrate "<[prefix]> <&c>The inventory '<[inventory]>' is not properly cached within the inventories database."



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_cached_gui:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui_name|current|next|previous
	script:
		- ratelimit <player> 1t
		# |------- app data -------| #
		- define ast <server.flag[citizens_editor.ast]>
		- define root <custom_object[citizens_editor_application].get_root>
		# |------- check context -------| #
		- choose <[gui_name]>:
			- case next-page:
				- if ( <[current]> != <[next].last.if_null[null]> ) && ( <[next].last.exists> ):
					# |------- add to previous cache -------| #
					- if ( not <[previous].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.previous:->:<[current]>
					# |------- next cache data -------| #
					- if ( <[current]> == <[root]> ):
						- define next_index <player.flag[citizens_editor.gui.next].first>
					- else:
						- define next_index <player.flag[citizens_editor.gui.next].last>
					# |------- open next cached -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[next_index]>
					- flag <player> citizens_editor.gui.current:<[next_index]>
					# |------- remove from cache -------| #
					- if ( <[next]> contains <[next_index]> ) && ( <[current]> != <[root]> ):
						- flag <player> citizens_editor.gui.next:<-:<[next_index]>
				- else:
					# |------- end cache -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
			- case previous-page:
				- if ( <[current]> != <[previous].last.if_null[null]> ) && ( <[previous].last.exists> ):
					# |------- remove from cache -------| #
					- if ( <[previous].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.previous:<-:<[current]>
					# |------- next cache data -------| #
					- define next_index <player.flag[citizens_editor.gui.previous].last>
					# |------- open next cached -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[next_index]>
					- flag <player> citizens_editor.gui.current:<[next_index]>
					# |------- remove from cache -------| #
					- if ( <[previous]> contains <[next_index]> ) && ( <[next_index]> != <[root]> ):
						- flag <player> citizens_editor.gui.previous:<-:<[next_index]>
					# |------- relation data -------| #
					- define cache <player.flag[citizens_editor.gui.next]>
					- define parent <[cache].get[<[cache].find_all_partial[-gui].last>].before[-gui]>
					- define group <server.flag[citizens_editor.ast.<[parent]>].keys.exclude[<[parent]>-gui]>
					- define relative <[cache].last>
					# |------- cleanup relatives -------| #
					- if ( <[parent]>-gui != <[root]> ) && ( <[group]> contains <[current]> ) && ( <[cache]> contains <[relative]> ):
						- foreach <[group].exclude[<[current]>]> as:related:
							- flag <player> citizens_editor.gui.next:<-:<[related]>
					# |------- add to next cache -------| #
					- if ( not <[next].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.next:->:<[current]>
				- else if ( <[current]> == <[previous].last> ):
					# |------- end cache and inventory -------| #
					- inventory close
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
				- else:
					# |------- end cache -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1

		# |------- debug output -------| #
		- narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
		- narrate "Next: <player.flag[citizens_editor.gui.next]>"
		- narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_gui:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui_name
	script:
		- ratelimit <player> 1t
		# |------- app data -------| #
		- define root <custom_object[citizens_editor_application].get_root>
		# |------- check context -------| #
		- choose <[gui_name]>:
			- case null:
				# |------- null gui id -------| #
				- stop
			- default:
				# |------- inventory data -------| #
				- define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
				- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
				# |------- inventory check -------| #
				- if ( <[flagged]> ) && ( <[noted]> ):
					# |------- open inventory -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[gui_name]>
					# |------- adjust navigation flags -------| #
					- if ( <[root]> == <player.flag[citizens_editor.gui.current]> ):
						- flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
					- flag <player> citizens_editor.gui.current:<[gui_name]>
				- else:
					# |------- validate inventory -------| #
					- inject citizens_editor_validate_gui
					- define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
					- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
					- if ( <[flagged]> ) && ( <[noted]> ):
						# |------- open inventory -------| #
						- playsound <player> sound:UI_BUTTON_CLICK pitch:1
						- inventory open destination:<[gui_name]>
						# |------- adjust navigation flags -------| #
						- if ( <[root]> == <player.flag[citizens_editor.gui.current]> ):
							- flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
						- flag <player> citizens_editor.gui.current:<[gui_name]>
				
				# |------- debug output -------| #
				- narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
				- narrate "Next: <player.flag[citizens_editor.gui.next]>"
				- narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: app|prefix|gui_name|gui_message
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
		- define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- adjust inventory -------| #
			- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
				- flag <player> citizens_editor.awaiting_dialog:!
			- adjust <inventory[<[gui_name]>]> title:<[gui_message]>
			# |------- open dialog -------| #
			- inventory open destination:<[gui_name]>
			- waituntil <player.has_flag[citizens_editor.awaiting_dialog]> rate:1t max:60s
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_gui
			- define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
			- if ( <[flagged]> ) && ( <[noted]> ):
				# |------- adjust inventory -------| #
				- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
					- flag <player> citizens_editor.awaiting_dialog:!
				- adjust <inventory[<[gui_name]>]> title:<[gui_message]>
				# |------- open dialog -------| #
				- inventory open destination:<[gui_name]>
				- waituntil <player.has_flag[citizens_editor.awaiting_dialog]> rate:1t max:60s



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_input_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: app|prefix|gui_name|title|sub_title|bossbar|gui_message|keywords
	script:
		- ratelimit <player> 1t
        # |------- interrupt discordSRV -------| #
        - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
        - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
        - if ( <[discordSRV]> ):
            - choose <[perms_handler]>:
                - case UltraPermissions:
                    - execute as_server "upc AddPlayerPermission <player.name> -discordsrv.player" silent
                - case LuckPerms:
                    - narrate placeholder
                - case Essentials:
                    - narrate placeholder
        # |------- dialog data -------| #
		- define timeout <server.flag[citizens_editor.settings.editor.dialog-event.await-dialog-timeout]||60>
		- if ( <[timeout].is_integer> ):
			- define count <[timeout]>
			- define ticks 0
			# |------- close inventory -------| #
			- inventory close
			# |------- set flag -------| #
			- flag <player> citizens_editor.awaiting_input:true
			# |------- awaiting input -------| #
			- while ( true ):
				# |------- input data -------| #
				- define awaiting <player.flag[citizens_editor.awaiting_input].if_null[false]>
				- define ticks:++
				# |------- display countdown -------| #
				- if ( <[loop_index]> == 1 ):
					- bossbar create id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
					- title title:<[title]> subtitle:<[sub_title]> stay:1s fade_in:0s fade_out:0s targets:<player>
				- if ( <[ticks]> == 20 ):
					- bossbar update id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
					- title title:<[title]> subtitle:<[sub_title]> stay:1s fade_in:0s fade_out:0s targets:<player>
					- define count:--
					- define ticks 0
				# |------- input check -------| #
				- if ( <[awaiting]> ) && ( <[loop_index]> <= <[timeout].mul_int[20]> ):
					- wait 1t
					- while next
				- else:
					# |------- check input -------| #
					- if ( <player.has_flag[citizens_editor.awaiting_input]> ):
						- wait 1s
						- bossbar update id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
						- title title:<[title]> subtitle:<[sub_title]> stay:1s fade_in:0s fade_out:0s targets:<player>
						- flag <player> citizens_editor.awaiting_input:!
						- wait 1s
					# |------- cleanup bossbar -------| #
					- bossbar remove id:npce_awaiting_input
					# |------- resume discordSRV -------| #
					- if ( <[discordSRV]> ):
						- choose <[perms_handler]>:
							- case UltraPermissions:
								- execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
							- case LuckPerms:
								- narrate placeholder
							- case Essentials:
								- narrate placeholder
					- while stop
			# |------- validate input -------| #
			- if ( <player.has_flag[citizens_editor.received_input]> ):
				- define input <player.flag[citizens_editor.received_input]>
				- if ( not <[keywords].contains[<[input]>]> ):
					# |------- open dialog -------| #
					- inject citizens_editor_open_dialog
		- else:
			# |------- invalid timeout -------| #
			- narrate "<[prefix]> <&c>Dialog Cancelled: The setting '<&f>await-input-timeout<&c>' <&c>is not a valid <&f>integer<&c>."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


