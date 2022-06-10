


# | ---------------------------------------------- CITIZENS EDITOR | CORE HANDLERS ---------------------------------------------- | #



citizens_editor_core_handlers:
    ###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: false
    events:
		#####################################
		# |------- presence events -------| #
		#####################################
        after server start server_flagged:npce_inventories:
            - foreach <server.notes[inventories]> as:note:
                - flag server npce_inventories:<-:<[note].note_name>
                - note remove as:<[note].note_name>

        after player flagged:npce_fishing_select_mode join:
            - flag <player> npce_fishing_select_mode:!


# | ------------------------------------------------------------------------------------------------------------------------------ | #


