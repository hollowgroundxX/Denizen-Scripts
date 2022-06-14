


# | ---------------------------------------------- CITIZENS EDITOR | TASKS ---------------------------------------------- | #



citizens_editor_validate_plugins:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	definitions: prefix|plugins
	script:
		# |------- define data -------| #
		- define plugins <server.flag[citizens_editor.settings.dependencies.plugins]>
		- define loaded <list[]>
		# |------- script check -------| #
		- if not ( <[plugins].equals[null]> ):
			- foreach <[plugins]> as:plugin:
				- if ( <[plugin].equals[<empty>]> ) || ( <[plugin].equals[null]> ) || ( not <plugin[<[plugin]>].exists> ):
					- foreach next
				- else:
					- define listed <server.plugins.if_null[<list[]>]>
					- if ( <[listed]> contains <plugin[<[plugin]>]> ):
						- define loaded:->:<[plugin]>
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' was successfully loaded."
					- else:
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' could not be located and was subsequently skipped."
		
		# |------- set loaded plugins -------| #
		- flag server citizens_editor.dependencies.plugins:<[loaded]>
		
		# |------- set permissions plugin -------| #
		- foreach <[loaded]> as:plugin:
			- choose <[plugin]>:
				- case default:
					- while next
				- case UltraPermissions:
					- flag server citizens_editor.permissions_handler:<[plugin]>
					- foreach stop
				- case LuckPerms:
					- flag server citizens_editor.permissions_handler:<[plugin]>
					- foreach stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_scripts:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	definitions: prefix|plugins
	script:
		# |------- define data -------| #
		- define scripts <server.flag[citizens_editor.settings.dependencies.scripts]||<list[]>>
		- define loaded <list[]>

		# |------- script check -------| #
		- if not ( <[scripts].equals[null]> ):
			- foreach <[scripts]> as:script:
				- if ( <[script].equals[<empty>]> ) || ( <[script].equals[null]> ) || ( not <script[<[script]>].exists> ):
					- foreach next
				- else:
					- define script_path <script[<[script]>].relative_filename>
					- if ( <server.has_file[<[script_path]>].if_null[false]> ):
						- define loaded:->:<[script]>
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Scripts<&rb> - The script '<[script]>' was successfully loaded."
					- else:
						- announce to_console "<[prefix]> -<&gt> <&lb>Validate-Scripts<&rb> - The script '<[script]>' could not be located and was subsequently skipped."
		
		# |------- set loaded plugins -------| #
		- flag server citizens_editor.dependencies.scripts:<[loaded]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_data:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	script:
		# |------- container check -------| #
		- if ( not <server.has_flag[citizens_editor]> ):
			- flag server citizens_editor:<map[]>
		- if ( not <player.has_flag[citizens_editor]> ):
			- flag <player> citizens_editor:<map[]>
		# |------- flag check -------| #
		- if ( not <player.has_flag[citizens_editor.debug_mode]> ):
			- flag <player> citizens_editor.debug_mode:false
		- if ( not <server.has_flag[citizens_editor.inventories]> ):
			- flag server citizens_editor.inventories:<list[]>
		- if ( not <server.has_flag[citizens_editor.settings]> ):
			- definemap default_settings:
				prefixes:
					main: <script[citizens_editor_config].parsed_key[prefixes].get[main]>
					debug: <script[citizens_editor_config].parsed_key[prefixes].get[debug]>
				permissions:
					use-command: <script[citizens_editor_config].data_key[permissions].get[use-command]>
				interface:
					materials:
						corner-fill: <script[citizens_editor_config].data_key[interface.materials].get[corner-fill]>
						edge-fill: <script[citizens_editor_config].data_key[interface.materials].get[edge-fill]>
						center-fill: <script[citizens_editor_config].data_key[interface.materials].get[center-fill]>
					lores:
						profiles-page: <script[citizens_editor_config].data_key[interface.lores].get[profiles-page]>
					skulls:
						next-page: <script[citizens_editor_config].data_key[interface.skulls].get[next-page]>
						previous-page: <script[citizens_editor_config].data_key[interface.skulls].get[previous-page]>
				interrupt:
					settings:
						interrupt-delay: <script[citizens_editor_config].data_key[interrupt.settings].get[interrupt-delay]>
					fishermen:
						select-location-timeout: <script[citizens_editor_config].data_key[interrupt.fishermen].get[select-location-timeout]>
					navigating:
						placeholder: <script[citizens_editor_config].data_key[interrupt.navigating].get[placeholder]>
				dependencies:
					plugins: <script[citizens_editor_config].data_key[dependencies.plugins]||null>
					scripts: <script[citizens_editor_config].data_key[dependencies.scripts]||null>

			# |------- store settings flag -------| #
			- flag server citizens_editor.settings:<[default_settings]>
		
		# |------- validate dependency data -------| #
		- inject citizens_editor_validate_plugins
		- inject citizens_editor_validate_scripts



