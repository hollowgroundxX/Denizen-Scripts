


# | ----------------------------------------------  CITIZENS EDITOR | DIALOG INVENTORY  ---------------------------------------------- | #



citizens_editor_dialog_gui:
    ##################################################
    # | ---  |       inventory script       |  --- | #
    ##################################################
    type: inventory
    debug: true
    inventory: CHEST
    title: Dialog Title Placeholder
    gui: true
    definitions:
        test: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>
        corner-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[corner-fill]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-fill: <item[<server.flag[citizens_editor.settings.interface.settings.gui-materials].get[edge-fill]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
        green-fill: <item[green_stained_glass_pane].with[display=<&d> <empty>]>
        red-fill: <item[red_stained_glass_pane].with[display=<&d> <empty>]>
        confirm-dialog: <item[player_head].with_flag[gui-button:confirm].with[display=<&a><&l>Confirm;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.confirm-button]||>]>
        deny-dialog: <item[player_head].with_flag[gui-button:deny].with[display=<&c><&l>Deny;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.deny-button]||<item[<server.flag[gui_handler.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [deny-dialog] [red-fill] [edge-fill] [green-fill] [confirm-dialog] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]



# | ----------------------------------------------  HTOOLS | GUI EVENT HANDLER  ---------------------------------------------- | #



citizens_editor_dialog_gui_handler:
    type: world
    debug: true
    events:
        #################################################
        # | ---  |       presence events       |  --- | #
        #################################################
        on player flagged:gui_handler.awaiting_dialog|gui_handler.awaiting_input quits:
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - inject <script.name> path:cancel_dialog

        ##################################################
        # | ---  |       inventory events       |  --- | #
        ##################################################
        on player flagged:gui_handler.awaiting_dialog closes citizens_editor_dialog_gui:
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - inject <script.name> path:cancel_dialog

        after player left clicks item_flagged:gui-button in citizens_editor_dialog_gui:
            # |------- event data -------| #
            - define button-id <context.item.flag[gui-button]>
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  confirm dialog event  --- | #
                # |--------------------------------| #
                - case confirm:
                    - flag <player> gui_handler.received_dialog:true
                # |-----------------------------| #
                # | ---  deny dialog event  --- | #
                # |-----------------------------| #
                - case deny:
                    - flag <player> gui_handler.received_dialog:false

        #################################################
        # | ---  |         chat events         |  --- | #
        #################################################
        on player flagged:gui_handler.awaiting_input chats:
            - determine passively cancelled
            - if ( <player.has_flag[gui_handler.awaiting_input]> ):
                - flag <player> gui_handler.received_input:<context.message>
                - flag <player> gui_handler.awaiting_input:!



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open:
        dialog:
            ####################################################
            # | ---  |          manager task          |  --- | #
            ####################################################
            # | ---                                      --- | #
            # | ---  Required:  script-id | gui_title    --- | #
            # | ---                                      --- | #
            # | ---  Optional:  prefix                   --- | #
            # | ---                                      --- | #
            ####################################################
            # |------- inventory data -------| #
            - define gui-id dialog-gui
            - if not ( <[prefix].exists> ):
                - define prefix <script[gui_handler_config].data_key[prefixes.main].parse_color>
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
            - define flagged <server.flag[gui_handler.<[script-id]>.inventories].contains[<[gui-id]>]>
            # |------- reset flags -------| #
            - flag <player> gui_handler.awaiting_dialog:!
            - flag <player> gui_handler.received_dialog:!
            # |------- set flag -------| #
            - flag <player> gui_handler.awaiting_dialog:true
            # |------- inventory check -------| #
            - if ( <[flagged]> ) && ( <[noted]> ):
                # |------- adjust inventory -------| #
                - adjust <inventory[<[gui-id]>]> title:<[gui_title]>
                # |------- open dialog inventory -------| #
                - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]> save:open_gui
                - if ( <entry[open_gui].created_queue.determination.get[1]> ):
                    - waituntil <player.has_flag[gui_handler.received_dialog]> rate:5t max:60s
                    # |------- validate dialog -------| #
                    - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                        # |------- reset flags -------| #
                        - flag <player> gui_handler.awaiting_dialog:!
                        - flag <player> gui_handler.received_dialog:!
                        # |------- return true -------| #
                        - determine true
                    - else:
                        # |------- reset flags -------| #
                        - flag <player> gui_handler.awaiting_dialog:!
                        - flag <player> gui_handler.received_dialog:!
                        # |------- return false -------| #
                        - determine false
            - else:
                # |------- validate inventory -------| #
                - run gui_handler path:validate.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]> save:validatation
                - if ( <entry[validatation].created_queue.determination.get[1]> ):
                    - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
                    - define flagged <server.flag[gui_handler.<[script-id]>.inventories].contains[<[gui-id]>]>
                    - if ( <[flagged]> ) && ( <[noted]> ):
                        # |------- adjust inventory -------| #
                        - adjust <inventory[<[gui-id]>]> title:<[gui_title]>
                        # |------- open dialog -------| #
                        - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> save:open_gui
                        - if ( <entry[open_gui].created_queue.determination.get[1]> ):
                            - waituntil <player.has_flag[gui_handler.received_dialog]> rate:5t max:60s
                            # |------- validate dialog -------| #
                            - if ( <player.flag[citizens_editor.received_dialog].if_null[false]> ):
                                # |------- reset flags -------| #
                                - flag <player> gui_handler.awaiting_dialog:!
                                - flag <player> gui_handler.received_dialog:!
                                # |------- return true -------| #
                                - determine true
                            - else:
                                # |------- reset flags -------| #
                                - flag <player> gui_handler.awaiting_dialog:!
                                - flag <player> gui_handler.received_dialog:!
                                # |------- return false -------| #
                                - determine false
            # |------- return false -------| #
            - determine false
        input:
            ############################################################################################
            # | ---  |                                gui task                                |  --- | #
            ############################################################################################
            # | ---                                                                              --- | #
            # | ---  Required:  script-id | title | sub_title | bossbar | gui_title | keywords   --- | #
            # | ---                                                                              --- | #
            # | ---  Optional:  prefix                                                           --- | #
            # | ---                                                                              --- | #
            ############################################################################################
            # |------- interrupt discordSRV -------| #
            - if not ( <[prefix].exists> ):
                - define prefix <script[gui_handler_config].data_key[prefixes.main].parse_color>
            - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
            - define perms_handler <server.flag[gui_handler.permissions_handler].if_null[null]>
            - if ( <[discordSRV]> ):
                - choose <[perms_handler]>:
                    - case UltraPermissions:
                        - execute as_server "upc AddPlayerPermission <player.name> -discordsrv.player" silent
                    - case LuckPerms:
                        - narrate placeholder
                    - case Essentials:
                        - narrate placeholder
            # |------- dialog data -------| #
            - define timeout <server.flag[citizens_editor.settings.editor.dialog-event.await-dialog-timeout]||60>
            - if ( <[timeout].is_integer> ):
                - define count <[timeout]>
                - define ticks 0
                # |------- close gui -------| #
                - inventory close
                # |------- reset flags -------| #
                - flag <player> gui_handler.awaiting_input:!
                - flag <player> gui_handler.received_input:!
                # |------- set flags -------| #
                - flag <player> gui_handler.awaiting_input:true
                # |------- display instructions -------| #
                - title title:<[title]> subtitle:<[sub_title]> stay:<[count]>s fade_in:1s fade_out:1s targets:<player>
                - bossbar create id:awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
                # |------- awaiting input -------| #
                - while ( true ):
                    # |------- input data -------| #
                    - define awaiting <player.flag[gui_handler.awaiting_input].if_null[false]>
                    # |------- display countdown -------| #
                    - if ( <[ticks]> == 20 ):
                        - bossbar update id:awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
                        - define count:--
                        - define ticks 0
                    # |------- input check -------| #
                    - if ( <[awaiting]> ) && ( <[loop_index]> <= <[timeout].mul_int[4]> ):
                        - wait 5t
                        - define ticks:+:5
                        - while next
                    - else:
                        # |------- check input -------| #
                        - if ( <player.has_flag[gui_handler.awaiting_input]> ):
                            - wait 1s
                            - bossbar update id:awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
                            - flag <player> gui_handler.awaiting_input:!
                            - wait 1s
                        # |------- cleanup bossbar -------| #
                        - bossbar remove id:awaiting_input
                        - execute as_server "title <player.name> clear" silent
                        # |------- resume discordSRV -------| #
                        - if ( <[discordSRV]> ):
                            - choose <[perms_handler]>:
                                - case UltraPermissions:
                                    - execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
                                - case LuckPerms:
                                    - narrate placeholder
                                - case Essentials:
                                    - narrate placeholder
                        - while stop
                # |------- validate input -------| #
                - if ( <player.has_flag[gui_handler.received_input]> ):
                    # |------- input data -------| #
                    - define input <player.flag[gui_handler.received_input]>
                    # |------- clear data -------| #
                    - flag <player> gui_handler.received_input:!
                    # |------- cancelled check -------| #
                    - if ( not <[keywords].contains[<[input]>]> ):
                        # |------- open dialog -------| #
                        - run <script.name> path:open.dialog def.script-id:<[script-id]> def.gui_title:<[gui_title]> save:open_dialog
                        - if ( <entry[open_dialog].created_queue.determination.get[1]> ):
                            - determine input
                    # |------- open previous inventory -------| #
                    - define gui-id <player.flag[gui_handler.current]>
                    - run gui_handler path:open.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]>
                    - determine false
            - else:
                # |------- invalid timeout -------| #
                - narrate "<[prefix]> <&c>Dialog Cancelled: The setting '<&f>await-input-timeout<&c>' <&c>is not a valid <&f>integer<&c>."
                - determine false



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    cancel_dialog:
        ######################################
        # | ---  |     gui task     |  --- | #
        ######################################
        # | ---                        --- | #
        # | ---  Optional:  prefix     --- | #
        # | ---                        --- | #
        ######################################
        # |------- event data -------| #
        - if not ( <[prefix].exists> ):
            - define prefix <script[gui_handler_config].data_key[prefixes.main].parse_color>
        - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
        - define perms_handler <server.flag[gui_handler.permissions_handler].if_null[null]>
        # |------- flag check -------| #
        - if ( <player.has_flag[gui_handler.awaiting_dialog]> ):
            # |------- cancel dialog -------| #
            - flag <player> gui_handler.awaiting_dialog:!
            - flag <player> gui_handler.received_dialog:!
        - if ( <player.has_flag[gui_handler.awaiting_input]> ):
            # |------- cancel input -------| #
            - flag <player> gui_handler.awaiting_input:!
            - flag <player> gui_handler.received_input:!
            # |------- resume discordSRV -------| #
            - if ( <[discordSRV]> ):
                - choose <[perms_handler]>:
                    - case default:
                        - determine cancelled passively
                    - case UltraPermissions:
                        - execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
                    - case LuckPerms:
                        - narrate placeholder
                    - case Essentials:
                        - narrate placeholder
            # |------- cleanup instructions -------| #
            - bossbar remove id:awaiting_input
        # |------- cancel queues -------| #
        - foreach <util.queues.exclude[<script>]> as:queue:
            - if ( <[queue].script> != <script> ) && ( <[queue].script.contains_text[gui_handler]> ):
                - if ( <[queue].is_valid> ) && ( <[queue].player> == <player> ):
                    - queue <[queue]> clear
                    - if ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
                        - narrate "<[prefix]> <&f>Queue <&b><[queue].script.name> <&c>cancelled <&f>successfully."
                        - announce to_console "<[prefix]> '<player.name>.queue.<[queue].script.name>' successfully cancelled."
            - else if ( <[queue].script> == <script> ) && ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
                - narrate "<[prefix]> <&f>Queue <&b><script.name> <&c>cancelled <&f>successfully."
        - stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #


