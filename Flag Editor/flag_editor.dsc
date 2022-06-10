# + ------------------------------------------------------------------------------------------------------------------ +
# |
# |  Flag Editor by Htools
# |
# |  Simple command to edit various entity flags and values. (additonal entity support coming soon!)
# |
# + ------------------------------------------------------------------------------------------------------------------ +
#
#
# @author HollowTheSilver
# @date 2022/02/28
# @denizen-build REL-1751 or DEV-5882
# @script-version 1.0.4
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Installation:
# - Upload the script into your 'scripts' directory and reload denizen.
#
# Usage:
# - Type command "/flag help" to get usage info in-game.
#
# Permissions:
# - flag_editor: script.command.flag_editor
# - elevated_perms: script.command.elevated
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# You can execute the command in two seperate contexts:
#
# Context 1:
# - /flag {target} {flag_id} {operation} {value|options}
#
# Context 2:
# - /flag {target} {operation} {flag_id} {value|options}
#
# Defaults:
# - The {target} argument is optional and defaults to <server>.
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
# Targets:
# - | server | player_name | npc_id |
#
# Operations:
# - | view | assign | create | delete | add | remove | edit | reset | sort |
#
# Containers:
# - | public_flags | private_flags | fragile_flags |
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Description...
#
#
#
#
#
# | ---------------------------------------------- FLAG EDITOR | DATA --------------------------------------------- | #



flag_editor_config:
	########################################
	# |------- flag editor config -------| #
	########################################
	type: data
		# | ---  This config is intended to minimize script editing and easily define general command properties.  --- | #
	prefixes:
		# | ---  The elements contained are various prefixes referenced throughout command execution.  --- | #
		# | ---  The if_null fallbacks appended to each data tag below prevents trivial error output.  --- | #
		main: "<&7>[<&d><&l>FlagEdit<&7>]"
		toggle_cat: "<&7>[<&b>Toggle<&7>]"
		flag: "<&7>[<&d><&l>id<&7><&l>:<&b><[flag].if_null[null]><&7>]"
		operation: "<&7>[<&d><&l>op<&7><&l>:<&b><[operation].if_null[null]><&7>]"
		structure: "<&7>[<&d><&l>ds<&7><&l>:<&b><[structure].if_null[null]><&7>]"
		key: "<&7>[<&d><&l>key<&7><&l>:<&b><[key].if_null[null]><&7>]"
		value: "<&7>[<&d><&l>val<&7><&l>:<&b><[value].if_null[null]><&7>]"
	permissions:
		use-command: htools.flag_editor.use
		bypass-all: script.command.elevated
	operations:
		# | ---  The elements contained define all permitted flag operation inputs accepted by the command.  --- | #
		# | ---  Any elements missing from this data key will not be recognized as a valid flag operation.   --- | #
		# | ---  The elements contained should match a switch case element in the 'perform_operation' task.  --- | #
		- view
		- create
		- delete
		- add
		- remove
		- rename
		- edit
		- reset
		- purge
		- sort
	name-blacklist:
		# | ---  The elements contained are blacklisted from flag id | name inputs.  --- | #
		- <list[]>
		- <map[]>
		- <map[].before[<&rb>]>
	task-sequence:
		# | ---  The elements contained determine the main sequence of tasks injected into the command queue. --- | #
		# | ---  The elements contained must match task script ids and will be injected in descending order.  --- | #
		# | ---  The three tasks listed below are the tasks executed when performing an operation on a flag.  --- | #
		# | ---  Empty or null values will be ignored on execution. Invalid tasks will output to the console. --- | #
		# | ---  This section is intended to make modifying main command tasks simpler and allow a cleaner    --- | #
		# | ---  solution for task management, without requiring any direct modification to existing scripts. --- | #
		- null
		- flag_editor_determine_target
		- flag_editor_determine_context
		- flag_editor_perform_operation



# | ---------------------------------------------- FLAG EDITOR | COMMANDS ---------------------------------------------- | #



flag_editor_command:
	####################################
	# |------- command script -------| #
	####################################
	type: command
	debug: false
	name: fe
	description: Flag editor command.
	usage: /fe (target) (context) (option1) (option2) (...)
	aliases:
		- flag
		- flags
		- flagedit
		- flagsedit
		- flageditor
		- flagseditor
	tab completions:
        1: <player.location.find_npcs_within[25].parse[id]||npc-id>|<server.online_players.parse[name]>|<server.offline_players.parse[name]>|server
        2: operation
		3: flag
		4: value|option
        default: StopTyping
	script:
		# |------- command data -------| #
		- define prefix <script[flag_editor_config].parsed_key[prefixes].get[main]>
		- define tasks <script[flag_editor_config].data_key[task-sequence]>
		- define flag_operations <script[flag_editor_config].data_key[operations]>
		- define id_blacklist <script[flag_editor_config].data_key[name-blacklist]>
		- define permission <script[flag_editor_config].data_key[permissions].get[use-command]>
		- define elevated <player.has_permission[<script[flag_editor_config].data_key[permissions].get[bypass-all]>].global.if_null[false]>
		- define source_player <context.source_type.equals[player]>
		- define source_server <context.source_type.equals[server]>
		- define first <context.args.get[1]||null>
		- define second <context.args.get[2]||null>

		# |------- source check -------| #
		- if ( <[source_player]> ):
			# |------- permissions check -------| #
			- if ( <player.has_permission[<[permission]>].global> ) || ( <[permission]> == <empty> ) || ( <[permission]> == none ) || ( <[permission]> == null ):
				# |------- flag check -------| #
				- if ( not <player.has_flag[flag_editor]> ):
					- flag <player> flag_editor:false
				- if ( not <player.has_flag[flag_proximity]> ):
					- flag <player> flag_proximity:false

				# |------- category check  -------| #
				- choose <[first]>:
					- default:
						- if ( <player.flag[flag_editor]> ):
							# |------- start tasks -------| #
							- foreach <[tasks]> as:task:
								- if ( <[task].equals[<empty>]> ) || ( <[task].equals[null]> ):
									- foreach next
								- else if ( <script[<[task]>].exists> ):
									- inject <[task]>
								- else:
									- announce to_console "<[prefix]> -<&gt> <&lb>Warning<&rb> - The element '<[task]>' is not a valid task script and was subsequently ignored."
						- else if ( not <player.flag[flag_editor]> ):
							# |------- disabled -------| #
							- narrate "<[prefix]> <&c>You must enable the <&f>flag editor <&c>to use this command. <&7>/flag toggle"
							- stop
						- else:
							# |------- unauthorized -------| #
							- narrate "<[prefix]> <&c>You are not authorized to use <&f>flag <&c>commands. <&4>Administration has been notified<&c>."
							- announce to_console "<[prefix]> -<&gt> <&lb>Notification<&rb> - <player.name> attempted to execute administrative command /flag."
							- stop
					
					- case null:
						# |------- invert editor toggle -------| #
						- define pf_category <script[flag_editor_config].parsed_key[prefixes].get[toggle_cat]>
						- if ( <player.flag[flag_editor]> ):
							- flag <player> flag_editor:false
							- narrate '<[prefix]> <[pf_category]> <&c>Disabled<&f>.'
						- else:
							- flag <player> flag_editor:true
							- narrate '<[prefix]> <[pf_category]> <&a>Enabled<&f>.'
						- stop
					
					- case toggle:
						# |------- invert editor toggle -------| #
						- define pf_category <script[flag_editor_config].parsed_key[prefixes].get[toggle_cat]>
						- choose <[second]>:
							- default:
								- narrate '<[prefix]> <[pf_category]> <&c>Invalid command <&f>toggle <&c>state.'
							- case null:
								- if ( <player.flag[flag_editor]> ):
									- flag <player> flag_editor:false
									- narrate '<[prefix]> <[pf_category]> <&c>Disabled<&f>.'
								- else:
									- flag <player> flag_editor:true
									- narrate '<[prefix]> <[pf_category]> <&a>Enabled<&f>.'
						- stop

			- else:
				# |------- unauthorized -------| #
				- narrate "<[prefix]> <&c>You do not have permission to use the <&f>/<context.alias> <&c>command."
				- stop

		- else if ( <[source_server]> ) && ( <[elevated]> ):
			# |------- start tasks -------| #
			- foreach <[tasks]> as:task:
				- if ( <[task].equals[<empty>]> ) || ( <[task].equals[null]> ):
					- foreach next
				- else if ( <script[<[task]>].exists> ):
					- inject <[task]>
				- else:
					- announce to_console "<[prefix]> -<&gt> <&lb>Warning<&rb> - The element '<[task]>' is not a valid task script and was subsequently skipped."



# | ---------------------------------------------- FLAG EDITOR | TASKS ---------------------------------------------- | #



flag_editor_determine_target:
    #################################
	# |------- task script -------| #
	#################################
	type: task
	debug: false
	script:
		# |------- determine target -------| #
		- if ( not <context.args.is_empty> ):
			
			- if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ) || ( <server.npcs.contains[<npc[<[first]>].if_null[false]>]> ):
				# |------- target self ------| #
				- if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ):
					- define target <player>
				# |------- target npc ------| #
				- else if ( <server.npcs.contains[<npc[<[first]>].if_null[false]>]> ):
					- define target <npc[<[first]>]>
				# |------- options | context ------| #
				- define context <[second]>
				- define options <context.args.exclude[<[first]>|<[second]>]>

			- else if ( <[first].equals[server]> ) || ( <server.has_flag[<[first]>]> ) || ( <[flag_operations]> contains <[first]> ):
				# |------- target server -------| #
				- define target server
				# |------- options | context ------| #
				- if ( <[first].equals[server]> ):
					- define context <[second]>
					- define options <context.args.exclude[<[first]>|<[second]>]>
				- else:
					# |------- default target -------| #
					- define context <[first]>
					- define options <context.args.exclude[<[first]>]>
			
			- else if ( <server.match_player[<[first]>].exists> || <server.match_offline_player[<[first]>].exists> ) && ( not <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>].has_flag[<[first]>]> && not <[flag_operations].contains[<[first]>]> ):
				# |------- target player -------| #
				- define target <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>]>
				# |------- options | context ------| #
				- define context <[second]>
				- define options <context.args.exclude[<[first]>|<[second]>]>
			- else:
				# |------- invalid target -------| #
				- narrate "<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>."
				- stop
			
			# |------- define options -------| #
			- if not ( <[target].equals[null]> ):
				- define option_1 <[options].get[1]||null>
				- define option_2 <[options].get[2]||null>
				- define option_3 <[options].get[3]||null>
				- define option_4 <[options].get[4]||null>
				- define option_5 <[options].get[5]||null>
		
		- else:
			# |------- null context -------| #
			- narrate "<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>."
			- stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



flag_editor_determine_context:
	#################################
	# |------- task script -------| #
	#################################
    type: task
	debug: false
	script:
		# |------- context data -------| #
		- define flag null
		- define operation null
		- define value null
		
		# |------- determine context -------| #
		- if ( not <[context].equals[null]> ):

			- if ( <[target].has_flag[<[context]>].if_null[<server.has_flag[<[context]>]>]> ) || ( <[option_1].equals[create]> && not <[target].has_flag[<[context]>].if_null[<server.has_flag[<[context]>]>]> ):
				# |------- flag first -------| #
				- define flag <[context]>
				- if ( <[flag_operations]> contains <[option_1]> ) && ( not <[option_1].equals[null]> ):
					- define operation <[option_1]>
					- if ( not <[option_2].equals[null]> ):
						- define value <[option_2]>
				- else:
					# |------- invalid operation -------| #
					- if ( <[option_1].equals[null]> ):
						- narrate "<[prefix]> <&c>You must specify a valid <&f>operation <&c>to perform on the <&f>'<[flag]>' <&c>flag."
					- else:
						- narrate "<[prefix]> <&f>'<[option_1]>' <&c>is not a valid operation for the <&f>'<[flag]>' <&c>flag."
					- stop
			
			- else if ( <[flag_operations]> contains <[context]> ):
				# |------- operation first -------| #
				- define operation <[context]>
				- if ( <[target].has_flag[<[option_1]>].if_null[<server.has_flag[<[option_1]>]>]> ) || ( <[operation].equals[create]> && not <[target].has_flag[<[option_1]>].if_null[<server.has_flag[<[option_1]>]>]> ):
					- define flag <[option_1]>
					- if ( not <[option_2].equals[null]> ):
						- define value <[option_2]>
				- else:
					# |------- invalid flag -------| #
					- if ( <[option_1].equals[null]> ):
						- narrate "<[prefix]> <&c>You must specify a valid <&f>flag <&c>to complete the <&f>'<[operation]>' <&c>operation."
					- else:
						- narrate "<[prefix]> <&c>The flag <&f>'<[option_1]>' <&c>could not be <&f>located <&c>to complete the <&f>'<[operation]>' <&c>operation."
					- stop
			- else:
				# |------- invalid context -------| #
				- narrate "<[prefix]> <&c>You must specify a valid <&f>flag <&c>or <&f>operation <&c>to perform on target <&f><[target].name.if_null[<[target]>]><&c>."
				- stop
		- else:
			# |------- null context -------| #
			- narrate "<[prefix]> <&c>You must specify a valid <&f>flag <&c>or <&f>operation <&c>to perform on target <&f><[target].name.if_null[<[target]>]><&c>."
			- stop



