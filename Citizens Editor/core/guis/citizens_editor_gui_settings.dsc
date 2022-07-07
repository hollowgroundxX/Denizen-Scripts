


# | ----------------------------------------------  CITIZENS EDITOR | SETTINGS INVENTORY  ---------------------------------------------- | #



citizens_editor_settings_gui:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.settings].parse_color>
    gui: true
    definitions:
        placeholder: <item[barrier].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        permissions-page: <item[command_block].with_flag[npce-gui-button:permissions-page].with[display=<&d><&l>Permissions <&f><&l>Settings]>
        prefixes-page: <item[name_tag].with_flag[npce-gui-button:prefixes-page].with[display=<&d><&l>Prefix <&f><&l>Settings]>
        profiles-page: <item[book].with_flag[npce-gui-button:profiles-page].with[display=<&d><&l>Profiles <&f><&l>Settings]>
        interrupt-page: <item[structure_void].with_flag[npce-gui-button:interrupt-page].with[display=<&d><&l>Interrupt <&f><&l>Settings]>
        gui-page: <item[chest].with_flag[npce-gui-button:gui-page].with[display=<&d><&l>Gui <&f><&l>Settings]>
        discord-link: <item[player_head].with_flag[npce-gui-button:discord-link].with[display=<&d><&l>Discord <&f><&l>Link;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.discord-link]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [discord-link] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [profiles-page] [center-fill] [gui-page] [center-fill] [interrupt-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [prefixes-page] [center-fill] [permissions-page] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_permissions_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.permissions-page].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main].parse_color>]>
        debug-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-debug].with[display=<server.flag[citizens_editor.settings.prefixes.debug]>]>
        npc-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-npc].with[display=<server.flag[citizens_editor.settings.prefixes.npc].parsed.replace_text[npc.id].with[<&lt>npc.id<&gt>].if_null[<server.flag[citizens_editor.settings.prefixes.npc].parsed>]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [debug-prefix] [center-fill] [npc-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_prefixes_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.prefixes-page].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main].parse_color>]>
        debug-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-debug].with[display=<server.flag[citizens_editor.settings.prefixes.debug].parse_color>]>
        npc-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-npc].with[display=<server.flag[citizens_editor.settings.prefixes.npc].parse_color.parsed.replace_text[npc.id].with[<&lt>npc.id<&gt>].if_null[<server.flag[citizens_editor.settings.prefixes.npc].parsed>]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [debug-prefix] [center-fill] [npc-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_profiles_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.profiles-page].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main].parse_color>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_interrupt_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.interrupt-page].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main].parse_color>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_gui_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.gui-page].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main].parse_color>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ----------------------------------------------  CITIZENS EDITOR | GUI EVENT HANDLER  ---------------------------------------------- | #



citizens_editor_settings_gui_handler:
    type: world
    debug: true
    events:
        ##################################################
        # | ---  |       inventory events       |  --- | #
        ##################################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_settings_gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next
                - case permissions-page:
                    # |------- open prefixes gui -------| #
                    - inject htools_uix_manager path:open
                - case prefixes-page:
                    # |------- open prefixes gui -------| #
                    - inject htools_uix_manager path:open
                - case profiles-page:
                    # |------- open profiles gui -------| #
                    - inject htools_uix_manager path:open
                - case interrupt-page:
                    # |------- open interrupt gui -------| #
                    - inject htools_uix_manager path:open
                - case gui-page:
                    # |------- open inventory gui -------| #
                    - inject htools_uix_manager path:open



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_permissions_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_prefixes_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next

                # |------------------------------| #
                # | ---  adjust main prefix  --- | #
                # |------------------------------| #
                - case adjust-prefix-main:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>npc editor prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_title "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject htools_dialog_manager path:open_input_dialog
                    - define gui-id previous-page
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - define dialog <player.flag[citizens_editor.received_dialog]>
                        # |------- clear dialog data -------| #
                        - flag <player> citizens_editor.received_dialog:!
                        # |------- check dialog -------| #
                        - if ( <[dialog]> ):
                            # |------- update setting -------| #
                            - define flag citizens_editor.settings.prefixes.main
                            - if ( <server.has_flag[<[flag]>]> ):
                                - flag server <[flag]>:<[input].parse_color>
                                - narrate "<[prefix]> <&f>Main prefix updated to <[input].parse_color>"
                                # |------- validate inventory -------| #
                                - inject htools_uix_manager path:validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject htools_uix_manager path:open_previous

                # |-------------------------------| #
                # | ---  adjust debug prefix  --- | #
                # |-------------------------------| #
                - case adjust-prefix-debug:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>editor debug prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_title "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject htools_dialog_manager path:open_input_dialog
                    - define gui-id previous-page
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - define dialog <player.flag[citizens_editor.received_dialog]>
                        # |------- clear dialog data -------| #
                        - flag <player> citizens_editor.received_dialog:!
                        # |------- check dialog -------| #
                        - if ( <[dialog]> ):
                            # |------- update setting -------| #
                            - define flag citizens_editor.settings.prefixes.debug
                            - if ( <server.has_flag[<[flag]>]> ):
                                - flag server <[flag]>:<[input].parse_color>
                                - narrate "<[prefix]> <&f>Main prefix updated to <[input].parse_color>"
                                # |------- validate inventory -------| #
                                - inject htools_uix_manager path:validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject htools_uix_manager path:open_previous

                # |-----------------------------| #
                # | ---  adjust npc prefix  --- | #
                # |-----------------------------| #
                - case adjust-prefix-npc:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub_title "<&d><&l>npc proximity prefix"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_title "<&8><&l>Save New Prefix?"
                    # |------- open input dialog -------| #
                    - inject htools_dialog_manager path:open_input_dialog
                    - define gui-id previous-page
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define input <player.flag[citizens_editor.received_input]>
                        - define dialog <player.flag[citizens_editor.received_dialog]>
                        # |------- clear dialog data -------| #
                        - flag <player> citizens_editor.received_dialog:!
                        # |------- check dialog -------| #
                        - if ( <[dialog]> ):
                            # |------- update setting -------| #
                            - define flag citizens_editor.settings.prefixes.npc
                            - if ( <server.has_flag[<[flag]>]> ):
                                - flag server <[flag]>:<[input].parse_color.parsed>
                                - narrate "<[prefix]> <&f>Main prefix updated to <[input].parse_color.parsed>"
                                # |------- validate inventory -------| #
                                - inject htools_uix_manager path:validate_inventory
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject htools_uix_manager path:open_previous



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_profiles_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_interrupt_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_gui_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  navigate to previous  --- | #
                # |--------------------------------| #
                - case previous-page:
                    - inject htools_uix_manager path:open_previous
                # |----------------------------| #
                # | ---  navigate to next  --- | #
                # |----------------------------| #
                - case next-page:
                    - inject htools_uix_manager path:open_next



# | ------------------------------------------------------------------------------------------------------------------------------ | #


