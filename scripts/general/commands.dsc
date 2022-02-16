

# | ---------------------------------------------- CELESTICMC.NETWORK | TYPE.COMMANDS ---------------------------------------------- | #


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
	permission message: '<red>Entity: <white><player.name>, <red>is not authorized to use <white>developer mode<red>.'
	script:
		# |------- define arguments -------| #
		- define category <context.args.get[1]||null>
		- define action <context.args.get[2]||null>
		- define options <context.args.exclude[<[category]>|<[action]>]||null>
		
		# |------- flags check -------| #
		- if ( not <player.has_flag[debug_npc]> ):
			- flag <player> debug_npc:false
		
		# |------- null check -------| #
		- if ( <[category]> == null && <[action]> == null ) && ( <[options].is_empty> || <[options]> == null ):
			- narrate '<red>You must specify a valid <white>category <red>to enable developer mode.'
			- narrate '<gray>Example: /<white><context.alias><gray> {<white>category<gray>} {<white>action<gray>} {<white>option1<gray>}'
		
		# |------- arguments check -------| #
		- else:
			- choose <[category]>:
				- case npc npcs:
					- choose <[action]>:
						- case null:
							- if ( <player.flag[debug_npc]> == 'true' ):
								- flag <player> debug_npc:false
								- narrate '<white>DevMode.NPC toggled <red>off<white>.'
							- else:
								- flag <player> debug_npc:true
								- narrate '<white>DevMode.NPC toggled <green>on<white>.'
						- case true:
							- if <player.flag[debug_npc]> == 'true':
								- narrate '<white>DevMode.NPC is already <green>enabled<white>.'
							- else:
								- flag <player> debug_npc:true
								- narrate '<white>DevMode.NPC: <green>Enabled<white>.'
						- case false:
							- if <player.flag[debug_npc]> == 'false':
								- narrate '<white>DevMode.NPC is already <red>disabled<white>.'
							- else:
								- flag <player> debug_npc:false
								- narrate '<white>DevMode.NPC: <red>Disabled<white>.'
				- default:
					- narrate '<red>Category: <white><[category]> <red>is not a valid category.'



# | ---------------------------------------------- CELESTICMC.NETWORK | TYPE.TASKS ---------------------------------------------- | #


test_task:
    type: task
    script:
		- if not <player.has_flag[debug_npc]>:
			- flag <player> debug_npc:true


# | ------------------------------------------------------------------------------------------------------------------------------ | #