# | ---------------------------------------------- CITIZENS EDITOR | GUI TASKS ---------------------------------------------- | #



citizens_editor_validate_guis:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
    definitions: prefix|current|next|previous
	script:
        # |------- inventory data -------| #
        - define inventories citizens_editor.inventories
		- definemap guis:
			npce_main_menu: citizens_editor_main_menu_gui
			npce_dialog: citizens_editor_dialog_gui
			npce_settings_page: citizens_editor_settings_gui
			npce_prefixes_page: citizens_editor_prefixes_gui
			npce_interrupt_page: citizens_editor_interrupt_gui
			npce_gui_page: citizens_editor_inventory_gui
			npce_profiles_page: citizens_editor_profiles_gui
		 # |------- build inventories -------| #
        - foreach <[guis]>:
            # |------- cached data -------| #
            - define noted <server.notes[inventories].contains[<inventory[<[key]>]>].if_null[false]>
            - define flagged <server.flag[<[inventories]>].contains[<[key]>].if_null[false]>
            # |------- presence check -------| #
            - if ( <[flagged]> ) && ( <[noted]> ):
                # |------- delete inventory -------| #
                - flag server <[inventories]>:<-:<[key]>
                - note remove as:<[key]>
                # |------- create inventory -------| #
                - note <inventory[<[value]>]> as:<[key]>
                - flag server <[inventories]>:->:<[key]>
                # |------- log message -------| #
                - narrate "<[prefix]> Inventory.<[key]> refreshed."
            - else if ( not <[flagged]> ) && ( not <[noted]> ):
                # |------- create inventory -------| #
                - note <inventory[<[value]>]> as:<[key]>
                - flag server <[inventories]>:->:<[key]>
                # |------- log message -------| #
                - narrate "<[prefix]> Inventory.<[key]> successfully cached."
            - else:
                # |------- invalid inventory -------| #
                - narrate "<[prefix]> <&c>The inventory '<[key]>' is not properly cached within the inventories database."



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_gui:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui_name|current|next|previous
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
        - define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- open inventory -------| #
			- inventory open destination:<[gui_name]>
			# |------- adjust gui flags -------| #
			- flag <player> citizens_editor.gui.current:<[gui_name]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|title|gui_name|current|next|previous
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
        - define noted <server.notes[inventories].contains[<inventory[<[gui_name]>]>].if_null[false]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui_name]>].if_null[false]>
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- adjust inventory -------| #
			- adjust <inventory[<[gui_name]>]> title:<[title]>
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
	definitions: prefix|title|sub-title|message|current|next|previous
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
        # |------- select data -------| #
		- define timeout 25
		- define count <[timeout]>
		- define ticks 0
		# |------- close inventory -------| #
		- inventory close
        # |------- flag check -------| #
        - if ( not <player.has_flag[]> ):
            - flag <player> citizens_editor.awaiting_input:true
        # |------- awaiting input -------| #
		- while ( true ):
			# |------- input data -------| #
			- define awaiting <player.flag[citizens_editor.awaiting_input].if_null[false]>
			- define ticks:++
			# |------- display countdown -------| #
			- if ( <[loop_index]> == 1 ):
				- bossbar create id:npce_awaiting_input title:<&b><&l><[message]><&sp><&b><&l>-<&sp><&a><[count]><&sp><&f><&l>seconds progress:0 color:red
				- title title:<[title]> subtitle:<[sub-title]> stay:1s fade_in:0s fade_out:0s targets:<player>
			- if ( <[ticks]> == 20 ):
				- bossbar update id:npce_awaiting_input title:<&b><&l><[message]><&sp><&b><&l>-<&sp><&a><[count]><&sp><&f><&l>seconds progress:0 color:red
				- title title:<[title]> subtitle:<[sub-title]> stay:1s fade_in:0s fade_out:0s targets:<player>
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
					- bossbar update id:npce_awaiting_input title:<&b><&l><[message]><&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
					- title title:<[title]> subtitle:<[sub-title]> stay:1s fade_in:0s fade_out:0s targets:<player>
					- if ( <player.has_flag[citizens_editor.awaiting_input]> ):
						- flag <player> citizens_editor.awaiting_input:!
					- wait 1s
				# |------- resume discordSRV -------| #
                - if ( <[discordSRV]> ):
                    - choose <[perms_handler]>:
                        - case UltraPermissions:
                            - execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
                        - case LuckPerms:
                            - narrate placeholder
                        - case Essentials:
                            - narrate placeholder
                # |------- cleanup instructions -------| #
				- bossbar remove id:npce_awaiting_input
				- while stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #


