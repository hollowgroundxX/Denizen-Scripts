


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
        # |------- inventory data -------| #
		- define ast <server.flag[citizens_editor.ast].if_null[false]>
        - define inventories citizens_editor.inventories
		- if ( <[ast]> != null ):
			# |------- build inventory -------| #
			- foreach <[ast]> as:category:
				- if ( <[category]> contains <[gui-id]> ):
					# |------- cached data -------| #
					- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[false]>]>
					- define flagged <server.flag[<[inventories]>].contains[<[gui-id]>].if_null[false]>
					# |------- presence check -------| #
					- if ( <[flagged]> ) && ( <[noted]> ):
						# |------- delete inventory -------| #
						- flag server <[inventories]>:<-:<[gui-id]>
						- note remove as:<[gui-id]>
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[gui-id]>]>]> as:<[gui-id]>
						- flag server <[inventories]>:->:<[gui-id]>
					- else if ( not <[flagged]> ) && ( not <[noted]> ):
						# |------- create inventory -------| #
						- note <inventory[<[category].get[<[gui-id]>]>]> as:<[gui-id]>
						- flag server <[inventories]>:->:<[gui-id]>
						# |------- log message -------| #
						- narrate "<[prefix]> Inventory.<[gui-id]> successfully cached."
					- else:
						# |------- invalid inventory -------| #
						- narrate "<[prefix]> <&c>The inventory '<[gui-id]>' is not properly cached within the inventories database."
					- foreach stop



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
		# |------- inventory data -------| #
		- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>]>].if_null[false]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>].if_null[false]>
		# |------- authentication check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			- define validated true
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_inventory
			# |------- redefine inventory data -------| #
			- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>]>].if_null[false]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>].if_null[false]>
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
			- define current <player.flag[citizens_editor.gui.current].if_null[<[root]>]>
			- if ( <[current]> == <[root]> ):
				- flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
			# |------- navigation data -------| #
			- define current <player.flag[citizens_editor.gui.current].if_null[<[root]>]>
            - define next <player.flag[citizens_editor.gui.next].if_null[<list[<empty>]>]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[<list[<empty>]>]>
			# |-----------------------------------------------------| #
			# | ---  If the 'current' gui-id is not the root,   --- | #
			# | ---  add the 'current' gui to the 'next-cache'. --- | #
			# | ---  This else if block prevents the root from  --- | #
			# | ---  adding itself to the 'next-cache'.         --- | #
			# |-----------------------------------------------------| #
			- if ( <[current]> != <[root]> ):
				- if ( not <[next].contains[<[current]>]> ):
					- flag <player> citizens_editor.gui.next:->:<[current]>
			# |------------------------------------------------------------------------| #
			# | ---  This block adds the 'current' gui-id to the 'previous-cache'  --- | #
			# | ---  to be later utilized by the 'previous_page' task.             --- | #
			# |------------------------------------------------------------------------| #
			- if ( not <[previous].contains[<[current]>]> ):
				- flag <player> citizens_editor.gui.previous:->:<[current]>
			# |--------------------------------------------------------| #
			# | ---  This block prevents the root and blacklisted  --- | #
			# | ---  from adding themselves to the 'next-cache'.   --- | #
			# |--------------------------------------------------------| #
			- if ( <[gui-id]> != <[root]> ) && ( not <[blacklist].contains[<[gui-id]>]> ):
				# |-------------------------------------------------------------------| #
				# | ---  This block adds the 'target' gui-id to the 'next-cache'  --- | #
				# | ---  to be later utilized by the 'next_page' task.            --- | #
				# |-------------------------------------------------------------------| #
				- if ( not <[next].contains[<[gui-id]>]> ):
					- flag <player> citizens_editor.gui.next:->:<[gui-id]>
			# |---------------------------------------------| #
			# | ---  Open and set the 'target' gui-id.  --- | #
			# |---------------------------------------------| #
			- flag <player> citizens_editor.gui.current:<[gui-id]>
			- playsound <player> sound:UI_BUTTON_CLICK pitch:1
			- inventory open destination:<[gui-id]>
		
		# |------- debug output -------| #
		- narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
		- narrate "Next: <player.flag[citizens_editor.gui.next]>"
		- narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #


