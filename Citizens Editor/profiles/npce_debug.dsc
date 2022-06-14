


# | ---------------------------------------------- CITIZENS EDITOR | DEBUG COMMANDS ---------------------------------------------- | #



debug_delete_npce_inventories:
	type: command
	debug: false
	name: deletenpcinventories
	description: Test command.
	usage: /deletenpcinventories
	script:
		- foreach <server.notes[inventories]> as:note:
			- narrate "<[note].note_name> removed."
			- flag server citizens_editor.inventories:<-:<[note].note_name>
			- note remove as:<[note].note_name>
		- narrate <server.notes>
		- narrate <server.flag[citizens_editor.inventories].if_null[null]>



debug_list_npce_inventories:
	type: command
	debug: false
	name: listnpcinventories
	description: Test command.
	usage: /listnpcinventories
	script:
		- narrate <server.notes>
		- narrate <server.flag[citizens_editor.inventories].if_null[null]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #


