


# | ----------------------------------------------  CITIZENS EDITOR | CORE TASKS  ---------------------------------------------- | #



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
		
		# |------- reset navigation data -------| #
		- flag <player> citizens_editor.gui.current:!
		- flag <player> citizens_editor.gui.next:!
		- flag <player> citizens_editor.gui.previous:!

		# |------- validate dependencies -------| #
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



