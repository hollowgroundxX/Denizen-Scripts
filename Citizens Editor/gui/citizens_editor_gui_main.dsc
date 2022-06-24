


# | ----------------------------------------------  CITIZENS EDITOR | MAIN INVENTORY  ---------------------------------------------- | #



citizens_editor_menu_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: <server.flag[citizens_editor.settings.interface.settings.gui-titles.main-menu].parsed>
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.next-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.previous-page]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
        skin-page: <item[player_head].with[display=<&d><&l>Skin <&f><&l>Editor]>
        profiles-page: <item[book].with_flag[npce-gui-button:profile-editor-gui].with[display=<&d><&l>Profile <&f><&l>Editor]>
        settings-page: <item[repeating_command_block].with_flag[npce-gui-button:settings-gui].with[display=<&d><&l>Editor <&f><&l>Settings]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [skin-page] [center-fill] [profiles-page] [center-fill] [settings-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ----------------------------------------------  CITIZENS EDITOR | GUI EVENT HANDLER  ---------------------------------------------- | #



citizens_editor_main_gui_handler:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
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
                    - inject citizens_editor_open_cached_inventory
                - case next-page:
                    - inject citizens_editor_open_cached_inventory
                - case settings-gui:
                    # |------- open settings gui -------| #
                    - inject citizens_editor_open_inventory
                - case profile-editor-gui:
                    # |------- open profile editor gui -------| #
                    - inject citizens_editor_open_inventory



# | ------------------------------------------------------------------------------------------------------------------------------ | #


