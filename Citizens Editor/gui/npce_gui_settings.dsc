


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



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
        interrupt-page: <item[structure_void].with_flag[npce-gui-button:interrupt-page].with[display=<&d><&l>Interrupt <&f><&l>Settings]>
        gui-page: <item[chest].with_flag[npce-gui-button:gui-page].with[display=<&d><&l>Gui <&f><&l>Settings]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [prefixes-page] [center-fill] [interrupt-page] [center-fill] [gui-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_prefixes_gui:
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



citizens_editor_interrupt_gui:
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



citizens_editor_inventory_gui:
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
        after player left clicks item_flagged:npce-gui-button in citizens_editor_settings_gui|npce_settings_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_settings_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_settings_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_settings_page]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - if ( <[current]> != <[previous]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:<[current]>
                        - flag <player> citizens_editor.gui.previous:!
                        # |------- open previous gui -------| #
                        - define gui_name <[previous]>
                        - inject citizens_editor_open_gui
                    - else:
                        - playsound <player> sound:UI_BUTTON_CLICK pitch:1
                - case next-page:
                    - if ( <[current]> != <[next]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:<[previous]>
                        - flag <player> citizens_editor.gui.previous:<[current]>
                        # |------- open next gui -------| #
                        - define gui_name <[next]>
                        - inject citizens_editor_open_gui
                    - else:
                        - playsound <player> sound:UI_BUTTON_CLICK pitch:1
                - case prefixes-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:<[previous]>
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_prefixes_page
                    - inject citizens_editor_open_gui
                - case interrupt-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:<[previous]>
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_interrupt_page
                    - inject citizens_editor_open_gui
                - case gui-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:<[previous]>
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_gui_page
                    - inject citizens_editor_open_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_prefixes_gui|npce_prefixes_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_prefixes_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_prefixes_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_prefixes_page]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - if ( <[current]> != <[previous]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:<[current]>
                        - flag <player> citizens_editor.gui.previous:<[next]>
                        # |------- open previous gui -------| #
                        - define gui_name <[previous]>
                        - inject citizens_editor_open_gui
                - case adjust-prefix-main:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub-title "<&d><&l>npc editor prefix"
                    - define message "<&b><&l>Awaiting Input"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- check input -------| #
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        # |------- validate input -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - if ( not <[keywords].contains[<[input]>]> ):
                            # |------- dialog data -------| #
                            - define gui_name npce_dialog
                            - define title "<&8><&l>Save New Prefix?"
                                # |------- open dialog -------| #
                            - inject citizens_editor_open_dialog
                            # |------- validate dialog -------| #
                            - define dialog <player.flag[citizens_editor.awaiting_dialog].if_null[false]>
                            - if ( <[dialog]> ):
                                # |------- clear dialog data -------| #
                                - flag <player> citizens_editor.awaiting_dialog:!
                                # |------- update setting -------| #
                                - define target citizens_editor.settings.prefixes.main
                                - if ( <server.has_flag[<[target]>]> ):
                                    - flag server <[target]>:<[input].parsed>
                                    - narrate "<[prefix]> <&f>Main prefix updated to <[input].parsed>"
                                # |------- validate inventories -------| #
                                - inject citizens_editor_validate_guis
                    # |------- clear input data -------| #
                    - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                        - flag <player> citizens_editor.awaiting_input:!
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - inventory open destination:<[current]>
                - case adjust-prefix-debug:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub-title "<&d><&l>editor debug prefix"
                    - define message "<&b><&l>Awaiting Input"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- check input -------| #
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        # |------- validate input -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - if ( not <[keywords].contains[<[input]>]> ):
                            # |------- dialog data -------| #
                            - define gui_name npce_dialog
                            - define title "<&8><&l>Save New Prefix?"
                                # |------- open dialog -------| #
                            - inject citizens_editor_open_dialog
                            # |------- validate dialog -------| #
                            - define dialog <player.flag[citizens_editor.awaiting_dialog].if_null[false]>
                            - if ( <[dialog]> ):
                                # |------- clear dialog data -------| #
                                - flag <player> citizens_editor.awaiting_dialog:!
                                # |------- update setting -------| #
                                - define target citizens_editor.settings.prefixes.debug
                                - if ( <server.has_flag[<[target]>]> ):
                                    - flag server <[target]>:<[input].parsed>
                                    - narrate "<[prefix]> <&f>Debug prefix updated to <[input].parsed>"
                                # |------- validate inventories -------| #
                                - inject citizens_editor_validate_guis
                    # |------- clear input data -------| #
                    - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                        - flag <player> citizens_editor.awaiting_input:!
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - inventory open destination:<[current]>
                - case adjust-prefix-npc:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub-title "<&d><&l>npc proximity prefix"
                    - define message "<&b><&l>Awaiting Input"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- check input -------| #
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        # |------- validate input -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - if ( not <[keywords].contains[<[input]>]> ):
                            # |------- dialog data -------| #
                            - define gui_name npce_dialog
                            - define title "<&8><&l>Save New Prefix?"
                                # |------- open dialog -------| #
                            - inject citizens_editor_open_dialog
                            # |------- validate dialog -------| #
                            - define dialog <player.flag[citizens_editor.awaiting_dialog].if_null[false]>
                            - if ( <[dialog]> ):
                                # |------- clear dialog data -------| #
                                - flag <player> citizens_editor.awaiting_dialog:!
                                # |------- update setting -------| #
                                - define target citizens_editor.settings.prefixes.npc
                                - if ( <server.has_flag[<[target]>]> ):
                                    - flag server <[target]>:<[input]>
                                    - narrate "<[prefix]> <&f>Npc prefix updated to <[input].parsed.replace_text[npc.id].with[<&lt>npc.id<&gt>].if_null[<[input]>]>"
                                # |------- validate inventories -------| #
                                - inject citizens_editor_validate_guis
                    # |------- clear input data -------| #
                    - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                        - flag <player> citizens_editor.awaiting_input:!
                    - if ( <player.has_flag[citizens_editor.received_input]> ):
                        - flag <player> citizens_editor.received_input:!
                    # |------- open current inventory -------| #
                    - inventory open destination:<[current]>

        after player left clicks item_flagged:npce-gui-button in citizens_editor_interrupt_gui|npce_interrupt_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_interrupt_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_interrupt_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_interrupt_page]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - if ( <[current]> != <[previous]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:<[current]>
                        - flag <player> citizens_editor.gui.previous:<[next]>
                        # |------- open previous gui -------| #
                        - define gui_name <[previous]>
                        - inject citizens_editor_open_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_inventory_gui|npce_gui_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_gui_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_gui_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_gui_page]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - if ( <[current]> != <[previous]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:<[current]>
                        - flag <player> citizens_editor.gui.previous:<[next]>
                        # |------- open previous gui -------| #
                        - define gui_name <[previous]>
                        - inject citizens_editor_open_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #


