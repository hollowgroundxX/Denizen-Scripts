


# | ---------------------------------------------- CITIZENS EDITOR | GUI HANDLERS ---------------------------------------------- | #



citizens_editor_gui_handlers:
    type: world
    debug: false
    events:
		##################################
		# |------- click events -------| #
		##################################
        after player left clicks item_flagged:npce-gui-button in citizens_editor_profiles_gui|npce_gui_menu:
            - if <context.item.flag[npce-gui-button].equals[profiles-page]>:
                - inventory open destination:citizens_editor_profiles_gui

		#################################
		# |------- null events -------| #
		#################################



# | ------------------------------------------------------------------------------------------------------------------------------ | #


