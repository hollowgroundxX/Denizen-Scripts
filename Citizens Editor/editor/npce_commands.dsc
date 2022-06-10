


# | ---------------------------------------------- CITIZENS EDITOR | COMMANDS ---------------------------------------------- | #



citizens_editor_command:
	####################################
	# |------- command script -------| #
	####################################
	type: command
	debug: false
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
		- define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
		- define permission <script[citizens_editor_config].data_key[permissions].get[use-command]>
		- define source_player <context.source_type.equals[player]>
		- define first <context.args.get[1]||null>
		- define second <context.args.get[2]||null>
		# |------- source check -------| #
		- if ( <context.source_type> == player ):
			# |------- permissions check -------| #
			- if ( <player.has_permission[<[permission]>].global> ) || ( <[permission]> == <empty> ) || ( <[permission]> == none ) || ( <[permission]> == null ):
				# |------- flag check -------| #
				- if ( not <server.has_flag[npce_inventories]> ):
					- flag server npce_inventories:<list[]>
				- if ( not <player.has_flag[npce_debug_mode]> ):
					- flag <player> npce_debug_mode:false
				# |------- inventory data -------| #
				- define main_menu npce_gui_menu
				- define noted <server.notes[inventories].contains[<inventory[<[main_menu]>]>]>
				- define flagged <server.flag[npce_inventories].contains[<[main_menu]>]>
				# |------- context check  -------| #
				- choose <[first]>:
					- default:
						# |------- inventory check -------| #
						- if ( <[flagged]> ) && ( <[noted]> ):
							- inventory open destination:<[main_menu]>
							- narrate "<[main_menu]> inventory exists. "
						- else if ( not <[flagged]> ) && ( not <[noted]> ):
							- note <inventory[citizens_editor_main_menu_gui]> as:<[main_menu]>
							- flag server npce_inventories:->:<[main_menu]>
							- inventory open destination:<[main_menu]>
							- narrate "<[main_menu]> inventory created. "
						- else:
							- narrate "<[prefix]> <&c>The inventory you attempted to open is not properly stored within the inventories database."
					- case debug --debug d -d --d:
						# |------- debug toggle -------| #
						- define db_prefix <script[citizens_editor_config].parsed_key[prefixes].get[debug]>
						- choose <[second]>:
							- default:
								# |------- invalid command -------| #
								- narrate '<[prefix]> <[db_prefix]> <&c>Invalid <&f>toggle <&c>state for <&f>debug <&c>command.'
							- case null:
								# |------- invert toggle state -------| #
								- if ( <player.flag[npce_debug_mode]> ):
									- flag <player> npce_debug_mode:false
									- narrate '<[prefix]> <[db_prefix]> <&c>disabled<&f>.'
								- else:
									- flag <player> npce_debug_mode:true
									- narrate '<[prefix]> <[db_prefix]> <&a>enabled<&f>.'
							- case 1 enable enabled true:
								# |------- toggle state true -------| #
								- if ( not <player.flag[npce_debug_mode]> ):
									- flag <player> npce_debug_mode:true
									- narrate '<[prefix]> <[db_prefix]> <&a>Enabled<&f><&f>.'
								- else:
									- narrate '<[prefix]> <[db_prefix]> <&f>already <&a>enabled<&f>.'
							- case 0 disable disabled false:
								# |------- toggle state false -------| #
								- if ( <player.flag[npce_debug_mode]> ):
									- flag <player> npce_debug_mode:false
									- narrate '<[prefix]> <[db_prefix]> <&c>Disabled<&f>.'
								- else:
									- narrate '<[prefix]> <[db_prefix]> <&f>already <&c>disabled<&f>.'
						- stop
			- else:
				# |------- unauthorized -------| #
				- narrate "<[prefix]> <&c>You do not have permission to use the <&f>/<context.alias> <&c>command."
				- stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #


