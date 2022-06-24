


# | ----------------------------------------------  CITIZENS EDITOR | APPLICATION TASKS  ---------------------------------------------- | #



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



# | ----------------------------------------------  CITIZENS EDITOR | INVENTORY TASKS  ---------------------------------------------- | #



citizens_editor_validate_all_inventories:
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



citizens_editor_validate_inventory:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
    definitions: prefix|gui-id
	script:
		- ratelimit <player> 1t
		# |------- default target -------| #
		- if ( not <[gui-id].exists> ):
			- define gui-id <player.flag[citizens_editor.gui.current]>
		- else if ( <[gui-id]> == previous-page ):
			- define cached-gui <[gui-id]>
			- define gui-id <player.flag[citizens_editor.gui.previous].last>
		- else if ( <[gui-id]> == previous-page-2 ):
			- define cached-gui <[gui-id]>
			- define last <player.flag[citizens_editor.gui.previous].last>
			- define gui-id <player.flag[citizens_editor.gui.previous].exclude[<[last]>].last>
		- else if ( <[gui-id].exists> ):
			- define cached-gui <[gui-id]>
			- define gui-id <[gui-id]>
		# |------- inventory data -------| #
		- define ast <server.flag[citizens_editor.ast].if_null[null]>
        - define inventories citizens_editor.inventories
		- if ( <[ast]> != null ):
			# |------- build inventory -------| #
			- foreach <[ast]> key:category as:data:
				- define raw-id <[gui-id].before[-gui].if_null[<[gui-id].before[-page]>].if_null[null]>
				- define pages <[data].get[pages].if_null[<list[<empty>]>]>
				- if ( <[category]> == <[raw-id]> ) || ( <[pages].contains[<[gui-id]>]> ):
					# |------- ast data -------| #
					- define type-gui <[gui-id].ends_with[-gui].and[<[raw-id].equals[<[category]>]>]>
					- define type-page <[pages].contains[<[gui-id]>]>
					# |------- set inventory-id -------| #
					- if ( <[type-gui]> ) && ( not <[type-page]> ):
						- define inventory-id <[data].get[gui]>
						- narrate inv_id:<[inventory-id]>
					- else if ( <[type-page]> ) && ( not <[type-gui]> ):
						- define inventory-id <[pages].get[<[gui-id]>]>
						- narrate inv_id:<[inventory-id]>
					# |------- refresh inventory -------| #
					- if ( <[inventory-id].exists> ) && ( <[type-gui]> || <[type-page]> ):
						# |------- cached data -------| #
						- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[false]>]>
						- define flagged <server.flag[<[inventories]>].contains[<[gui-id]>].if_null[false]>
						# |------- presence check -------| #
						- if ( <[flagged]> ) && ( <[noted]> ):
							# |------- delete inventory -------| #
							- flag server <[inventories]>:<-:<[gui-id]>
							- note remove as:<[gui-id]>
							# |------- create inventory -------| #
							- note <inventory[<[inventory-id]>]> as:<[gui-id]>
							- flag server <[inventories]>:->:<[gui-id]>
						- else if ( not <[flagged]> ) && ( not <[noted]> ):
							# |------- create inventory -------| #
							- note <inventory[<[inventory-id]>]> as:<[gui-id]>
							- flag server <[inventories]>:->:<[gui-id]>
							# |------- log message -------| #
							- narrate "<[prefix]> Inventory.<[gui-id]> successfully cached."
						- else:
							# |------- invalid inventory -------| #
							- narrate "<[prefix]> <&c>The inventory '<[gui-id]>' is not properly cached within the inventories database."
						# |------- reset gui-id -------| #
						- if ( <[cached-gui].exists> ):
							- define gui-id <[cached-gui]>
						- foreach stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_validate_cache:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
    definitions: prefix|root|cache-id|
	script:
		- ratelimit <player> 1t
		# |-------------------------------------------------------------| #
		# | ---  Get the last 'parent' gui-id from the 'cache' and  --- | #
		# | ---  list every 'relative' of the 'current' gui-id.     --- | #
		# |-------------------------------------------------------------| #
		- define current <player.flag[citizens_editor.gui.current]>
		- if ( <[current].ends_with[-page]> ):
			- define cache <player.flag[<[cache-id]>]>
			- define parent <[cache].get[<[cache].find_all_partial[-gui].last>].before[-gui].if_null[null]>
			- define group <server.flag[citizens_editor.ast.<[parent]>.pages].keys.if_null[<list[empty]>]>
			- define relative <[cache].last.if_null[null]>
			# |------------------------------------------------------------| #
			# | ---  Remove any 'related' gui-ids from the 'cache' to  --- | #
			# | ---  ensure the 'current' gui-id is the last item in   --- | #
			# | ---  the 'cache', following the 'parent' gui-id.       --- | #
			# |------------------------------------------------------------| #
			- if ( <[parent]>-gui != <[root]> ) && ( <[group]> contains <[current]> ) && ( <[cache]> contains <[relative]> ):
				- foreach <[group].exclude[<[current]>]> as:related:
					- if ( <[cache]> contains <[related]> ):
						- flag <player> <[cache-id]>:<-:<[related]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_inventory:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui-id
	script:
		- ratelimit <player> 1t
		# |------- application data -------| #
		- define root <custom_object[citizens_editor_application].get_root>
        - define blacklist <list[dialog-gui]>
		# |------- default target -------| #
		- if ( not <[gui-id].exists> ):
			- define gui-id <[root]>
		# |------- inventory data -------| #
		- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
		# |------- authentication check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			- define validated true
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_inventory
			# |------- redefine inventory data -------| #
			- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
			# |------- authentication re-check -------| #
			- if ( <[flagged]> ) && ( <[noted]> ):
				- define validated true
		# |------- validation check -------| #
		- if ( <[validated].if_null[false]> ):
			# |-----------------------------------------------------------| #
			# | ---  If the 'current' gui-id is the root, clear the   --- | #
			# | ---  'next-cache'. This block resets the 'next-cache' --- | #
			# | ---  when starting from a new parent gui.             --- | #
			# |-----------------------------------------------------------| #
			- if ( <player.flag[citizens_editor.gui.current].if_null[<[root]>]> == <[root]> ):
				- flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
			# |------- navigation data -------| #
			- define current <player.flag[citizens_editor.gui.current].if_null[<[root]>]>
            - define next <player.flag[citizens_editor.gui.next].if_null[<list[<empty>]>]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[<list[<empty>]>]>
			# |--------------------------------------------------| #
			# | ---  This if block prevents the 'root' from  --- | #
			# | ---  adding itself to the 'next-cache'.      --- | #
			# |--------------------------------------------------| #
			- if ( <[current]> != <[root]> ):
				- if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
					# |---------------------------------------------------------| #
					# | ---  Add the 'current' gui-id to the 'next-cache',  --- | #
					# | ---  to be later utilized by the 'next_page' task.  --- | #
					# |---------------------------------------------------------| #
					- flag <player> citizens_editor.gui.next:->:<[current]>
			# |---------------------------------------------------------| #
			# | ---  This if block prevents the 'root' from adding  --- | #
			# | ---  itself to the 'previous-cache' at the first    --- | #
			# | ---  instantiation of the 'root' gui-id.            --- | #
			# |---------------------------------------------------------| #
			- if ( <[gui-id]> != <[root]> ):
				- if ( not <[previous].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
					# |-------------------------------------------------------------| #
					# | ---  Add the 'current' gui-id to the 'previous-cache',  --- | #
					# | ---  to be later utilized by the 'previous_page' task.  --- | #
					# |-------------------------------------------------------------| #
					- flag <player> citizens_editor.gui.previous:->:<[current]>
			- else:
				- if not ( <player.has_flag[citizens_editor.gui.previous]> ):
					- flag <player> citizens_editor.gui.previous:!|:<list[<empty>]>
			# |---------------------------------------------| #
			# | ---  Open and set the 'target' gui-id.  --- | #
			# |---------------------------------------------| #
			- flag <player> citizens_editor.gui.current:<[gui-id]>
			- playsound <player> sound:UI_BUTTON_CLICK pitch:1
			- inventory open destination:<[gui-id]>
			# |----------------------------------------------------------| #
			# | ---  This block prevents the 'root' and blacklisted  --- | #
			# | ---  from adding themselves to the 'next-cache'.     --- | #
			# |----------------------------------------------------------| #
			- if ( <[gui-id]> != <[root]> ) && ( not <[blacklist].contains[<[gui-id]>]> ):
				- if ( not <[next].contains[<[gui-id]>]> ):
					# |--------------------------------------------------------| #
					# | ---  Add the 'target' gui-id to the 'next-cache',  --- | #
					# | ---  to be later utilized by the 'next_page' task. --- | #
					# |--------------------------------------------------------| #
					- flag <player> citizens_editor.gui.next:->:<[gui-id]>
			# |---------------------------------------------------------| #
			# | ---  Set and validate the current working 'cache'.  --- | #
			# |---------------------------------------------------------| #
			- define cache-id citizens_editor.gui.next
			- inject citizens_editor_validate_cache

		# |------- debug output -------| #
		- narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
		- narrate "Next: <player.flag[citizens_editor.gui.next]>"
		- narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_cached_inventory:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui-id
	script:
		- ratelimit <player> 1t
		# |------- app data -------| #
		- define root <custom_object[citizens_editor_application].get_root>
		- define blacklist <list[dialog-gui]>
		# |------- navigation data -------| #
		- define current <player.flag[citizens_editor.gui.current]>
		- define next <player.flag[citizens_editor.gui.next]>
		- define previous <player.flag[citizens_editor.gui.previous]>
		# |------- check context -------| #
		- choose <[gui-id]>:
			- case previous-page:
				# |------------------------------------------------------------------| #
				# | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
				# |------------------------------------------------------------------| #
				- if ( <[previous].contains[<[current]>]> ):
					- flag <player> citizens_editor.gui.previous:<-:<[current]>
				# |--------------------------------------------------------------------| #
				# | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
				# | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
				# |--------------------------------------------------------------------| #
				- if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
					# |---------------------------------------------------------| #
					# | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
					# |---------------------------------------------------------| #
					- if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.next:->:<[current]>
					# |----------------------------------------------------| #
					# | ---  Define the 'target' gui-id to the latest  --- | #
					# | ---  gui-id from the 'previous-cache'.         --- | #
					# |----------------------------------------------------| #
					- define gui-id <player.flag[citizens_editor.gui.previous].last>
					# |-----------------------------------------------------------------| #
					# | ---  Remove the 'target' gui-id from the 'previous-cache'.  --- | #
					# |-----------------------------------------------------------------| #
					- if ( <[previous].contains[<[gui-id]>]> ):
						- flag <player> citizens_editor.gui.previous:<-:<[gui-id]>
					# |-------------------------------------------------------| #
					# | ---  Open and set the 'target' gui-id inventory.  --- | #
					# |-------------------------------------------------------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[gui-id]>
					- flag <player> citizens_editor.gui.current:<[gui-id]>
				- else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
					# |-----------------------------------------------------------| #
					# | ---  The 'previous-cache' is empty. Close inventory.  --- | #
					# |-----------------------------------------------------------| #
					- inventory close
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- flag <player> citizens_editor.gui.current:null
					- flag <player> citizens_editor.gui.next:<list[<empty>]>
				- else:
					# |-----------------------------------------------------------| #
					# | ---  The 'current' and 'target' gui-id are identical. --- | #
					# |-----------------------------------------------------------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
			- case previous-page-2:
				# |------------------------------------------------------------------| #
				# | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
				# |------------------------------------------------------------------| #
				- if ( <[previous].contains[<[current]>]> ):
					- flag <player> citizens_editor.gui.previous:<-:<[current]>
				# |--------------------------------------------------------------------| #
				# | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
				# | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
				# |--------------------------------------------------------------------| #
				- if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
					# |---------------------------------------------------------| #
					# | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
					# |---------------------------------------------------------| #
					- if ( <[next].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.next:<-:<[current]>
					# |----------------------------------------------------| #
					# | ---  Define the 'target' gui-id to the latest  --- | #
					# | ---  gui-id from the 'previous-cache'.         --- | #
					# |----------------------------------------------------| #
					- define gui-id <player.flag[citizens_editor.gui.previous].last>
					# |----------------------------------------------------| #
					# | ---  Define the next 'target' gui-id to the    --- | #
					# | ---  latest gui-id from the 'previous-cache'.  --- | #
					# |----------------------------------------------------| #
					- define gui-id-after <player.flag[citizens_editor.gui.previous].exclude[<[gui-id]>].last>
					# |------------------------------------------------------------| #
					# | ---  Remove the 'target' gui-id from the 'next-cache'  --- | #
					# | ---  and 'previous-cache'.                             --- | #
					# |------------------------------------------------------------| #
					- if ( <[next].contains[<[gui-id]>]> ):
						- flag <player> citizens_editor.gui.next:<-:<[gui-id]>
					- if ( <[previous].contains[<[gui-id]>]> ):
						- flag <player> citizens_editor.gui.previous:<-:<[gui-id]>
					# |----------------------------------------------------------------| #
					# | ---  Remove the 'after' gui-id from the 'previous-cache'.  --- | #
					# |----------------------------------------------------------------| #
					- if ( <[previous].contains[<[gui-id-after]>]> ):
						- flag <player> citizens_editor.gui.previous:<-:<[gui-id-after]>
					# |------------------------------------------------------| #
					# | ---  Open and set the 'after' gui-id inventory.  --- | #
					# |------------------------------------------------------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[gui-id-after]>
					- flag <player> citizens_editor.gui.current:<[gui-id-after]>
				- else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
					# |-----------------------------------------------------------| #
					# | ---  The 'previous-cache' is empty. Close inventory.  --- | #
					# |-----------------------------------------------------------| #
					- inventory close
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- flag <player> citizens_editor.gui.current:null
					- flag <player> citizens_editor.gui.next:<list[<empty>]>
				- else:
					# |-----------------------------------------------------------| #
					# | ---  The 'current' and 'target' gui-id are identical. --- | #
					# |-----------------------------------------------------------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
			- case next-page:
				# |----------------------------------------------------------------| #
				# | ---  Ensure the 'target' gui-id entry in the 'next-cache'  --- | #
				# | ---  exists, and doesn't match the 'current' gui-id.       --- | #
				# |----------------------------------------------------------------| #
				- if ( <[current]> != <[next].last.if_null[null]> ) && ( <[next].last.exists> ):
					# |------- add to previous-cache -------| #
					- if ( not <[previous].contains[<[current]>]> ):
						- flag <player> citizens_editor.gui.previous:->:<[current]>
					# |------- next-cache data -------| #
					- if ( <[current]> == <[root]> ):
						- define gui-id <player.flag[citizens_editor.gui.next].first>
					- else:
						- define gui-id <player.flag[citizens_editor.gui.next].last>
					# |------- open next-cached -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
					- inventory open destination:<[gui-id]>
					- flag <player> citizens_editor.gui.current:<[gui-id]>
				- else:
					# |------- end cache -------| #
					- playsound <player> sound:UI_BUTTON_CLICK pitch:1
		
		# |------- debug output -------| #
		- narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
		- narrate "Next: <player.flag[citizens_editor.gui.next]>"
		- narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_profile_gui:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui_title|profile-id|gui-id
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
		- if ( <[gui-id].exists> ):
			- define cached-gui <[gui-id]>
		- define gui-id profile-page
		- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
		- flag <player> citizens_editor.profile:<[profile-id].get[name]>
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- adjust inventory -------| #
			- adjust <inventory[<[gui-id]>]> title:<[gui_title]>
			# |------- open dialog inventory -------| #
			- inject citizens_editor_open_inventory
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_inventory
			- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
			- if ( <[flagged]> ) && ( <[noted]> ):
				# |------- adjust inventory -------| #
				- adjust <inventory[<[gui-id]>].parsed> title:<[gui_title].parsed>
				# |------- open dialog -------| #
				- inject citizens_editor_open_inventory
		# |------- reset gui-id -------| #
		- if ( <[cached-gui].exists> ):
			- define gui-id <[cached-gui]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix|gui_title|gui-id
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
		- if ( <[gui-id].exists> ):
			- define cached-gui <[gui-id]>
		- define gui-id dialog-gui
		- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
		# |------- check flags -------| #
		- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
			- flag <player> citizens_editor.awaiting_dialog:!
		- if ( <player.has_flag[citizens_editor.received_dialog]> ):
			- flag <player> citizens_editor.received_dialog:!
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- adjust inventory -------| #
			- adjust <inventory[<[gui-id]>]> title:<[gui_title]>
			# |------- open dialog inventory -------| #
			- inject citizens_editor_open_inventory
			- waituntil <player.has_flag[citizens_editor.received_dialog]> rate:1t max:60s
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_inventory
			- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
			- if ( <[flagged]> ) && ( <[noted]> ):
				# |------- adjust inventory -------| #
				- adjust <inventory[<[gui-id]>]> title:<[gui_title]>
				# |------- open dialog -------| #
				- inject citizens_editor_open_inventory
				- waituntil <player.has_flag[citizens_editor.received_dialog]> rate:1t max:60s
		# |------- reset gui-id -------| #
		- if ( <[cached-gui].exists> ):
			- define gui-id <[cached-gui]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_input_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: app|prefix|title|sub_title|bossbar|gui_title|keywords
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
			# |------- check flags -------| #
			- if ( <player.has_flag[citizens_editor.awaiting_input]> ):
				- flag <player> citizens_editor.awaiting_input:!
			- if ( <player.has_flag[citizens_editor.received_input]> ):
				- flag <player> citizens_editor.received_input:!
			# |------- set flags -------| #
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
					# |------- clear input data -------| #
					- flag <player> citizens_editor.received_input:!
					# |------- open previous inventory -------| #
					- define gui-id <player.flag[citizens_editor.gui.current]>
					- inject citizens_editor_open_inventory
					- stop
		- else:
			# |------- invalid timeout -------| #
			- narrate "<[prefix]> <&c>Dialog Cancelled: The setting '<&f>await-input-timeout<&c>' <&c>is not a valid <&f>integer<&c>."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


