


# | ---------------------------------------------- CITIZENS EDITOR | CORE HANDLERS ---------------------------------------------- | #



citizens_editor_core_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: true
    events:
		#####################################
		# |------- presence events -------| #
		#####################################
        after server start server_flagged:citizens_editor.inventories:
            # |------- clear noted | flagged inventories -------| #
            - foreach <server.notes[inventories]> as:note:
                - flag server citizens_editor.inventories:<-:<[note].note_name>
                - note remove as:<[note].note_name>

        after player join:
            # |------- flag check -------| #
            - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
                - flag <player> citizens_editor.awaiting_dialog:!
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ):
                - flag <player> citizens_editor.awaiting_input:!
            - if ( <player.has_flag[citizens_editor.received_input]> ):
                - flag <player> citizens_editor.received_input:!
            - if ( <player.has_flag[citizens_editor.selection_mode]> ):
                - flag <player> citizens_editor.selection_mode:!

        after player quit:
            # |------- event data -------| #
            - define scripts <list[]>
            # |------- flag check -------| #
            - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
                # |------- cancel dialog -------| #
                - flag <player> citizens_editor.awaiting_dialog:!
                - define scripts:->:citizens_editor_dialog_handlers
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ) || ( <player.has_flag[citizens_editor.received_input]> ):
                # |------- cancel input -------| #
                - flag <player> citizens_editor.awaiting_input:!
                - flag <player> citizens_editor.received_input:!
                # |------- resume discordSRV -------| #
                - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
                - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
                - if ( <[discordSRV]> ):
                    - choose <[perms_handler]>:
                        - case default:
                            - bossbar remove id:npce_awaiting_input
                            - stop
                        - case UltraPermissions:
                            - execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
                        - case LuckPerms:
                            - narrate placeholder
                        - case Essentials:
                            - narrate placeholder
                # |------- cleanup instructions -------| #
                - bossbar remove id:npce_awaiting_input
                - define scripts:->:citizens_editor_settings_handlers
            # |------- check scripts -------| #
            - if ( not <[scripts].is_empty> ):
                # |------- cancel queue -------| #
                - foreach <[scripts]> as:script:
                    - foreach <script[<[script]>].queues> as:queue:
                        - if ( <[queue].is_valid> ) && ( <[queue].player> == <player> ):
                            - queue <[queue]> clear
                        - announce to_console "'<[queue]>' successfully cancelled."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


