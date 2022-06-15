


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_main_menu_gui:
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
        settings-page: <item[chain_command_block].with_flag[npce-gui-button:settings-page].with[display=<&d><&l>Settings;lore=<&nl><&7>editor settings]>
        profiles-page: <item[book].with_flag[npce-gui-button:profiles-page].with[display=<&d><&l>Profile Editor;lore=<&nl><&7>profile editor]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [profiles-page] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [placeholder] [center-fill] [settings-page] [center-fill] [placeholder] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_main_menu_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
        ##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_main_menu_gui|npce_main_menu:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_main_menu]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_main_menu]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_main_menu]>
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
                        - inventory close
                        - playsound <player> sound:UI_BUTTON_CLICK pitch:1
                - case next-page:
                    - if ( <[current]> != <[next]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:!
                        - flag <player> citizens_editor.gui.previous:<[current]>
                        # |------- open next gui -------| #
                        - define gui_name <[next]>
                        - inject citizens_editor_open_gui
                    - else:
                        - playsound <player> sound:UI_BUTTON_CLICK pitch:1
                - case settings-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:!
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_settings_page
                    - inject citizens_editor_open_gui
                - case profiles-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:!
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open profiles gui -------| #
                    - define gui_name npce_profiles_page
                    - inject citizens_editor_open_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #


