

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
	permission message: '<gray>[<aqua><bold>DevMode<gray>] <red>Entity: <white><player.name>, <red>is not authorized to use <white>developer mode<red>.'
	script:
		# |------- flags check -------| #
		- if ( not <player.has_flag[debug_npc]> ):
			- flag <player> debug_npc:false
		
		# |------- define arguments -------| #
		- define category <context.args.get[1]||null>
		- define action <context.args.get[2]||null>
		- define options <context.args.exclude[<[category]>|<[action]>]||null>
		
		# |------- define formats -------| #
		- define prefix '<gray>[<aqua><bold>DevMode<gray>]'
		- define cat_prefix '<gray>[<aqua><bold><[category].to_uppercase><gray>]'
		
		# |------- null check -------| #
		- if ( <[category]> == null && <[action]> == null ) && ( <[options].is_empty> || <[options]> == null ):
			- narrate '<[prefix]> <red>You must specify a valid <white>category <red>to enable developer mode. <gray>Example: /<white><context.alias><gray> {<white>category<gray>} {<white>action<gray>} {<white>option1<gray>}'
		
		# |------- run command -------| #
		- else:
			- choose <[category]>:
				- case npc npcs:
					- choose <[action]>:
						- case null:
							- if ( <player.flag[debug_npc]> ):
								- flag <player> debug_npc:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
							- else:
								- flag <player> debug_npc:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case true:
							- if ( <player.flag[debug_npc]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <green>enabled<white>.'
							- else:
								- flag <player> debug_npc:true
								- narrate '<[prefix]> <[cat_prefix]><white>: <green>Enabled<white>'
						- case false:
							- if ( not <player.flag[debug_npc]> ):
								- narrate '<[prefix]> <[cat_prefix]><white>: is already <red>disabled<white>.'
							- else:
								- flag <player> debug_npc:false
								- narrate '<[prefix]> <[cat_prefix]><white>: <red>Disabled<white>'
				- default:
					- narrate '<[prefix]> <red>Category: <white><[category]> <red>is not a valid category.'



# | ---------------------------------------------- CELESTICMC.NETWORK | TYPE.TASKS ---------------------------------------------- | #


test_task:
    type: task
    script:
		- if not <player.has_flag[debug_npc]>:
			- flag <player> debug_npc:true


# | ------------------------------------------------------------------------------------------------------------------------------ | #


