


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_profiles_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <&8><&l>Profile Editor
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[next-page]||<script[citizens_editor_profiles_gui].data_key[data.errors].get[invalid-skull]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[previous-page]||<script[citizens_editor_profiles_gui].data_key[data.errors].get[invalid-skull]>>]>
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
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
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
                - case next-page:
                    - if ( <[current]> != <[next]> ):
                        # |------- adjust navigation flags -------| #
                        - flag <player> citizens_editor.gui.next:!
                        - flag <player> citizens_editor.gui.previous:<[current]>
                        # |------- open next gui -------| #
                        - define gui_name <[next]>
                        - inject citizens_editor_open_gui



# | ------------------------------------------------------------------------------------------------------------------------------ | #


