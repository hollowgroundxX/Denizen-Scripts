


# | ----------------------------------------------  CITIZENS EDITOR | COMMANDS  ---------------------------------------------- | #



citizens_editor_command:
	####################################
	# |------- command script -------| #
	####################################
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
	tab completions:
        1: help|debug
		2: enable|disable
        default: StopTyping
	script:
		# |------- command data -------| #
		- define prefix <server.flag[citizens_editor.settings.prefixes.main].if_null[<script[citizens_editor_config].parsed_key[prefixes].get[main]>]>
		- define permission <server.flag[citizens_editor.settings.permissions.use-command].if_null[<script[citizens_editor_config].data_key[permissions].get[use-command]>]>
		- define source_player <context.source_type.equals[player]>
		- define first <context.args.get[1]||null>
		- define second <context.args.get[2]||null>
		- define app <custom_object[citizens_editor_application]>
		# |------- source check -------| #
		- if ( <context.source_type> == player ):
			# |------- permissions check -------| #
			- if ( <player.has_permission[<[permission]>].global> ) || ( <[permission]> == <empty> ) || ( <[permission]> == none ) || ( <[permission]> == null ):
				- if ( not <player.has_flag[citizens_editor.awaiting_input]> ) && ( <player.gamemode> != spectator ):
					# |------- validate dependencies -------| #
					- inject citizens_editor_validate_command
					# |------- execute command -------| #
					- choose <[first]>:
						- default:
							# |------- open main gui -------| #
							- define gui_name <[app].get_root>
							- inject citizens_editor_open_gui
						- case debug --debug d -d --d:
							# |------- debug toggle -------| #
							- define db_prefix <server.flag[citizens_editor.settings.prefixes.debug]>
							- choose <[second]>:
								- default:
									# |------- invalid command -------| #
									- narrate '<[prefix]> <[db_prefix]> <&c>Invalid <&f>toggle <&c>state for <&f>debug <&c>command.'
								- case null:
									# |------- invert toggle state -------| #
									- if ( <player.flag[citizens_editor.debug_mode].if_null[true]> ):
										- flag <player> citizens_editor.debug_mode:false
										- narrate '<[prefix]> <[db_prefix]> <&c>disabled<&f>.'
									- else:
										- flag <player> citizens_editor.debug_mode:true
										- narrate '<[prefix]> <[db_prefix]> <&a>enabled<&f>.'
								- case 1 enable enabled true:
									# |------- toggle state true -------| #
									- if ( not <player.flag[citizens_editor.debug_mode].if_null[false]> ):
										- flag <player> citizens_editor.debug_mode:true
										- narrate '<[prefix]> <[db_prefix]> <&a>Enabled<&f><&f>.'
									- else:
										- narrate '<[prefix]> <[db_prefix]> <&f>already <&a>enabled<&f>.'
								- case 0 disable disabled false:
									# |------- toggle state false -------| #
									- if ( <player.flag[citizens_editor.debug_mode].if_null[true]> ):
										- flag <player> citizens_editor.debug_mode:false
										- narrate '<[prefix]> <[db_prefix]> <&c>Disabled<&f>.'
									- else:
										- narrate '<[prefix]> <[db_prefix]> <&f>already <&c>disabled<&f>.'
							- stop
			- else:
				# |------- unauthorized -------| #
				- narrate "<[prefix]> <&c>You do not have permission to use the <&f>/<context.alias> <&c>command."
				- stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #


