


# | ----------------------------------------------  CITIZENS EDITOR | INVENTORY HANDLERS  ---------------------------------------------- | #



citizens_editor_inventory_handler:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:



# | ----------------------------------------------  CITIZENS EDITOR | ROOT INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_menu_gui|menu-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory
                - case next-page:
                    - inject citizens_editor_open_next_inventory
                - case settings-gui:
                    # |------- open settings gui -------| #
                    - inject citizens_editor_open_inventory
                - case profile-editor-gui:
                    # |------- open profile editor gui -------| #
                    - inject citizens_editor_open_inventory



# | ----------------------------------------------  CITIZENS EDITOR | PROFILE EDITOR INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_profile_editor_gui|profile-editor-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory
                - case next-page:
                    - inject citizens_editor_open_next_inventory



# | ----------------------------------------------  CITIZENS EDITOR | SETTINGS INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_settings_gui|settings-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory
                - case next-page:
                    - inject citizens_editor_open_next_inventory
                - case prefixes-page:
                    # |------- open prefixes gui -------| #
                    - inject citizens_editor_open_inventory
                - case profiles-page:
                    # |------- open profiles gui -------| #
                    - inject citizens_editor_open_inventory
                - case interrupt-page:
                    # |------- open interrupt gui -------| #
                    - inject citizens_editor_open_inventory
                - case gui-page:
                    # |------- open inventory gui -------| #
                    - inject citizens_editor_open_inventory



# | ----------------------------------------------  CITIZENS EDITOR | PREFIXES INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_prefixes_page|prefixes-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory

                # |------------------------------| #
                # | ---  adjust main prefix  --- | #
                # |------------------------------| #
                - case adjust-prefix-main:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>npc editor prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_message "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.awaiting_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        # |------- clear data -------| #
                        - flag <player> citizens_editor.awaiting_dialog:!
                        # |------- update setting -------| #
                        - define flag citizens_editor.settings.prefixes.main
                        - if ( <server.has_flag[<[flag]>]> ):
                            - flag server <[flag]>:<[input].parsed>
                            - narrate "<[prefix]> <&f>Main prefix updated to <[input].parsed>"
                            # |------- validate inventory -------| #
                            - define gui-id <player.flag[citizens_editor.gui.previous].last>
                            - inject citizens_editor_validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject citizens_editor_open_previous_inventory

                # |-------------------------------| #
                # | ---  adjust debug prefix  --- | #
                # |-------------------------------| #
                - case adjust-prefix-debug:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>editor debug prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_message "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.awaiting_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        # |------- clear data -------| #
                        - flag <player> citizens_editor.awaiting_dialog:!
                        # |------- update setting -------| #
                        - define flag citizens_editor.settings.prefixes.debug
                        - if ( <server.has_flag[<[flag]>]> ):
                            - flag server <[flag]>:<[input].parsed>
                            - narrate "<[prefix]> <&f>Main prefix updated to <[input].parsed>"
                            # |------- validate inventory -------| #
                            - define gui-id <player.flag[citizens_editor.gui.previous].last>
                            - inject citizens_editor_validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject citizens_editor_open_previous_inventory

                # |-----------------------------| #
                # | ---  adjust npc prefix  --- | #
                # |-----------------------------| #
                - case adjust-prefix-npc:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>npc proximity prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_message "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.awaiting_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        # |------- clear data -------| #
                        - flag <player> citizens_editor.awaiting_dialog:!
                        # |------- update setting -------| #
                        - define flag citizens_editor.settings.prefixes.npc
                        - if ( <server.has_flag[<[flag]>]> ):
                            - flag server <[flag]>:<[input].parsed>
                            - narrate "<[prefix]> <&f>Main prefix updated to <[input].parsed>"
                            # |------- validate inventory -------| #
                            - define gui-id <player.flag[citizens_editor.gui.previous].last>
                            - inject citizens_editor_validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject citizens_editor_open_previous_inventory



# | ----------------------------------------------  CITIZENS EDITOR | PROFILES INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_profiles_page|profiles-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory



# | ----------------------------------------------  CITIZENS EDITOR | INTERRUPT INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_interrupt_page|interrupt-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory



# | ----------------------------------------------  CITIZENS EDITOR | GUI INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_gui_page|gui-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject citizens_editor_open_previous_inventory



# | ----------------------------------------------  CITIZENS EDITOR | DIALOG INVENTORY HANDLER  ---------------------------------------------- | #



        ######################################
		# |------- inventory events -------| #
		######################################
        on player flagged:citizens_editor.awaiting_input chats:
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                - flag <player> citizens_editor.received_input:<context.message>
                - flag <player> citizens_editor.awaiting_input:!
            - determine cancelled

        after player left clicks item_flagged:npce-gui-button in citizens_editor_dialog_gui|dialog-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define button-id <context.item.flag[npce-gui-button]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  confirm dialog event  --- | #
                # |--------------------------------| #
                - case confirm:
                    - flag <player> citizens_editor.awaiting_dialog:true
                    - playsound <player> sound:entity_experience_orb_pickup pitch:1
                # |-----------------------------| #
                # | ---  deny dialog event  --- | #
                # |-----------------------------| #
                - case deny:
                    - flag <player> citizens_editor.awaiting_dialog:false



# | ------------------------------------------------------------------------------------------------------------------------------ | #


