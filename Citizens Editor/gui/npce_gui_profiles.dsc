


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_profiles_gui:
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
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [next-page] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_profiles_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
        ##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_profiles_gui|npce_profiles_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_profiles_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_profiles_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_profiles_page]>
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
                        - flag <player> citizens_editor.gui.next:!
                        - flag <player> citizens_editor.gui.previous:<[current]>
                        # |------- open next gui -------| #
                        - define gui_name <[next]>
                        - inject citizens_editor_open_gui
                    - else:
                        - playsound <player> sound:UI_BUTTON_CLICK pitch:1



# | ------------------------------------------------------------------------------------------------------------------------------ | #