citizens_editor_open_previous_inventory:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix
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
        - if ( <[current]> != <[previous].last.if_null[null]> ) && ( <[previous].last.exists> ):
            # |------- add to next-cache -------| #
            - if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
                - flag <player> citizens_editor.gui.next:->:<[current]>
            # |------- remove from previous-cache -------| #
            - if ( <[previous].contains[<[current]>]> ):
                - flag <player> citizens_editor.gui.previous:<-:<[current]>
            # |------- next-cache data -------| #
            - define gui-id <player.flag[citizens_editor.gui.previous].last>
            # |------- open gui-id -------| #
            - playsound <player> sound:UI_BUTTON_CLICK pitch:1
            - inventory open destination:<[gui-id]>
            - flag <player> citizens_editor.gui.current:<[gui-id]>
            # |------- remove gui-id from previous-cache -------| #
            - if ( <[gui-id]> != <[root]> ) && ( <[previous]> contains <[gui-id]> ):
                - flag <player> citizens_editor.gui.previous:<-:<[gui-id]>
            # |------- relation data -------| #
            - define cache <player.flag[citizens_editor.gui.next]>
            - define parent <[cache].get[<[cache].find_all_partial[-gui].last>]>
            - define group <server.flag[citizens_editor.ast.<[parent].before[-gui]>].keys.exclude[<[parent]>]>
            - define relative <[cache].last>
            # |------- cleanup relatives -------| #
            - if ( <[parent]> != <[root]> ) && ( <[group]> contains <[current]> ) && ( <[cache]> contains <[relative]> ):
                - foreach <[group].exclude[<[current]>]> as:related:
                    - if ( <[cache]> contains <[related]> ):
                        - flag <player> citizens_editor.gui.next:<-:<[related]>
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



citizens_editor_open_next_inventory:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: prefix
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
            # |------- remove from next-cache -------| #
            - if ( <[current]> != <[root]> ) && ( <[next]> contains <[gui-id]> ):
                - flag <player> citizens_editor.gui.next:<-:<[gui-id]>
        - else:
            # |------- end cache -------| #
            - playsound <player> sound:UI_BUTTON_CLICK pitch:1
		
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
	definitions: app|prefix|gui_message
	script:
		- ratelimit <player> 1t
		# |------- inventory data -------| #
		- define gui-id dialog-gui
		- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>]>].if_null[false]>
		- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>].if_null[false]>
		# |------- inventory check -------| #
		- if ( <[flagged]> ) && ( <[noted]> ):
			# |------- adjust inventory -------| #
			- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
				- flag <player> citizens_editor.awaiting_dialog:!
			- adjust <inventory[<[gui-id]>]> title:<[gui_message]>
			# |------- open dialog -------| #
			- inject citizens_editor_open_inventory
			- waituntil <player.has_flag[citizens_editor.awaiting_dialog]> rate:1t max:60s
		- else:
			# |------- validate inventory -------| #
			- inject citizens_editor_validate_inventory
			- define noted <server.notes[inventories].contains[<inventory[<[gui-id]>]>].if_null[false]>
			- define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>].if_null[false]>
			- if ( <[flagged]> ) && ( <[noted]> ):
				# |------- adjust inventory -------| #
				- if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
					- flag <player> citizens_editor.awaiting_dialog:!
				- adjust <inventory[<[gui-id]>]> title:<[gui_message]>
				# |------- open dialog -------| #
				- inject citizens_editor_open_inventory
				- waituntil <player.has_flag[citizens_editor.awaiting_dialog]> rate:1t max:60s



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_open_input_dialog:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: true
	definitions: app|prefix|title|sub_title|bossbar|gui_message|keywords
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


