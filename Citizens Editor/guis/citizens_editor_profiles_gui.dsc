


# | ----------------------------------------------  CITIZENS EDITOR | PROFILE EDITOR INVENTORY  ---------------------------------------------- | #



citizens_editor_profile_editor_gui:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.profile-editor].parse_color>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        create-profile: <item[player_head].with_flag[npce-gui-button:create-profile].with[display=<&d><&l>Create <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.create-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        copy-profile: <item[player_head].with_flag[npce-gui-button:copy-profile].with[display=<&d><&l>Copy <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.copy-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [copy-profile] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [create-profile] [] [edge-fill] [edge-fill] [corner-fill]
    procedural items:
        # |------- procedural data -------| #
        - define root <server.flag[citizens_editor.ast].keys.first>-gui
        - define gui-id <script.name.replace_text[citizens_editor_].with[<empty>].replace_text[regex:_|<&sp>].with[-]>
        - define next <player.flag[citizens_editor.gui.next].if_null[<map[<empty>]>]>
        - define profiles-db <server.flag[citizens_editor.profiles].if_null[<map[<empty>]>]>
        # |------- procedural items -------| #
        - define fill-item <script.data_key[definitions].get[center-fill].parsed>
        - define next-page-item <script.data_key[definitions].get[next-page].parsed>
        # |------- empty profiles -------| #
        - if ( <server.flag[citizens_editor.profiles].size.if_null[0]> <= 0  ):
            - determine <list.pad_right[29].replace[<empty>].with[<[fill-item]>].overwrite[<[fill-item]>].at[29]>
        - else:
            # |------- gather profiles -------| #
            - define profiles <list.pad_right[<element[29].sub[<[profiles-db].size>]>]>
            - foreach <[profiles-db].reverse> as:profile:
                - define parsed <[profile].get[name].parse_color>
                - define stripped <[parsed].strip_color>
                - define profiles:->:<item[player_head].with_flag[npce-profile:<[stripped]>].with[display=<[parsed]>]>
            # |------- list profiles + fill button -------| #
            - narrate <[next].contains[<[gui-id]>]>
            - if ( <[next].is_empty> ) || ( <[next].exclude[<[root]>].is_empty> ) || ( <[next]> contains <[gui-id]> ):
                - if ( <[gui-id]> != <[next].last.if_null[<[gui-id]>]> ):
                    - determine <[profiles].reverse.replace[<empty>].with[<[fill-item]>].overwrite[<[next-page-item]>].at[<[profiles].size>]>
                - else:
                    - determine <[profiles].reverse.replace[<empty>].with[<[fill-item]>].overwrite[<[fill-item]>].at[<[profiles].size>]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_profile_page:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: Profile Title Placeholder
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        create-profile: <item[player_head].with_flag[npce-gui-button:create-profile].with[display=<&d><&l>Create <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.create-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        delete-profile: <item[player_head].with_flag[npce-gui-button:delete-profile].with[display=<&d><&l>Delete <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.delete-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        rename-profile: <item[player_head].with_flag[npce-gui-button:rename-profile].with[display=<&d><&l>Rename <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.rename-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [delete-profile] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [placeholder] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [placeholder] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [rename-profile] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ----------------------------------------------  CITIZENS EDITOR | GUI EVENT HANDLER  ---------------------------------------------- | #



citizens_editor_profile_editor_gui_handler:
    type: world
    debug: true
    events:
        ##################################################
        # | ---  |       inventory events       |  --- | #
        ##################################################
        on player opens citizens_editor_profile_editor_gui:
            # |------- procedural items -------| #
            - define last-id <player.flag[gui_handler.next].last.if_null[<context.inventory.note_name>]>
            - define fill-item <script[<context.inventory.script.name>].data_key[definitions].get[center-fill].parsed>
            - define next-page-item <script[<context.inventory.script.name>].data_key[definitions].get[next-page].parsed>
            # |------- check state -------| #
            - if ( <[last-id]> == <context.inventory.note_name> ) && ( <context.inventory.list_contents.contains[<[next-page-item]>]> ):
                # |------- update inventory slot -------| #
                - inventory set destination:<context.inventory> origin:<[fill-item]> slot:<context.inventory.find_item[raw_exact:<[next-page-item]>]>

        after player left clicks item_flagged:npce-profile in citizens_editor_profile_editor_gui:
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-profile].if_null[null]>
            - if ( <server.flag[citizens_editor.profiles].contains[<[button-id]>]> ):
                # |------- open profile inventory -------| #
                - define profile-id <server.flag[citizens_editor.profiles].get[<[button-id]>]>
                - define parsed <[profile-id].get[name].parse_color>
                - define stripped <[parsed].strip_color>
                - define gui_title "<&8><&l>Edit -<&gt> <[stripped]>"
                - inject <script.name> path:open_profile
                # |------- update inventory slot -------| #
                - define next-page-item <script[<context.clicked_inventory.script.name>].data_key[definitions].get[next-page].parsed>
                - if ( not <context.clicked_inventory.list_contents.contains[<[next-page-item]>]> ):
                    - inventory set destination:<context.clicked_inventory> origin:<[next-page-item]> slot:51

        after player left clicks item_flagged:npce-gui-button in citizens_editor_profile_editor_gui:
            # |------- event data -------| #
            - define script-id <server.flag[citizens_editor.settings.script-id].parse_color.strip_color>
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case next-page:
                    # |------- open next gui -------| #
                    - run gui_handler path:open.next def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case create-profile:
                    # |------- check flag -------| #
                    - if not ( <server.has_flag[citizens_editor.profiles]> ):
                        - flag server citizens_editor.profiles:<list[empty]>
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a Name"
                    - define sub_title "<&d><&l>for the npc profile"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_title "<&8><&l>Create New Profile?"
                    # |------- open input dialog -------| #
                    - run <[script-id]>_dialog_gui_handler path:open.input def.script-id:<[script-id]> def.title:<[title]> def.sub_title:<[sub_title]> def.bossbar:<[bossbar]> def.gui_title:<[gui_title]> def.prefix:<[prefix]> save:open_input
                    - define input <entry[open_input].created_queue.determination.get[1]>
                    - if ( <[input]> ):
                        # |------- create profile -------| #
                        - define parsed <[input].parse_color>
                        - define stripped <[parsed].strip_color>
                        - define container citizens_editor.profiles
                        - if not ( <server.flag[<[container]>].contains[<[stripped]>]> ):
                            - definemap default_profile:
                                name: <[input]>
                            - flag server <[container]>.<[stripped]>:<[default_profile]>
                            - narrate "<[prefix]> <&f>Profile '<&b><[stripped]><&f>' created."
                            # |------- validate inventory -------| #
                            - run gui_handler path:validate.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]>
                        - else:
                            - narrate "<[prefix]> <&c>Profile id '<&f><[stripped]><&c>' already exists."
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_profile_page:
            # |------- event data -------| #
            - define script-id <server.flag[citizens_editor.settings.script-id].parse_color.strip_color>
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            - define profile-id <player.flag[citizens_editor.profile]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case next-page:
                    # |------- open next gui -------| #
                    - run gui_handler path:open.next def.script-id:<[script-id]> def.gui-id:<[button-id]> def.prefix:<[prefix]>
                - case delete-profile:
                    # |------- inventory data -------| #
                    - define gui_title "<&8><&l>Delete <[profile-id].parse_color>?"
                    - run <[script-id]>_dialog_gui_handler path:open.dialog def.script-id:<[script-id]> def.gui_title:<[gui_title]> save:open_dialog
                    - if ( <entry[open_dialog].created_queue.determination.get[1]> ):
                        # |------- parsed data -------| #
                        - define parsed <[profile-id].parse_color>
                        - define stripped <[parsed].strip_color>
                        - define container citizens_editor.profiles.<[stripped]>
                        # |------- flag check -------| #
                        - if ( <server.has_flag[<[container]>]> ):
                            # |------- delete profile-id -------| #
                            - flag server <[container]>:!
                            - narrate "<[prefix]> <&c>Profile '<&f><[stripped]><&c>' deleted."
                            # |------- validate and open previous inventory -------| #
                            - run gui_handler path:validate.gui def.script-id:<[script-id]> def.gui-id:previous-page-2 def.prefix:<[prefix]>
                            - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:previous-page-2 def.prefix:<[prefix]>
                            # |------- stop queue -------| #
                            - stop
                        - else:
                            - narrate "<[prefix]> <&c>Profile id '<&f><[stripped]><&c>' doesn't exist."
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:previous-page def.prefix:<[prefix]>
                - case rename-profile:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a new ID"
                    - define sub_title "<&d><&l>for <[profile-id].parse_color.strip_color>"
                    - define bossbar "<&b><&l>Awaiting Input"
                    - define gui_title "<&8><&l>Rename <[profile-id].parse_color.strip_color>?"
                    # |------- open input dialog -------| #
                    - run <[script-id]>_dialog_gui_handler path:open.input def.script-id:<[script-id]> def.title:<[title]> def.sub_title:<[sub_title]> def.bossbar:<[bossbar]> def.gui_title:<[gui_title]> def.prefix:<[prefix]> save:open_input
                    - define input <entry[open_input].created_queue.determination.get[1]>
                    - if ( <[input]> ):
                        # |------- parsed data -------| #
                        - define parsed_old <[profile-id].parse_color>
                        - define stripped_old <[parsed_old].strip_color>
                        - define parsed_new <[input].parse_color>
                        - define stripped_new <[parsed_new].strip_color>
                        - define container citizens_editor.profiles
                        # |------- flag check -------| #
                        - if not ( <server.flag[<[container]>].contains[<[stripped_new]>]> ):
                            # |------- update name -------| #
                            - flag server <[container]>.<[stripped_old]>.name:<[input]>
                            - define data <server.flag[<[container]>.<[stripped_old]>]>
                            # |------- update profile-id -------| #
                            - flag server <[container]>.<[stripped_old]>:!
                            - flag server <[container]>.<[stripped_new]>:<[data]>
                            - narrate "<[prefix]> <&f>Profile '<&b><[stripped_old]><&f>' renamed to '<&b><[stripped_new]><&f>' successfully."
                            # |------- validate and open previous inventory -------| #
                            - run gui_handler path:validate.gui def.script-id:<[script-id]> def.gui-id:previous-page-2 def.prefix:<[prefix]>
                            - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:previous-page-2 def.prefix:<[prefix]>
                            # |------- stop queue -------| #
                            - stop
                        - else:
                            - narrate "<[prefix]> <&c>Rename failed. Profile id '<&f><[stripped_new]><&c>' already exists."
                    # |------- open previous gui -------| #
                    - run gui_handler path:open.previous def.script-id:<[script-id]> def.gui-id:previous-page def.prefix:<[prefix]>



# | ----------------------------------------------  CITIZENS EDITOR | GUI TASKS  ---------------------------------------------- | #



    open_profile:
        ####################################################
        # | ---  |            Gui Task            |  --- | #
        ####################################################
	    # | ---                                      --- | #
        # | ---  Required:  prefix | gui_title       --- | #
	    # | ---                                      --- | #
        ####################################################
        # |------- inventory data -------| #
        - define script-id <server.flag[citizens_editor.settings.script-id].parse_color.strip_color>
        - define gui-id profile-page
        - run gui_handler path:validate.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]> save:validate_profile
        - if ( <entry[validate_profile].created_queue.determination.get[1]> ):
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
            - define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
            - flag <player> citizens_editor.profile:<[profile-id].get[name]>
            # |------- inventory check -------| #
            - if ( <[flagged]> ) && ( <[noted]> ):
                - if ( <[gui_title].exists> ):
                    # |------- adjust inventory -------| #
                    - adjust <inventory[<[gui-id]>]> title:<[gui_title]>
                    # |------- open dialog inventory -------| #
                    - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]>
                - else:
                    - narrate "<[prefix]> <&c>task.open_profile <&c>missing required parameter <&f>gui_title<&c>."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


