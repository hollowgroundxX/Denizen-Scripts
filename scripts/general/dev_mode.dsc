


# | ---------------------------------------------- DEVELOPER MODE | DATA --------------------------------------------- | #


developer_mode_data:
    type: data
	prefix: DevMode
	categories:
		- flag
		- flags
		- prox
		- proximity
	
	
	
# | ---------------------------------------------- DEVELOPER MODE | COMMANDS ---------------------------------------------- | #


developer_mode:
	########################################
	# |------- command properties -------| #
	########################################
	type: command
	debug: true
	name: developer
	usage: /devmode {category} {action} {option1} {option2} {...}
	aliases:
		- dev
		- devmode
		- developermode
		- hollow
	permission: script.command.developer_mode
	permission message: '<&7>[<&b><&l>DevMode<&7>] <&c>Entity: <&f><player.name> <&c>is not authorized to use <&f>developer mode<&c>.'
	tab completions:
        1: flag|proximity
        2: enable|disable|true|false
        default: StopTyping
	script:	
		######################################
		# |------- define arguments -------| #
		######################################
		- define category <context.args.get[1]||null>
		- define action <context.args.get[2]||null>
		- define options <context.args.exclude[<[category]>|<[action]>]||null>
		
		#################################
		# |------- define data -------| #
		#################################
		- define prefix '<&7>[<&d><&l><script[developer_mode_data].data_key[prefix]><&7>]'
		- define categories <script[developer_mode_data].data_key[categories]>
		
		################################
		# |------- null check -------| #
		################################
		- if ( <[category]> == null && <[action]> == null ) && ( <[options].is_empty> || <[options]> == null ):
			- narrate '<[prefix]> <&c>You must specify a valid <&f>category <&c>to enable developer mode. <&7>Example: /<&7><context.alias><gray> {<&f>category<&7>} {<&f>action<&7>} {<&f>options...<&7>}'
		
		- else:
			########################################
			# |------- determine category -------| #
			########################################
			- if ( <[categories]> contains <[category]> ):
				- choose <[category]>:
					- case flag flags:
						- if ( not <player.has_flag[flag_editor]> ) && ( not <player.flag[public_flags].contains[flag_editor]> ):
							- flag <player> flag_editor:false
							- flag <player> public_flags:->:flag_editor
						- define flag flag_editor
						- define cat_prefix '<&7>[<&b>FlagEditor<&7>]'
					- case prox proximity:
						- if ( not <player.has_flag[flag_proximity]> ) && ( not <player.flag[public_flags].contains[flag_proximity]> ):
							- flag <player> flag_proximity:false
							- flag <player> public_flags:->:flag_proximity
						- define flag flag_proximity
						- define cat_prefix '<&7>[<&b>Proximity<&7>]'
			- else:
				 - narrate '<[prefix]> <&f><[category]> <&c>is not valid category.'
			
			######################################
			# |------- determine action -------| #
			######################################
			- choose <[action]>:
				- case null:
					- if ( <player.flag[<[flag]>]> ):
						- flag <player> <[flag]>:false
						- narrate '<[prefix]> <[cat_prefix]><&f>: <&c>Disabled<&f>'
					- else:
						- flag <player> <[flag]>:true
						- narrate '<[prefix]> <[cat_prefix]><&f>: <&a>Enabled<&f>'
						
				- case true enable enabled:
					- if ( <player.flag[<[flag]>]> ):
						- narrate '<[prefix]> <[cat_prefix]><&f>: is already <&a>enabled<&f>.'
					- else:
						- flag <player> <[flag]>:true
						- narrate '<[prefix]> <[cat_prefix]><&f>: <&a>Enabled<&f>'
						
				- case false disable disabled:
					- if ( not <player.flag[<[flag]>]> ):
						- narrate '<[prefix]> <[cat_prefix]><&f>: is already <&c>disabled<&f>.'
					- else:
						- flag <player> <[flag]>:false
						- narrate '<[prefix]> <[cat_prefix]><&f>: <&c>Disabled<&f>'



# | ------------------------------------------------------------------------------------------------------------------------------ | #

