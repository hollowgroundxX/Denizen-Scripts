


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
        confirm-dialog: <item[player_head].with_flag[npce-gui-button:confirm].with[display=<&a><&l>Confirm;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.confirm-button]||>]>
        deny-dialog: <item[player_head].with_flag[npce-gui-button:deny].with[display=<&c><&l>Deny;skull_skin=<server.flag[citizens_editor.settings.interface.settings.gui-skulls.deny-button]||<item[<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.material]>].with[display=<server.flag[citizens_editor.settings.interface.settings.gui-materials.invalid.title]>]>>]>
    slots:
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [deny-dialog] [red-fill] [edge-fill] [green-fill] [confirm-dialog] [green-fill] [edge-fill]
        - [edge-fill] [red-fill] [red-fill] [red-fill] [edge-fill] [green-fill] [green-fill] [green-fill] [edge-fill]
        - [corner-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [edge-fill] [corner-fill]



# | ----------------------------------------------  CITIZENS EDITOR | GUI EVENT HANDLER  ---------------------------------------------- | #



htools_dialog_manager:
    type: world
    debug: true
    events:
        #################################################
        # | ---  |       presence events       |  --- | #
        #################################################
        on player flagged:citizens_editor.awaiting_dialog|citizens_editor.awaiting_input quits:
            - ratelimit <player> 1t
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - inject <script.name> path:cancel_dialog

        ##################################################
        # | ---  |       inventory events       |  --- | #
        ##################################################
        on player flagged:citizens_editor.awaiting_dialog closes citizens_editor_dialog_gui:
            - ratelimit <player> 1t
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - inject <script.name> path:cancel_dialog

        after player left clicks item_flagged:npce-gui-button in citizens_editor_dialog_gui:
            - ratelimit <player> 1t
            # |------- event data -------| #
            - define prefix <server.flag[citizens_editor.settings.prefixes.main].parse_color>
            - define button-id <context.item.flag[npce-gui-button]>
            # |------- remove flag -------| #
            - flag <player> awaiting_dialog:!
            # |------- context check -------| #
            - choose <[button-id]>:
                # |--------------------------------| #
                # | ---  confirm dialog event  --- | #
                # |--------------------------------| #
                - case confirm:
                    - flag <player> citizens_editor.received_dialog:true
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.confirm-dialog]> pitch:1
                # |-----------------------------| #
                # | ---  deny dialog event  --- | #
                # |-----------------------------| #
                - case deny:
                    - flag <player> citizens_editor.received_dialog:false

        #################################################
        # | ---  |         chat events         |  --- | #
        #################################################
        on player flagged:citizens_editor.awaiting_input chats:
            - determine passively cancelled
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                - flag <player> citizens_editor.received_input:<context.message>
                - flag <player> citizens_editor.awaiting_input:!



# | ------------------------------------------------------------------------------------------------------------------------------ | #


    open_dialog:
        ########################################################
        # | ---  |              gui task              |  --- | #
        ########################################################
        # | ---                                          --- | #
        # | ---  Required:  prefix | gui_title | gui-id  --- | #
        # | ---                                          --- | #
        ########################################################
        - ratelimit <player> 1t
        # |------- inventory data -------| #
        - if ( <[gui-id].exists> ):
            - define cached-gui <[gui-id]>
        - define gui-id dialog-gui
        - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
        - define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
        # |------- flag check -------| #
        - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
            - flag <player> citizens_editor.awaiting_dialog:!
        - if ( <player.has_flag[citizens_editor.received_dialog]> ):
            - flag <player> citizens_editor.received_dialog:!
        # |------- set flag -------| #
        - flag <player> citizens_editor.awaiting_dialog:true
        # |------- inventory check -------| #
        - if ( <[flagged]> ) && ( <[noted]> ):
            # |------- adjust inventory -------| #
            - adjust <inventory[<[gui-id]>]> title:<[gui_title]>
            # |------- open dialog inventory -------| #
            - inject htools_uix_manager path:open
            - waituntil <player.has_flag[citizens_editor.received_dialog]> rate:5t max:60s
        - else:
            # |------- validate inventory -------| #
            - inject htools_uix_manager path:validate_inventory
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
            - define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
            - if ( <[flagged]> ) && ( <[noted]> ):
                # |------- adjust inventory -------| #
                - adjust <inventory[<[gui-id]>]> title:<[gui_title]>
                # |------- open dialog -------| #
                - inject htools_uix_manager path:open
                - waituntil <player.has_flag[citizens_editor.received_dialog]> rate:5t max:60s
        # |------- reset flag -------| #
        - flag <player> citizens_editor.awaiting_dialog:!
        # |------- reset gui-id -------| #
        - if ( <[cached-gui].exists> ):
            - define gui-id <[cached-gui]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open_input_dialog:
        ##############################################################################################
        # | ---  |                                 gui task                                 |  --- | #
        ##############################################################################################
        # | ---                                                                                --- | #
        # | ---  Required:  app | prefix | title | sub_title | bossbar | gui_title | keywords  --- | #
        # | ---                                                                                --- | #
        ##############################################################################################
        - ratelimit <player> 1t
        # |------- interrupt discordSRV -------| #
        - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
        - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
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
            # |------- close inventory -------| #
            - inventory close
            # |------- check flags -------| #
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                - flag <player> citizens_editor.awaiting_input:!
            - if ( <player.has_flag[citizens_editor.received_input]> ):
                - flag <player> citizens_editor.received_input:!
            # |------- set flags -------| #
            - flag <player> citizens_editor.awaiting_input:true
            # |------- display instructions -------| #
            - title title:<[title]> subtitle:<[sub_title]> stay:<[count]>s fade_in:1s fade_out:1s targets:<player>
            - bossbar create id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
            # |------- awaiting input -------| #
            - while ( true ):
                # |------- input data -------| #
                - define awaiting <player.flag[citizens_editor.awaiting_input].if_null[false]>
                # |------- display countdown -------| #
                - if ( <[ticks]> == 20 ):
                    - bossbar update id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&a><&l><[count]><&sp><&f><&l>seconds progress:0 color:red
                    - define count:--
                    - define ticks 0
                # |------- input check -------| #
                - if ( <[awaiting]> ) && ( <[loop_index]> <= <[timeout].mul_int[4]> ):
                    - wait 5t
                    - define ticks:+:5
                    - while next
                - else:
                    # |------- check input -------| #
                    - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                        - wait 1s
                        - bossbar update id:npce_awaiting_input title:<&b><&l><[bossbar]><&sp><&b><&l>-<&sp><&f><[count]><&sp><&f><&l>seconds progress:0 color:red
                        - flag <player> citizens_editor.awaiting_input:!
                        - wait 1s
                    # |------- cleanup bossbar -------| #
                    - bossbar remove id:npce_awaiting_input
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
            - if ( <player.has_flag[citizens_editor.received_input]> ):
                - define input <player.flag[citizens_editor.received_input]>
                - if ( not <[keywords].contains[<[input]>]> ):
                    # |------- open dialog -------| #
                    - inject <script.name> path:open_dialog
                - else:
                    # |------- clear input data -------| #
                    - flag <player> citizens_editor.received_input:!
                    # |------- open previous inventory -------| #
                    - define gui-id <player.flag[citizens_editor.gui.current]>
                    - inject <script.name> path:open
                    - stop
        - else:
            # |------- invalid timeout -------| #
            - narrate "<[prefix]> <&c>Dialog Cancelled: The setting '<&f>await-input-timeout<&c>' <&c>is not a valid <&f>integer<&c>."



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    cancel_dialog:
        ########################################################
        # | ---  |              gui task              |  --- | #
        ########################################################
        # | ---                                          --- | #
        # | ---  Required:  prefix                       --- | #
        # | ---                                          --- | #
        ########################################################
        - ratelimit <player> 1t
        # |------- event data -------| #
        # - define scripts <script[citizens_editor_application].data_key[data].get[cancel-dialog-script-ids]>
        - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
        - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
        # |------- flag check -------| #
        - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
            # |------- cancel dialog -------| #
            - flag <player> citizens_editor.awaiting_dialog:!
            - flag <player> citizens_editor.received_dialog:!
        - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
            # |------- cancel input -------| #
            - flag <player> citizens_editor.awaiting_input:!
            - flag <player> citizens_editor.received_input:!
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
            - bossbar remove id:npce_awaiting_input
        # |------- cancel queues -------| #
        - foreach <util.queues.exclude[<script>]> as:queue:
            - if ( <[queue].script> != <script> ) && ( <[queue].script.contains_text[citizens_editor]> ):
                - if ( <[queue].is_valid> ) && ( <[queue].player> == <player> ):
                    - queue <[queue]> clear
                    - if ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
                        - narrate "<[prefix]> <&f>Queue <&b><[queue].script.name> <&c>cancelled <&f>successfully."
                        - announce to_console "<[prefix]> '<player.name>.queue.<[queue].script.name>' successfully cancelled."
            - else if ( <[queue].script> == <script> ) && ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
                - narrate "<[prefix]> <&f>Queue <&b><script.name> <&c>cancelled <&f>successfully."
        - stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #


