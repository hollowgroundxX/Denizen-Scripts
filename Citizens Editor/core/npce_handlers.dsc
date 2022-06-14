


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
            - if ( <player.has_flag[citizens_editor.selection_mode]> ):
                - flag <player> citizens_editor.selection_mode:!
            - if ( <player.has_flag[citizens_editor.gui.current]> ):
                - flag <player> citizens_editor.gui.current:!
            - if ( <player.has_flag[citizens_editor.gui.next]> ):
                - flag <player> citizens_editor.gui.next:!
            - if ( <player.has_flag[citizens_editor.gui.previous]> ):
                - flag <player> citizens_editor.gui.previous:!

        after player quit:
            # |------- event data -------| #
            - define cancel false
            # |------- flag check -------| #
            - if ( <player.has_flag[citizens_editor.awaiting_dialog]> ):
                # |------- cancel dialog -------| #
                - flag <player> citizens_editor.awaiting_dialog:!
                - define cancel true
            - if ( <player.has_flag[citizens_editor.awaiting_input]> ) || ( <player.has_flag[citizens_editor.recieved_input]> ):
                # |------- cancel input -------| #
                - flag <player> citizens_editor.awaiting_input:!
                - flag <player> citizens_editor.recieved_input:!
                # |------- resume discordSRV -------| #
                - define discordSRV <server.plugins.contains[<plugin[DiscordSRV]>]>
                - define perms_handler <server.flag[citizens_editor.permissions_handler].if_null[null]>
                - if ( <[discordSRV]> ):
                    - choose <[perms_handler]>:
                        - case UltraPermissions:
                            - execute as_server "upc RemovePlayerPermission <player.name> discordsrv.player" silent
                        - case LuckPerms:
                            - narrate placeholder
                        - case Essentials:
                            - narrate placeholder
                # |------- cleanup instructions -------| #
                - bossbar remove id:npce_awaiting_input
                - define cancel true
            # |------- queue check -------| #
            - if ( <[cancel]> ):
                # |------- cancel queue -------| #
                - define scripts <list[citizens_editor_settings_handlers]>
                - foreach <[scripts]> as:script:
                    - foreach <script[<[script]>].queues> as:queue:
                        - if ( <[queue].player> == <player> ):
                            - queue <[queue]> clear
                        - announce to_console "'<[queue]>' successfully cancelled."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


