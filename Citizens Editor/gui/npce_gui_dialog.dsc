


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_dialog_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        skulls:
            confirm: 04049c90-d3e9-4621-9caf-0000aaa21774|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNDMxMmNhNDYzMmRlZjVmZmFmMmViMGQ5ZDdjYzdiNTVhNTBjNGUzOTIwZDkwMzcyYWFiMTQwNzgxZjVkZmJjNCJ9fX0=
            deny: 04049c90-d3e9-4621-9caf-00000aaa9348|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTdmOWM2ZmVmMmFkOTZiM2E1NDY1NjQyYmE5NTQ2NzFiZTFjNDU0M2UyZTI1ZTU2YWVmMGE0N2Q1ZjFmIn19fQ==
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: Dialog Text Placeholder
    gui: true
    definitions:
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        green-fill: <item[green_stained_glass_pane].with[display=<&d> <empty>]>
        red-fill: <item[red_stained_glass_pane].with[display=<&d> <empty>]>
        confirm-dialog: <item[player_head].with_flag[npce-gui-button:confirm].with[display=<&a><&l>Confirm;skull_skin=<script[citizens_editor_dialog_gui].data_key[data.skulls].get[confirm]||<script[citizens_editor_dialog_gui].data_key[data.errors].get[invalid-skull]>>]>
        deny-dialog: <item[player_head].with_flag[npce-gui-button:deny].with[display=<&c><&l>Deny;skull_skin=<script[citizens_editor_dialog_gui].data_key[data.skulls].get[deny]||<script[citizens_editor_dialog_gui].data_key[data.errors].get[invalid-skull]>>]>
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
                - flag <player> citizens_editor.awaiting_input:!
                - flag <player> citizens_editor.recieved_input:<context.message>
            - determine cancelled

        ##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_dialog_gui|npce_dialog:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_dialog]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_dialog]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_dialog]>
            - define button-id <context.item.flag[npce-gui-button].if_null[null]>
            # |------- context check -------| #
            - choose <[button-id]>:
                - case default:
                    # |------- invalid button-id -------| #
                    - narrate "<[prefix]> <&c>The inventory you attempted to open is not properly stored within the inventories database."
                    - stop
                - case confirm:
                    - flag <player> citizens_editor.awaiting_dialog:true
                - case deny:
                    - flag <player> citizens_editor.awaiting_dialog:false



# | ------------------------------------------------------------------------------------------------------------------------------ | #


