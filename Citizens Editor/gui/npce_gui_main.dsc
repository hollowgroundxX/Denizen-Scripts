


# | ----------------------------------------------  CITIZENS EDITOR | INVENTORIES  ---------------------------------------------- | #



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
        settings-page: <item[chain_command_block].with_flag[npce-gui-button:settings-gui].with[display=<&d><&l>Settings;lore=<&nl><&7>editor settings]>
        profiles-page: <item[book].with_flag[npce-gui-button:profile-editor-gui].with[display=<&d><&l>Profile Editor;lore=<&nl><&7>profile editor]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [profiles-page] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [settings-page] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_menu_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
        ##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_menu_gui|menu-gui:
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
                - case settings-gui:
                    # |------- open settings gui -------| #
                    - inject citizens_editor_open_gui
                - case profile-editor-gui:
                    # |------- open profile editor gui -------| #
                    - inject citizens_editor_open_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #


