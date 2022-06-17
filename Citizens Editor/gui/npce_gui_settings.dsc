


# | ----------------------------------------------  CITIZENS EDITOR | INVENTORIES  ---------------------------------------------- | #



citizens_editor_settings_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.settings-page].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        prefixes-page: <item[name_tag].with_flag[npce-gui-button:prefixes-page].with[display=<&d><&l>Prefix <&f><&l>Settings]>
        profiles-page: <item[book].with_flag[npce-gui-button:profiles-page].with[display=<&d><&l>Profiles <&f><&l>Settings]>
        interrupt-page: <item[structure_void].with_flag[npce-gui-button:interrupt-page].with[display=<&d><&l>Interrupt <&f><&l>Settings]>
        gui-page: <item[chest].with_flag[npce-gui-button:gui-page].with[display=<&d><&l>Gui <&f><&l>Settings]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [prefixes-page] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [profiles-page] [center-fill] [interrupt-page] [center-fill] [gui-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_prefixes_page:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.prefixes-page].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
        debug-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-debug].with[display=<server.flag[citizens_editor.settings.prefixes.debug]>]>
        npc-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-npc].with[display=<server.flag[citizens_editor.settings.prefixes.npc].parsed.replace_text[npc.id].with[<&lt>npc.id<&gt>].if_null[<server.flag[citizens_editor.settings.prefixes.npc].parsed>]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [debug-prefix] [center-fill] [npc-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_profiles_page:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.profiles-page].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_interrupt_page:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.interrupt-page].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_gui_page:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.gui-page].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_settings_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
		##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_settings_gui|settings-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui_name <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_gui
                - case next-page:
                    - inject citizens_editor_open_cached_gui
                - case prefixes-page:
                    # |------- adjust navigation flags -------| #
                    - if ( not <[next].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:->:<[current]>
                    - if ( not <[previous].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.previous:->:<[current]>
                    # |------- open prefixes gui -------| #
                    - inject citizens_editor_open_gui
                - case profiles-page:
                    # |------- adjust navigation flags -------| #
                    - if ( not <[next].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:->:<[current]>
                    - if ( not <[previous].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.previous:->:<[current]>
                    # |------- open profiles gui -------| #
                    - inject citizens_editor_open_gui
                - case interrupt-page:
                    # |------- adjust navigation flags -------| #
                    - if ( not <[next].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:->:<[current]>
                    - if ( not <[previous].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.previous:->:<[current]>
                    # |------- open interrupt gui -------| #
                    - inject citizens_editor_open_gui
                - case gui-page:
                    # |------- adjust navigation flags -------| #
                    - if ( not <[next].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:->:<[current]>
                    - if ( not <[previous].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.previous:->:<[current]>
                    # |------- open inventory gui -------| #
                    - inject citizens_editor_open_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_prefixes_page|prefixes-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui_name <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_gui
                ########################################
		        # |------- adjust main prefix -------| #
                ########################################
                - case adjust-prefix-main:
                    # |------- input data -------| #
                    - define gui_name dialog-gui
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
                            - define gui_name <player.flag[citizens_editor.gui.current]>
                            - inject citizens_editor_validate_gui
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - define gui_name <player.flag[citizens_editor.gui.current]>
                    - inject citizens_editor_open_gui
                #########################################
		        # |------- adjust debug prefix -------| #
                #########################################
                - case adjust-prefix-debug:
                    # |------- input data -------| #
                    - define gui_name dialog-gui
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
                            - define gui_name <player.flag[citizens_editor.gui.current]>
                            - inject citizens_editor_validate_gui
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - define gui_name <player.flag[citizens_editor.gui.current]>
                    - inject citizens_editor_open_gui
                #######################################
		        # |------- adjust npc prefix -------| #
                #######################################
                - case adjust-prefix-npc:
                    # |------- input data -------| #
                    - define gui_name dialog-gui
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
                            - define gui_name <player.flag[citizens_editor.gui.current]>
                            - inject citizens_editor_validate_gui
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.awaiting_input:!
                    - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - define gui_name <player.flag[citizens_editor.gui.current]>
                    - inject citizens_editor_open_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_profiles_page|profiles-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui_name <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_interrupt_page|interrupt-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui_name <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_gui_page|gui-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui_name <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #


