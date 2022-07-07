


# | ----------------------------------------------  CITIZENS EDITOR | COMMAND  ---------------------------------------------- | #



citizens_editor_command:
	##################################################
	# | ---  |        command script        |  --- | #
	##################################################
	type: command
	debug: true
	name: citizenseditor
	description: Open main gui menu for citizens editor.
	usage: /citizenseditor
	aliases:
		- ce
		- cedit
		- ceditor
		- npce
		- npcedit
		- npceditor
	#tab completions:
        #1: help|debug
		#2: enable|disable
        #default: StopTyping
	tab complete:
		- define result <list>
		- if ( <context.raw_args.trim> == <empty> ) || ( <context.args.size> == 1 && !<context.raw_args.ends_with[<&sp>]> ):
			- if ( <plugin[sentinel].exists> ) && ( <element[sentinel].starts_with[<context.args.first||>]> ):
				- define result:->:sentinel
			- define result:|:select|deselect|tool|show|save|load|quiet|loud|debug
		- else:
			- choose <context.args.first>:
				- case select sel deselect desel unselect unsel:
					- define result <server.npcs.parse[id].include[all]>
				- case save load:
					- define result <server.flag[multinpcs_selections_saved].keys.parse[unescaped]||<list>>
				- case sentinel:
					- if <plugin[Sentinel].exists>:
						- define initial <player.tab_completions[<context.raw_args>]>
				- case trait:
					- define initial <player.tab_completions[<context.raw_args>]>
		- if not ( <[initial].exists> ):
			- define initial "<player.tab_completions[npc <context.raw_args>]>"
		- determine <[result].filter[starts_with[<context.args.last||>]].include[<[initial]>]>
	script:
		# |------- command data -------| #
		- define permission <server.flag[citizens_editor.settings.permissions.use-command].if_null[<script[citizens_editor_config].data_key[permissions].get[use-command]>]>
		- define source <context.source_type.equals[player]>
		- define first <context.args.get[1]||null>
		- define second <context.args.get[2]||null>
		# |------- source check -------| #
		- if ( <[source]> ):
			# |------- permissions check -------| #
			- if ( <player.has_permission[<[permission]>].global> ) || ( <[permission]> == <empty> ) || ( <[permission]> == none ) || ( <[permission]> == null ):
				- if ( not <player.has_flag[citizens_editor.awaiting_input]> ) && ( <player.gamemode> != spectator ):
					# |------- validate dependencies -------| #
					- inject citizens_editor_command_handler path:validate_command
					# |------- prefix data -------| #
					- define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
					- define debug_prefix <server.flag[citizens_editor.settings.prefixes.debug].parse_color>
					# |------- execute command -------| #
					- choose <[first]>:
						- default:
							# |------- open root gui-id -------| #
							- inject htools_uix_manager path:open
						- case debug --debug d -d --d:
							# |------- debug toggle -------| #
							- choose <[second]>:
								- default:
									# |------- invalid command -------| #
									- narrate '<[prefix]> <[debug_prefix]> <&c>Invalid <&f>toggle <&c>state for <&f>debug <&c>command.'
								- case null:
									# |------- invert toggle state -------| #
									- if ( <player.flag[citizens_editor.debug_mode].if_null[true]> ):
										- flag <player> citizens_editor.debug_mode:false
										- narrate '<[prefix]> <[debug_prefix]> <&c>disabled<&f>.'
									- else:
										- flag <player> citizens_editor.debug_mode:true
										- narrate '<[prefix]> <[debug_prefix]> <&a>enabled<&f>.'
								- case 1 enable enabled true:
									# |------- toggle state true -------| #
									- if ( not <player.flag[citizens_editor.debug_mode].if_null[false]> ):
										- flag <player> citizens_editor.debug_mode:true
										- narrate '<[prefix]> <[debug_prefix]> <&a>Enabled<&f><&f>.'
									- else:
										- narrate '<[prefix]> <[debug_prefix]> <&f>already <&a>enabled<&f>.'
								- case 0 disable disabled false:
									# |------- toggle state false -------| #
									- if ( <player.flag[citizens_editor.debug_mode].if_null[true]> ):
										- flag <player> citizens_editor.debug_mode:false
										- narrate '<[prefix]> <[debug_prefix]> <&c>Disabled<&f>.'
									- else:
										- narrate '<[prefix]> <[debug_prefix]> <&f>already <&c>disabled<&f>.'
							- stop
			- else:
				# |------- unauthorized -------| #
				- narrate "<[prefix]> <&c>You do not have permission to use the <&f>/<context.alias> <&c>command."
				- stop



# | ----------------------------------------------  CITIZENS EDITOR | COMMAND HANDLER  ---------------------------------------------- | #




citizens_editor_command_handler:
	type: world
    debug: true
	events:
		on custom event id:placeholder-1:
			- narrate placeholder-1
	

	
# | ----------------------------------------------  CITIZENS EDITOR | COMMAND TASKS  ---------------------------------------------- | #



	validate_command:
		####################################################
		# | ---  |          command task          |  --- | #
		####################################################
		# | ---                                      --- | #
		# | ---  Required:  none                     --- | #
		# | ---                                      --- | #
		####################################################
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
		- if ( <player.has_flag[citizens_editor.awaiting_input]> ):
			- flag <player> citizens_editor.awaiting_input:!
		- if ( <player.has_flag[citizens_editor.received_input]> ):
			- flag <player> citizens_editor.received_input:!
		- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
			- flag <player> citizens_editor.awaiting_dialog:!
		- if ( <player.has_flag[citizens_editor.received_dialog]> ):
			- flag <player> citizens_editor.received_dialog:!
		- if ( <player.has_flag[citizens_editor.selection_mode]> ):
			- flag <player> citizens_editor.selection_mode:!
		- if ( <player.has_flag[citizens_editor.profile]> ):
			- flag <player> citizens_editor.profile:!
		# |------- set settings -------| #
		- if ( not <server.has_flag[citizens_editor.settings]> ):
			- definemap default_settings:
				prefixes: <script[citizens_editor_config].data_key[prefixes]>
				permissions: <script[citizens_editor_config].data_key[permissions]>
				editor: <script[citizens_editor_config].data_key[editor]>
				dependencies: <script[citizens_editor_config].data_key[dependencies]>
				interface: <script[citizens_editor_config].data_key[interface]>
			# |------- store settings flag -------| #
			- flag server citizens_editor.settings:<[default_settings]>
		
		# |------- build inventories -------| #
		- if not ( <server.flag[citizens_editor.ast].exists> ):
			- inject htools_uix_manager path:build
		
		# |------- reset navigation data -------| #
		- flag <player> citizens_editor.gui.current:!
		- flag <player> citizens_editor.gui.next:!
		- flag <player> citizens_editor.gui.previous:!

		# |------- validate dependencies -------| #
		- inject <script.name> path:validate_dependencies
		
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



	validate_dependencies:
		####################################################
		# | ---  |          command task          |  --- | #
		####################################################
		# | ---                                      --- | #
		# | ---  Required:  app                      --- | #
		# | ---                                      --- | #
		####################################################
		- ratelimit <player> 1t
		# |------- define data -------| #
		- define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
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


