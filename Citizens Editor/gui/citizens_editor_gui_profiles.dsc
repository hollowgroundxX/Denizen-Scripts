


# | ----------------------------------------------  CITIZENS EDITOR | PROFILE EDITOR INVENTORY  ---------------------------------------------- | #



citizens_editor_profile_editor_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.profile-editor].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        create-profile: <item[player_head].with_flag[npce-gui-button:create-profile].with[display=<&d><&l>Create <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.create-profile]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        copy-profile: <item[player_head].with_flag[npce-gui-button:copy-profile].with[display=<&d><&l>Copy <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.copy-profile]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [copy-profile] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [edge-fill] [] [] [] [] [] [] [] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [create-profile] [next-page] [edge-fill] [edge-fill] [corner-fill]
    procedural items:
        - define profiles-db <server.flag[citizens_editor.profiles].if_null[<map[<empty>]>]>
        - if ( <server.flag[citizens_editor.profiles].size.if_null[0]> <= 0  ):
            - determine <empty>
        - else:
            - define inventory <inventory[<player.flag[citizens_editor.gui.current]>].if_null[null]>
            - define noted <server.notes[inventories].contains[<[inventory]>]>
            - if ( <[noted]> ):
                - define profiles <list.pad_right[<element[28].sub[<[profiles-db].size>]>]>
                - foreach <[profiles-db].reverse> as:data:
                    - define name <[data].get[name].parse_color.if_null[<[name].parse_color[<&lb>]>]>
                    - define profiles:->:<item[player_head].with_flag[npc-profile:<[name].strip_color>].with[display=<[name]>]>
                - define profiles "<[profiles].replace[<empty>].with[<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>]>"
                - determine <[profiles].reverse>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_profile_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: Dialog Text Placeholder
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        create-profile: <item[player_head].with_flag[npce-gui-button:create-profile].with[display=<&d><&l>Create <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.create-profile]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        delete-profile: <item[player_head].with_flag[npce-gui-button:delete-profile].with[display=<&d><&l>Delete <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.delete-profile]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        rename-profile: <item[player_head].with_flag[npce-gui-button:rename-profile].with[display=<&d><&l>Rename <&f><&l>Profile;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.rename-profile]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
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



citizens_editor_profiles_gui_handler:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
        ######################################
		# |------- inventory events -------| #
		######################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_profile_editor_gui|profile-editor-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_inventory
                - case next-page:
                    - inject citizens_editor_open_cached_inventory
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
                    - inject citizens_editor_open_input_dialog
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
                            - define flag citizens_editor.profiles
                            - define input <[input].parse_color.if_null[<[input].parse_color[<&lb>]>]>
                            - if ( <server.has_flag[<[flag]>]> ):
                                - if not ( <server.flag[<[flag]>].contains[<[input].strip_color>]> ):
                                    - definemap default_profile:
                                        name: <[input]>
                                    - flag server <[flag]>.<[input].strip_color>:<[default_profile]>
                                    - narrate "<[prefix]> <&f>NPC profile '<&b><[input]><&f>' created."
                                    # |------- validate inventory -------| #
                                    - inject citizens_editor_validate_inventory
                                - else:
                                    - narrate "<[prefix]> <&c>A profile with the name '<&f><[input]><&c>' already exists."
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - inject citizens_editor_open_cached_inventory

        after player left clicks item_flagged:npc-profile in citizens_editor_profile_editor_gui|profile-editor-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npc-profile].if_null[null]>
            - if ( <server.flag[citizens_editor.profiles].contains[<[button-id]>]> ):
                - define profile-id <server.flag[citizens_editor.profiles].get[<[button-id]>]>
                - define gui_title "<&8><&l>Edit -<&gt> <[profile-id].get[name].parse_color.if_null[<[profile-id].get[name].parse_color[<&lb>]>]>"
                - inject citizens_editor_open_profile_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #



        after player left clicks item_flagged:npce-gui-button in citizens_editor_profile_gui|profile-page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define keywords <server.flag[citizens_editor.settings.editor.dialog-event.cancel-input-keywords]||<list[]>>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            - define gui-id <[button-id]>
            - define profile-id <player.flag[citizens_editor.profile].parse_color.if_null[<player.flag[citizens_editor.profile].parse_color[<&lb>]>]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case previous-page:
                    - inject citizens_editor_open_cached_inventory
                - case next-page:
                    - inject citizens_editor_open_cached_inventory
                - case delete-profile:
                    # |------- check flag -------| #
                    - define gui_title "<&8><&l>Delete <[profile-id]>?"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_dialog
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                        # |------- dialog data -------| #
                        - define dialog <player.flag[citizens_editor.received_dialog]>
                        # |------- clear dialog data -------| #
                        - flag <player> citizens_editor.received_dialog:!
                        # |------- check dialog -------| #
                        - if ( <[dialog]> ):
                            # |------- update setting -------| #
                            - define flag citizens_editor.profiles.<[profile-id].strip_color>
                            - if ( <server.has_flag[<[flag]>]> ):
                                - flag server <[flag]>:!
                                - narrate "<[prefix]> <&c>Profile '<&f><[profile-id]><&c>' deleted."
                                # |------- validate and open previous inventory -------| #
                                - define gui-id previous-page-2
                                - inject citizens_editor_validate_inventory
                                - inject citizens_editor_open_cached_inventory
                            - else:
                                - narrate "<[prefix]> <&c>A profile with the name '<&f><[profile-id]><&c>' doesn't exist."
                    - else:
                        # |------- open previous inventory -------| #
                        - define gui-id previous-page
                        - inject citizens_editor_open_cached_inventory



# | ------------------------------------------------------------------------------------------------------------------------------ | #


