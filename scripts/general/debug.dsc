

# | ---------------------------------------------- DEBUG.MODE | TYPE.COMMANDS ---------------------------------------------- | #


developer_mode:
	# |------- set command properties -------| #
	type: command
	debug: false
	name: devmode
	usage: /devmode {category} {action} {option1} {option2} {...}
	aliases:
		- dev
		- developermode
		- hollow
		- hollowmode
	permission: script.command.developer_mode
	permission message: '<gray>[<aqua><bold>DevMode<gray>] <red>Entity: <white><player.name>, <red>is not authorized to use <white>developer mode<red>.'
	script:
		# |------- flags check -------| #
		- if ( not <player.has_flag[debug_flags]> ):
			- flag <player> debug_flags:false
		- if ( not <player.has_flag[debug_proximity]> ):
			- flag <player> debug_proximity:false
		- if ( not <player.has_flag[test]> ):
			- flag <player> test:none
		
		# |------- define arguments -------| #
		- define category <context.args.get[1]||null>
		- define action <context.args.get[2]||null>
		- define options <context.args.exclude[<[category]>|<[action]>]||null>
		
		# |------- define formats -------| #
		- define prefix '<gray>[<aqua><bold>DevMode<gray>]'
		- define cat_prefix '<gray>[<aqua><bold><[category]><gray>]'
		
		# |------- null check -------| #
		- if ( <[category]> == null && <[action]> == null ) && ( <[options].is_empty> || <[options]> == null ):
			- narrate '<[prefix]> <red>You must specify a valid <white>category <red>to enable developer mode. <gray>Example: /<white><context.alias><gray> {<white>category<gray>} {<white>action<gray>} {<white>option1<gray>}'
		
		# |------- run command -------| #
		- else:
			- choose <[category]>:
				- case flag flags flageditor flagseditor:
					- choose <[action]>:
						- case null:
							- if ( <player.flag[debug_flags]> ):
								- flag <player> debug_flags:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
							- else:
								- flag <player> debug_flags:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case true enable enabled:
							- if ( <player.flag[debug_flags]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <green>enabled<white>.'
							- else:
								- flag <player> debug_flags:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case false disable disabled:
							- if ( not <player.flag[debug_flags]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <red>disabled<white>.'
							- else:
								- flag <player> debug_flags:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
				- case prox proximity proximities:
					- choose <[action]>:
						- case null:
							- if ( <player.flag[debug_proximity]> ):
								- flag <player> debug_proximity:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
							- else:
								- flag <player> debug_proximity:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case true enable enabled:
							- if ( <player.flag[debug_proximity]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <green>enabled<white>.'
							- else:
								- flag <player> debug_proximity:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case false disable disabled:
							- if ( not <player.flag[debug_proximity]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <red>disabled<white>.'
							- else:
								- flag <player> debug_proximity:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
				- default:
					- narrate '<[prefix]> <red>Category: <white><[category]> <red>is not a valid category.'



# | ------------------------------------------------------------------------------------------------------------------------------ | #


flag_editor:
	############################################
	# |------- set command properties -------| #
	############################################
	type: command
	debug: true
	name: flag
	usage: /flag {entity} {context} {option1} {option2} {...}
	aliases:
		- flags
		- flagmode
		- flagsmode
		- flageditor
		- flagseditor
	permission: script.command.flag_editor
	permission message: '<gray>[<aqua><bold>DevMode<gray>] <red>Entity: <white><player.name>, <red>is not authorized to use <white>flag <red>commands.'
	script:
		######################################
		# |------- define arguments -------| #
		######################################
		- if ( li@player|players|npc|npcs contains <context.args.get[1]> ):
			- narrate "if is being run"
			- define entity <context.args.get[1]||null>
			- define context <context.args.get[2]||null>
			- define options <context.args.exclude[<[entity]>|<[context]>]||null>
		- else:
			- narrate "else is being run"
			- define entity player
			- define context <context.args.get[1]||null>
			- define options <context.args.exclude[<[context]>]||null>
		
		##################################
		# |------- define flags -------| #
		##################################
		- define player_flags <player.list_flags||null>
		- define npc_flags null
		
		####################################
		# |------- define formats -------| #
		####################################
		- define prefix '<gray>[<aqua><bold>DevMode<gray>]'
		
		################################
		# |------- null check -------| #
		################################
		- if ( <[entity]> == null && <[context]> == null ) && ( <[options].is_empty> || <[options]> == null ):
			- narrate '<[prefix]> <red>You must specify a valid <white>entity <red>to enable flag editor. <gray>Example: /<white><context.alias><gray> {<white>entity<gray>} {<white>action<gray>} {<white>option1<gray>}'
		- else:
			####################################
			# |------- define options -------| #
			####################################
			- define option_1 <[options].get[1]||null>
			- define option_2 <[options].get[2]||null>
			- define option_3 <[options].get[3]||null>
			- define flag null
			- define action null
			- define value null
			
			#################################
			# |------- run command -------| #
			#################################
			- if ( <player.flag[debug_flags]> ):
				######################################
				# |------- determine entity -------| #
				######################################
				- choose <[entity]>:
					- case player players:
						###################################
						# |------- player entity -------| #
						###################################
						- if ( <[context]> != null ):
							- if ( <[player_flags]> contains <[context]> ):
								############################################
								# |------- if initial arg is flag -------| #
								############################################
								- define flag <[context]>
								- if ( <[option_1]> != null ):
									- define action <[option_1]>
									- if ( <[option_2]> != null ):
										- define value <[option_2]>
								######################################
								# |------- determine action -------| #
								######################################
								- if ( <[flag]> != null ):
									- choose <[action]>:
										- default:
											####################################
											# |------- invalid action -------| #
											####################################
											- narrate '<[prefix]> <red>Action: <white><[action]><red> is not a valid flag operation.'
										- case null:
											#################################
											# |------- null action -------| #
											#################################
											- narrate '<[prefix]> <red>You must specify an <white>action <red>to perform on the <white><[flag]> <red>flag. <gray>Example: /<white><context.alias><gray> {<white>entity<gray>} {<white>flag<gray>} {<white>action<gray>}'
										- case view show display list:
											#################################
											# |------- view action -------| #
											#################################
											- if ( <player.has_flag[<[flag]>]> ):
												- if ( <player.flag[<[flag]>].size.if_null[1]> <= 1 ):
													- narrate '<[prefix]> <gray>[<aqua><bold><[flag]><gray>] <white><player.flag[<[flag]>]>.'
												- else if ( <player.flag[<[flag]>].size> > 1 ):
													- narrate '<[prefix]> <gray>[<aqua><bold><[flag]><gray>]'
													- foreach <player.flag[<[flag]>]> as:entry:
														- narrate '  - <aqua><[entry]>'
											- else:
												- narrate '<[prefix]> <white><player.name> <red>doesn''t have the <white><[flag]> <red>flag.'
										- case add:
											################################
											# |------- add action -------| #
											################################
											- if ( <player.has_flag[<[flag]>]> ):
												- if ( <[value]> != null ):
													- if ( not <player.flag[<[flag]>].contains[<[value]>]> ):
														- flag <player> <[flag]>:->:<[value]>
														- narrate '<[prefix]> <white>Added <aqua><[value]> <white>to the <aqua><[flag]> <white>flag.'
													- else:
														- narrate '<[prefix]> <red>Flag: <white><[flag]> <red>already contains the value: <white><[value]><red>.'
												- else:
													- narrate '<[prefix]> <red>You must specify a valid <white>value <red>to add to the <white><[flag]> <red>flag. <gray>Example: /<white><context.alias><gray> {<white>npc<gray>} {<white>ignored<gray>} {<white>remove<gray>} {<white>player_name<gray>}'
											- else:
												- narrate '<[prefix]> <white><player.name> <red>doesn''t have the <white><[flag]> <red>flag.'
										- case remove:
											###################################
											# |------- remove action -------| #
											###################################
											- if ( <player.has_flag[<[flag]>]> ):
												- if ( <[value]> != null ):
													- if ( <player.flag[<[flag]>].contains[<[value]>]> ):
														- flag <player> <[flag]>:<-:<[value]>
														- narrate '<[prefix]> <white>Removed <aqua><[value]> <white>from the <aqua><[flag]> <white>flag.'
													- else:
														- narrate '<[prefix]> <red> <white><[flag]> <red>doesn''t contain the value: <white><[value]><red>.'
												- else:
													- narrate '<[prefix]> <red>You must specify a valid <white>value <red>to remove from the <white><[flag]> <red>flag. <gray>Example: /<white><context.alias><gray> {<white>npc<gray>} {<white>ignored<gray>} {<white>remove<gray>} {<white>player_name<gray>}'
											- else:
												- narrate '<[prefix]> <white><player.name> <red>doesn''t have the <white><[flag]> <red>flag.'
										- case new create:
											################################
											# |------- new action -------| #
											################################
											- if ( <[value]> != null ):
												- if ( not <player.has_flag[<[value]>] ):
													- flag <player> <[flag]>:<[value]>
													- narrate '<[prefix]> <white>Tagged <aqua><player.name> <white>with the <aqua><[flag]> <white>flag.'
												- else:
													- narrate '<[prefix]> <white><player.name> <red>already has the <white><[flag]> <red>flag.'
											- else:
												- narrate '<[prefix]> <red>You must specify a valid <white>value <red>to add to the <white><[flag]> <red>flag. <gray>Example: /<white><context.alias><gray> {<white>player<gray>} {<white>new_flag<gray>} {<white>create<gray>} {<white>new_value<gray>}'
										- case delete:
											################################
											# |------- delete action -------| #
											################################
											- if ( <player.has_flag[<[flag]>]> ):
												- flag <player> <[flag]>:!
												- narrate '<[prefix]> <white>Permanently deleted <aqua><[flag]> <white>flag from the entity <aqua><player.name><white>.'
											- else:
												- narrate '<[prefix]> <white><player.name> <red>doesn''t have the <white><[flag]> <red>flag.'
								- else:
									#########################################
									# |------- invalid server flag -------| #
									#########################################
									- narrate '<[prefix]> <red>You must specify a valid <white>flag <red>to complete the action: <white>[action]><red>. <gray>Example: /<white><context.alias><gray> {<white>npc<gray>} {<white>ignored<gray>} {<white>remove<gray>} {<white>player_name<gray>}'
							- else:
								##############################################
								# |------- if initial arg is action -------| #
								##############################################
								- choose <[context]>:
									- case null:
										- narrate '<[prefix]> <red>You must specify a valid <white>action <red>to operate <white>flag <red>commands. <gray>Example: /<white><context.alias><gray> {<white>entity<gray>} {<white>action<gray>} {<white>flag<gray>}'
									- default:
										- narrate '<[prefix]> <red>This will occur when an action argument is defined before a flag argument'
						- else:
							#########################################
							# |------- invalid initial arg -------| #
							#########################################
							- narrate '<[prefix]> <red>You must specify either a valid <white>flag <red>or <white>action <red>for <[entity]> entity. <gray>Example: /<white><context.alias><gray> {<white>entity<gray>} {<white>action<gray>} {<white>flag<gray>}'
					
					- case npc npcs:
						################################
						# |------- npc entity -------| #
						################################
						- narrate 'none'
						
			- else if ( not <player.flag[debug_flags]> ):
				##########################################
				# |------- disabled feature -------| #
				##########################################
				- narrate '<[prefix]> <red>You must enable the <white>flag editor <red>to use this command.'
			- else:
				##########################################
				# |------- unauthorized request -------| #
				##########################################
				- narrate '<[prefix]>] <red>Entity: <white><player.name> <red>is not authorized to use <white>flag <red>commands.'



# | ---------------------------------------------- CELESTICMC.NETWORK | TYPE.TASKS ---------------------------------------------- | #


test_task:
    type: task
    script:
		- if not <player.has_flag[debug_npc]>:
			- flag <player> debug_npc:true



# | ------------------------------------------------------------------------------------------------------------------------------ | #