# | ------------------------------------------------------------------------------------------------------------------------------ | #



flag_editor_perform_operation:
	#################################
	# |------- task script -------| #
	#################################
    type: task
	debug: false
	script:
		# |------- operation data -------| #
		- define data <[target].flag[<[flag]>].if_null[<server.flag[<[flag]>].if_null[null]>]>
		- define tagged <[target].has_flag[<[flag]>].if_null[<server.has_flag[<[flag]>].if_null[null]>]>
		- define entity <[target].name.if_null[<[target].id.if_null[<[target]>]>]>
		- define structure null

		# |------- structure check -------| #
		- if ( not <[data].equals[null]> ) && ( not <[operation].equals[create]> ):
			- if ( <[data].starts_with[<list[]>]> ):
				- define structure list
			- else if ( <[data].starts_with[<map[].before[<&rb>]>]> ):
				- define structure map
			- else:
				- define structure data
		
		# |------- define prefixes -------| #
		- define pf_flag <script[flag_editor_config].parsed_key[prefixes].get[flag]>
		- define pf_oper <script[flag_editor_config].parsed_key[prefixes].get[operation]>
		- define pf_struct <script[flag_editor_config].parsed_key[prefixes].get[structure]>
		
		# |------- determine operation -------| #
		- choose <[operation]>:
			- default:
				#############################
				# |------- invalid -------| #
				#############################
				- narrate "<[prefix]> <&f>'<[operation]>' <&c>is not a valid flag operation."
			
			- case null:
				##########################
				# |------- null -------| #
				##########################
				- narrate "<[prefix]> <&c>You must specify a valid <&f>operation <&c>to perform on the <&f>'<[flag]>' <&c>flag."
			
			- case view:
				##########################
				# |------- view -------| #
				##########################
				- if ( <[tagged]> ):
					- narrate "<&nl><[prefix]> <&f>Targeting <&b><[entity]> <&f>'<[flag]>'<&f>."
					- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
					- if ( <[structure].equals[data]> ):
						- if ( <[data].equals[<empty>]> ):
							- narrate "    <&7>- <&f>empty"
						- else:
							- narrate "    <&7>- <&f><[data]>"
					- if ( <[structure].equals[list]> ):
						- if ( <[data].is_empty> ):
							- narrate "    <&7>- <&f>empty"
						- else:
							- foreach <[data]> as:item:
								- narrate "    <&7>- <&f><[item]>"
					- else if ( <[structure].equals[map]> ):
						- if ( <[data].keys.is_empty> ):
							- narrate "    <&7>- <&b>key<&7>: <&f>empty"
						- else:
							- foreach <[data].keys> as:key:
								- narrate "    <&7>- <&b><[key]><&7>: <&f><[data].get[<[key]>]>"
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>doesn't contain the <&f>'<[flag]>' <&c>flag."
			
			- case create:
				############################
				# |------- create -------| #
				############################
				- if ( not <[tagged]> ):
					- if ( not <[value].equals[null]> ):
						- if ( <[value].equals[--data]> ) || ( <[value].equals[--empty]> ) || ( <[value].equals[--null]> ):
							- flag <[target]> <[flag]>:<empty>
							- flag <[target]> <[flag]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b>'<[flag]>' <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>."
							- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
						- else if ( <[value].equals[--list]> ) || ( <[value].equals[--li]> ):
							- flag <[target]> <[flag]>:<list[]>
							- flag <[target]> <[flag]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b>'<[flag]>' <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>list<&f>."
							- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
						- else if ( <[value].equals[--map]> ) || ( <[value].equals[--dict]> ):
							- flag <[target]> <[flag]>:<map[]>
							- flag <[target]> <[flag]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b>'<[flag]>' <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>hash map<&f>."
							- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
						- else:
							- flag <[target]> <[flag]>:<[value]>
							- flag <[target]> <[flag]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b>'<[flag]>' <&f>for target <&b><[entity]> <&f>was successfully created and set to the value <&b>'<[value]>'<&f>."
							- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
					- else:
						- flag <[target]> <[flag]>:<empty>
						- flag <[target]> <[flag]>:->:<[flag]>
						- narrate "<&nl><[prefix]> <&f>The flag <&b>'<[flag]>' <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>."
						- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
				- else:
					- narrate "<[prefix]> <&c>Flag <&f>'<[flag]>' <&c>already exists in flags <&f>'<[flag]>' <&c>database."
			
			- case delete:
				############################
				# |------- delete -------| #
				############################
				- if ( <[tagged]> ):
					- flag <[target]> <[flag]>:!
					- narrate "<&nl><[prefix]> <&f>Permanently deleted <&b>'<[flag]>' <&f>flag from the target <&b><[entity]><&f>."
					- narrate "<[pf_oper]> <[pf_flag]> <[pf_struct]>"
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>does not contain the <&f>'<[flag]>' <&c>flag."
			
			- case add:
				#########################
				# |------- add -------| #
				#########################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( not <[value].equals[null]> ):
							- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate "<&nl><[prefix]> <&f>Added <&b>'<[value]>' <&f>to the <&b>'<[flag]>' <&f>flag."
								- narrate "<[pf_oper]> <[pf_value]> <[pf_flag]> <[pf_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>already contains the <&f>'<[value]>' <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f>'<[flag]>' <&c>flag."
					- else if ( <[structure].equals[list]> ):
						- if ( not <[value].equals[null]> ):
							- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate "<&nl><[prefix]> <&f>Added <&b>'<[value]>' <&f>to the <&b>'<[flag]>' <&f>flag."
								- narrate "<[pf_oper]> <[pf_value]> <[pf_flag]> <[pf_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>already contains the <&f>'<[value]>' <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f>'<[flag]>' <&c>flag."
					- else if ( <[structure].equals[map]> ):
						- define key <[value]>
						- define value <[option_3]>
						- define pf_key <script[flag_editor_config].parsed_key[prefixes].get[key]>
						- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
						- if ( not <[key].equals[null]> ):
							- if ( not <[value].equals[null]> ):
								- if ( not <[data].contains[<[key]>]> ):
									- define copy <[data].include[<[key]>=<[value]>]>
									- flag <[target]> <[flag]>:<[copy]>
									- narrate "<&nl><[prefix]> <&f>Added <&b>'<[key]>' <&f>key to the <&b>'<[flag]>' <&f>flag."
									- narrate "<[pf_oper]> <[pf_key]> <[pf_flag]> <[pf_struct]>"
								- else:
									- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>already contains the <&f>'<[key]>' <&c>key."
							- else:
								- narrate "<[prefix]> <&c>You must specify a <&f>value <&c>for the key <&f>'<[key]>' <&c>to <&f>add <&c>this element to the <&f>map <&c>data structure."
						- else:
							- narrate "<[prefix]> <&c>You must specify a <&f>key<&c>: <&f>value <&c>pair to <&f>add <&c>elements to <&f>map <&c>data structures."
				- else:
					- narrate "<[prefix]> <&f><[entity]> <&c>doesn't have the <&f>'<[flag]>' <&c>flag."
			
			- case remove:
				############################
				# |------- remove -------| #
				############################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( not <[value].equals[null]> ):
							- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b>'<[value]>' <&f>from the <&b>'<[flag]>' <&f>flag."
								- narrate "<[pf_oper]> <[pf_value]> <[pf_flag]> <[pf_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>doesn't contain the <&f>'<[value]>' <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f>'<[flag]>' <&c>flag."
					- else if ( <[structure].equals[list]> ):
						- if ( not <[value].equals[null]> ):
							- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b>'<[value]>' <&f>from the <&b>'<[flag]>' <&f>flag."
								- narrate "<[pf_oper]> <[pf_value]> <[pf_flag]> <[pf_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>doesn't contain the <&f>'<[value]>' <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f>'<[flag]>' <&c>flag."
					- else if ( <[structure].equals[map]> ):
						- define key <[value]>
						- define value <[option_3]>
						- define pf_key <script[flag_editor_config].parsed_key[prefixes].get[key]>
						- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
						- if ( not <[key].equals[null]> ):
							- if ( <[data].contains[<[key]>]> ):
								- define copy <[data].exclude[<[key]>]>
								- flag <[target]> <[flag]>:<[copy]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b>'<[key]>' <&f>from the <&b>'<[flag]>' <&f>flag."
								- narrate "<[pf_oper]> <[pf_key]> <[pf_flag]> <[pf_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f>'<[flag]>' <&c>doesn't contain the <&f>'<[key]>' <&c>key."
						- else:
							- narrate "<[prefix]> <&c>You must specify a <&f>key <&c>to <&f>remove <&c>from the <&f>map <&c>data structure."
				- else:
					- narrate "<[prefix]> <&f><[entity]> <&c>doesn't have the <&f>'<[flag]>' <&c>flag."
			
			- case rename:
				############################
				# |------- rename -------| #
				############################
				- if ( <[tagged]> ):
					- if ( not <[value].equals[null]> ):
						- define pf_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
						- if ( not <[target].has_flag[<[value]>].if_null[<server.has_flag[<[value]>]>]> ):
							- flag <[target]> <[flag]>:!
							- flag <[target]> <[value]>:<[data]>
							- narrate "<&nl><[prefix]> <&f>Renamed <&b>'<[flag]>' <&f>flag to <&b>'<[value]>' <&f>from the target <&b><[entity]><&f>."
							- narrate "<[pf_oper]> <[pf_flag]> <[pf_value]>"
						- else:
							- narrate "<[prefix]> <&c>A flag with the name <&f>'<[value]>' <&c>already exists in target <&f><[entity]><&c>."
					- else:
						- narrate "<[prefix]> <&c>You must specify a <&f>name <&c>to rename the <&f>'<[flag]>' <&c>flag."
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>does not contain the <&f>'<[flag]>' <&c>flag."

			- case reset:
				###########################
				# |------- reset -------| #
				###########################
				- narrate null

			- case purge:
				###########################
				# |------- purge -------| #
				###########################
				- narrate "this operation will purge a flag from all of a target entity subset"
				- narrate "targets: | players | npcs | all |"

			- case sort:
				##########################
				# |------- sort -------| #
				##########################
				- narrate null

			- case edit:
				##########################
				# |------- edit -------| #
				##########################
				- narrate "this is definetly going to be the most complicated operation and will probably be added last..."



# | ------------------------------------------------------------------------------------------------------------------------------ | #



flag_editor_dialog:
    type: task
	debug: false
	script:
		- narrate "    This dialog will confirm sensitive changes, such as flag structural changes, before peforming the operation.    "
		- narrate "         (example: adding a value to a non-list | non-map flag, changing the flag's overall data structure)         "
		- narrate "                                        (editing data keys | values)                                                "
		- narrate "                                   (creating | deleting | reseting flags )                                          "
		- define valid true



# | ------------------------------------------------------------------------------------------------------------------------------ | #


