


# | ----------------------------------------------  CITIZENS EDITOR | ROOT INVENTORY  ---------------------------------------------- | #



citizens_editor_root_gui:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.main-menu].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        skins-page: <item[player_head].with_flag[gui-button:skin-editor-gui].with[display=<&d><&l>Skin <&f><&l>Editor]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>
        profiles-page: <item[book].with_flag[gui-button:profile-editor-gui].with[display=<&d><&l>Profile <&f><&l>Editor]>
        dialogs-page: <item[player_head].with_flag[gui-button:dialog-editor-gui].with[display=<&d><&l>Dialog <&f><&l>Editor;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.dialog-editor]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        settings-page: <item[chain_command_block].with_flag[gui-button:settings-gui].with[display=<&d><&l>Settings]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [skins-page] [center-fill] [profiles-page] [center-fill] [dialogs-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [settings-page] [] [edge-fill] [edge-fill] [corner-fill]
    procedural items:
        # |------- procedural data -------| #
        - define gui-id <script.name.replace_text[<server.flag[citizens_editor.settings.script-id].parse_color.strip_color>_].with[<empty>].replace_text[regex:_|<&sp>].with[-]>
        - define next <player.flag[citizens_editor.gui.next].if_null[<list[<empty>]>]>
        # |------- procedural items -------| #
        - define fill-item <script.data_key[definitions].get[center-fill].parsed>
        - define next-page-item <script.data_key[definitions].get[next-page].parsed>
        # |------- list profiles + fill button -------| #
        - if ( <[next].is_empty> ) || ( <[next]> contains <[gui-id]> ):
            - if ( <[gui-id]> != <[next].last.if_null[<[gui-id]>]> ):
                - determine <[next-page-item]>
            - else:
                - determine <[fill-item]>



# | ----------------------------------------------  CITIZENS EDITOR | GUI EVENT HANDLER  ---------------------------------------------- | #



citizens_editor_root_gui_handler:
    type: world
    debug: true
    events:
        ##################################################
        # | ---  |       inventory events       |  --- | #
        ##################################################
        on player opens citizens_editor_root_gui:
            # |------- procedural items -------| #
            - define last-id <player.flag[gui_handler.next].last.if_null[<context.inventory.note_name>]>
            - define fill-item <script[citizens_editor_root_gui].data_key[definitions].get[center-fill].parsed>
            - define next-page-item <script[citizens_editor_root_gui].data_key[definitions].get[next-page].parsed>
            # |------- check state -------| #
            - if ( <[last-id]> == <context.inventory.note_name> ) && ( <context.inventory.list_contents.contains[<[next-page-item]>]> ):
                # |------- update inventory slot -------| #
                - inventory set destination:<context.inventory> origin:<[fill-item]> slot:<context.inventory.find_item[raw_exact:<[next-page-item]>]>

        after player left clicks item_flagged:gui-button in citizens_editor_root_gui:
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define script-id <server.flag[citizens_editor.settings.script-id].parse_color.strip_color>
            - define button-id <context.item.flag[gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case default:
                    # |------- invalid gui -------| #
                    - stop
                - case previous-page:
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case next-page:
                    # |------- open next gui -------| #
                    - run gui_handler path:open.next def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case skin-editor-gui:
                    # |------- open skin editor gui -------| #
                    - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case profile-editor-gui:
                    # |------- open profile editor gui -------| #
                    - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case settings-gui:
                    # |------- open settings gui -------| #
                    - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
            # |------- procedural data -------| #
            - define fill-item <script[citizens_editor_root_gui].data_key[definitions].get[center-fill].parsed>
            - define next-page-item <script[citizens_editor_root_gui].data_key[definitions].get[next-page].parsed>
            # |------- check state -------| #
            - if ( not <context.clicked_inventory.list_contents.contains[<[next-page-item]>]> ):
                # |------- update inventory slot -------| #
                - inventory set destination:<context.clicked_inventory> origin:<[next-page-item]> slot:42
            - if ( <player.flag[citizens_editor.debug_mode]> ):
                - narrate "<&nl>Current: <player.flag[gui_handler.current]><&nl>Next: <player.flag[gui_handler.next]><&nl>Previous: <player.flag[gui_handler.previous]><&nl>"




# | ------------------------------------------------------------------------------------------------------------------------------ | #


