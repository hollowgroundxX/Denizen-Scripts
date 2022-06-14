


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_settings_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        skulls:
            save-settings: 04049c90-d3e9-4621-9caf-0000aaa10199|eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZmY3NDE2Y2U5ZTgyNmU0ODk5YjI4NGJiMGFiOTQ4NDNhOGY3NTg2ZTUyYjcxZmMzMTI1ZTAyODZmOTI2YSJ9fX0=
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <&8><&l>Editor <&5><&l>-<&gt> <&8><&l>Settings
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[next-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[previous-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        prefixes-page: <item[name_tag].with_flag[npce-gui-button:prefixes-page].with[display=<&d><&l>Prefix <&f><&l>Settings]>
        interrupt-page: <item[structure_void].with_flag[npce-gui-button:interrupt-page].with[display=<&d><&l>Interrupt <&f><&l>Settings]>
        gui-page: <item[chest].with_flag[npce-gui-button:gui-page].with[display=<&d><&l>Gui <&f><&l>Settings]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [prefixes-page] [center-fill] [interrupt-page] [center-fill] [gui-page] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_prefixes_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <&8><&l>Settings <&5><&l>-<&gt> <&8><&l>Prefixes
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[next-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[previous-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_interrupt_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <&8><&l>Settings <&5><&l>-<&gt> <&8><&l>Interrupt
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[next-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[previous-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_inventory_gui:
    ######################################
	# |------- inventory script -------| #
	######################################
    type: inventory
    debug: true
    data:
        errors:
            invalid-skull: <item[barrier].with[display=<&c><&l>Invalid skull uuid or texture]>
    inventory: CHEST
    title: <&8><&l>Settings <&5><&l>-<&gt> <&8><&l>Gui
    gui: true
    definitions:
        placeholder: <item[structure_void].with[display=<&d><&l>Placeholder]>
        corner-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        center-fill: <item[<script[citizens_editor_config].data_key[interface.materials].get[center-fill]||gray_stained_glass_pane>].with[display=<&d> <empty>]>
        next-page: <item[player_head].with_flag[npce-gui-button:next-page].with[display=<&d><&l>Next;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[next-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        previous-page: <item[player_head].with_flag[npce-gui-button:previous-page].with[display=<&d><&l>Previous;skull_skin=<script[citizens_editor_config].data_key[interface.skulls].get[previous-page]||<script[citizens_editor_settings_gui].data_key[data.errors].get[invalid-skull]>>]>
        main-prefix: <item[name_tag].with_flag[npce-gui-button:adjust-prefix-main].with[display=<server.flag[citizens_editor.settings.prefixes.main]>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [main-prefix] [center-fill] [edge-fill]
        - [edge-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [center-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [previous-page] [edge-fill] [center-fill] [edge-fill] [edge-fill] [corner-fill]



# | ---------------------------------------------- CITIZENS EDITOR | HANDLERS ---------------------------------------------- | #



citizens_editor_settings_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
		##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_settings_gui|npce_settings_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_settings_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_settings_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_settings_page]>
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
                - case prefixes-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:!
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_prefixes_page
                    - inject citizens_editor_open_gui
                - case interrupt-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:!
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_interrupt_page
                    - inject citizens_editor_open_gui
                - case gui-page:
                    # |------- adjust navigation flags -------| #
                    - flag <player> citizens_editor.gui.next:!
                    - flag <player> citizens_editor.gui.previous:<[current]>
                    # |------- open settings gui -------| #
                    - define gui_name npce_gui_page
                    - inject citizens_editor_open_gui

        after player left clicks item_flagged:npce-gui-button in citizens_editor_prefixes_gui|npce_prefixes_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_prefixes_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_prefixes_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_prefixes_page]>
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
                - case adjust-prefix-main:
                    # |------- input data -------| #
                    - define title "<&b><&l>Enter a New"
                    - define sub-title "<&d><&l>npc editor prefix"
                    - define message "<&b><&l>Awaiting Input"
                    # |------- open input dialog -------| #
                    - inject citizens_editor_open_input_dialog
                    # |------- validate input -------| #
                    - if ( <player.has_flag[citizens_editor.recieved_input]> ):
                        # |------- dialog data -------| #
                        - define gui_name npce_dialog
                        - define title "<&8><&l>Save New Prefix?"
                        - define input <player.flag[citizens_editor.recieved_input]>
                            # |------- open dialog -------| #
                        - inject citizens_editor_open_dialog
                        # |------- validate dialog -------| #
                        - define dialog <player.flag[citizens_editor.awaiting_dialog].if_null[false]>
                        - if ( <[dialog]> ):
                            # |------- clear dialog data -------| #
                            - flag <player> citizens_editor.awaiting_dialog:!
                            # |------- log changes -------| #
                            - narrate "<[prefix]> <&f>Prefix updated to <[input]>."
                            # |------- validate inventories -------| #
                            - inject citizens_editor_validate_guis
                    # |------- clear input data -------| #
                    - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                        - flag <player> citizens_editor.awaiting_input:!
                    - if ( <player.has_flag[citizens_editor.recieved_input]> ):
                        - flag <player> citizens_editor.recieved_input:!
                    # |------- open current inventory -------| #
                    - inventory open destination:<[current]>

        after player left clicks item_flagged:npce-gui-button in citizens_editor_interrupt_gui|npce_interrupt_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_interrupt_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_interrupt_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_interrupt_page]>
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

        after player left clicks item_flagged:npce-gui-button in citizens_editor_inventory_gui|npce_gui_page:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <script[citizens_editor_config].parsed_key[prefixes].get[main]>
            - define current <player.flag[citizens_editor.gui.current].if_null[npce_gui_page]>
            - define next <player.flag[citizens_editor.gui.next].if_null[npce_gui_page]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[npce_gui_page]>
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



# | ------------------------------------------------------------------------------------------------------------------------------ | #


