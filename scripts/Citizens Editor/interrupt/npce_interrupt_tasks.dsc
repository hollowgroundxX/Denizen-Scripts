


# | ---------------------------------------------- CITIZENS EDITOR | TASKS ---------------------------------------------- | #



npc_interrupt_dependency_check:
	#################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	script:
		# |------- define data -------| #
		- define scripts <script[citizens_editor_config].data_key[interrupt.scripts]||null>
		- define loaded <list[]>

		# |------- script check -------| #
		- if not ( <[scripts].equals[null]> ):
			- foreach <[scripts]> as:script:
				- if ( <[script].equals[<empty>]> ) || ( <[script].equals[null]> ) || ( not <script[<[script]>].exists> ):
					- foreach next
				- else:
					- define script_path <script[<[script]>].relative_filename>
					- if ( <server.has_file[<[script_path]>].if_null[false]> ):
						- define loaded:->:<[script]>

		# |------- set external flags -------| #
		- if not ( <[loaded].is_empty> ):
			- foreach <[loaded]> as:script:
				- choose <[script]>:
					- case compatible_script_id:
						#################################################################################
						# |-------  You can set custom configured script flag conditions here. -------| #
						# |-------                                                             -------| #
						# |-------  The case needs to match the script id and the id must be   -------| #
						# |-------  listed under the scripts section in the interrupt config.  -------| #
						#################################################################################
						- narrate "your external script conditions here..."
		


# | ------------------------------------------------------------------------------------------------------------------------------ | #


