


# | ----------------------------------------------  CITIZENS EDITOR | APPLICATION HANDLER  ---------------------------------------------- | #



citizens_editor_application_handler:
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
                - note <inventory[<[note].note_name>]> as:<[note].note_name>
                - flag server citizens_editor.inventories:->:<[note].note_name>

        after player quit:
            # |------- event data -------| #
            - define scripts <custom_object[citizens_editor_application].get_queues>
            - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
            - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
            # |------- flag check -------| #
            - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ) || ( <player.has_flag[citizens_editor.received_dialog]> ):
                # |------- cancel dialog -------| #
                - flag <player> citizens_editor.awaiting_dialog:!
                - flag <player> citizens_editor.received_dialog:!
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ) || ( <player.has_flag[citizens_editor.received_input]> ):
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
            # |------- check scripts -------| #
            - if ( not <[scripts].is_empty> ):
                # |------- cancel queue -------| #
                - foreach <[scripts]> as:script:
                    - foreach <script[<[script]>].queues> as:queue:
                        - if ( <[queue].is_valid> ) && ( <[queue].player> == <player> ):
                            - queue <[queue]> clear
                        - announce to_console "'<[queue]>' successfully cancelled."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


