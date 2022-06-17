


# | ----------------------------------------------  CITIZENS EDITOR | INVENTORIES  ---------------------------------------------- | #



citizens_editor_dialog_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    inventory: CHEST
    title: Dialog Text Placeholder
    gui: true
    definitions:
        test: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        green-fill: <item[green_stained_glass_pane].with[display=<&d> <empty>]>
        red-fill: <item[red_stained_glass_pane].with[display=<&d> <empty>]>
        confirm-dialog: <item[player_head].with_flag[npce-gui-button:confirm].with[display=<&a><&l>Confirm;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.confirm-button]||>]>
        deny-dialog: <item[player_head].with_flag[npce-gui-button:deny].with[display=<&c><&l>Deny;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.deny-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [deny-dialog] [red-fill] [edge-fill] [green-fill] [confirm-dialog] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_dialog_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
        ##################################
		# |------- input events -------| #
		##################################
        on player flagged:citizens_editor.awaiting_input chats:
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                - flag <player> citizens_editor.received_input:<context.message>
                - flag <player> citizens_editor.awaiting_input:!
            - determine cancelled

        ##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_dialog_gui|dialog-gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main]>
            - define current <player.flag[citizens_editor.gui.current]>
            - define next <player.flag[citizens_editor.gui.next]>
            - define previous <player.flag[citizens_editor.gui.previous]>
            - define button-id <context.item.flag[npce-gui-button]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case confirm:
                    - flag <player> citizens_editor.awaiting_dialog:true
                    - playsound <player> sound:entity_experience_orb_pickup pitch:1
                - case deny:
                    - flag <player> citizens_editor.awaiting_dialog:false



# | ------------------------------------------------------------------------------------------------------------------------------ | #


