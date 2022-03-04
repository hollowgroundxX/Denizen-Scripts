# + -------------------------------------------------------------------------------------------- +
# |
# |  Flag Editor Command
# |
# |  Simple command to edit various entity flags and values. (additonal entity support coming soon!)
# |
# + -------------------------------------------------------------------------------------------- +
#
#
# @author HollowTheSilver
# @date 2022/02/28
# @denizen-build REL-1751 or DEV-5882
# @script-version 1.0.4
#
#
# -------------------------------------------------------------------------------------------- +
#
#
# Installation:
# - Upload the script into your 'scripts' directory and reload denizen.
#
# Usage:
# - Type command "/flag" to get usage info in-game.
#
# Permissions:
# - flag_editor: script.command.flag_editor
# - elevated_perms: script.command.elevated
#
#
# -------------------------------------------------------------------------------------------- +
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
# -------------------------------------------------------------------------------------------- +
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
# -------------------------------------------------------------------------------------------- +
#
#
# Description...
#
#
#
#
#
# -------------------------------------------------------------------------------------------- +


# | ---------------------------------------------- FLAG EDITOR | DATA --------------------------------------------- | #


flag_editor_config:
	###################################
	# |------- editor config -------| #
	###################################
	type: data
	prefixes:
		# | --- prefixes used throughout execution --- | #
		main: "<&7>[<&d><&l>Flag<&7>]"
		flag: "<&7>[<&d><&l>id<&7><&l>:<&b><[flag].if_null[null]><&7>]"
		container: "<&7>[<&d><&l>cn<&7><&l>:<&b><[container].if_null[null]><&7>]"
		operation: "<&7>[<&d><&l>op<&7><&l>:<&b><[operation].if_null[null]><&7>]"
		structure: "<&7>[<&d><&l>ds<&7><&l>:<&b><[structure].if_null[null]><&7>]"
		key: "<&7>[<&d><&l>key<&7><&l>:<&b><[key].if_null[null]><&7>]"
		value: "<&7>[<&d><&l>val<&7><&l>:<&b><[value].if_null[null]><&7>]"
	operations:
		# | --- elements contained define all flag operation inputs allowed --- | #
		- view
		- create
		- delete
		- add
		- remove
		- rename
		- edit
		- reset
		- sort
		- public
		- --public
		- private
		- --private
		- fragile
		- --fragile
	name-blacklist:
		# | --- elements contained are blacklisted from flag id|name inputs --- | #
		- <list[]>
		- <map[]>
		- <map[].before[<&rb>]>

		- <>

# | ---------------------------------------------- FLAG EDITOR | COMMANDS ---------------------------------------------- | #


flag_editor_command:
	########################################
	# |------- command properties -------| #
	########################################
	type: command
	debug: true
	name: flag
	description: Flag editor command.
	usage: /flag (target) (context) (option1) (option2) (...)
	aliases:
		- flags
	permission: script.command.flag_editor
	permission message: "<script[flag_editor_config].parsed_key[prefixes].get[main]> <&c>Entity<&co> <&f><player.name> <&c>is not authorized to use <&f>flag <&c>commands."
	tab completions:
        1: <player.location.find_npcs_within[25].parse[id]||npc-id>|<server.online_players.parse[name]>|<server.offline_players.parse[name]>|server
        2: operation
		3: flag
		4: value|option
        default: StopTyping
	script:
		#################################
		# |------- define data -------| #
		#################################
		- define prefix <script[flag_editor_config].parsed_key[prefixes].get[main]>
		- define flag_operations <script[flag_editor_config].data_key[operations]>
		- define id_blacklist <script[flag_editor_config].data_key[name-blacklist]>
		- define elevated <player.has_permission[script.command.elevated].global>
		- define first <context.args.get[1]||null>
		
		###################################
		# |------- define target -------| #
		###################################
		- if ( <context.source_type.equals[player]> ):
			- if ( <player.flag[flag_editor].if_null[false]> ):
				- if ( not <context.args.is_empty> ):
					- if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ) || ( <server.npcs.contains[<npc[<[first]>].if_null[false]>]> ):
						- if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ):
							- define target <player>
						- else if ( <server.npcs.contains[<npc[<[first]>].if_null[false]>]> ):
							- define target <npc[<[first]>]>
						- define public_flags <[target].flag[public_flags]||null>
						- define private_flags <[target].flag[private_flags]||null>
						- define fragile_flags <[target].flag[fragile_flags]||null>
						- define context <context.args.get[2]||null>
						- define options <context.args.exclude[<[context]>|<[first]>]||null>
					- else if ( <[first].equals[server]> ) || ( <server.flag[public_flags].if_null[<list[]>]> contains <[first]> ) || ( <server.flag[private_flags].if_null[<list[]>]> contains <[first]> ) || ( <[flag_operations]> contains <[first]> ):
						- define target server
						- define public_flags <server.flag[public_flags]||null>
						- define private_flags <server.flag[private_flags]||null>
						- define fragile_flags <server.flag[fragile_flags]||null>
						- if ( <[first].equals[server]> ):
							- define context <context.args.get[2]||null>
							- define options <context.args.exclude[<[context]>|<[first]>]||null>
						- else:
							- define context <[first]>
							- define options <context.args.exclude[<[context]>]||null>
					- else if ( <server.match_player[<[first]>].exists> || <server.match_offline_player[<[first]>].exists> ) && ( not <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>].flag[public_flags].if_null[<list[]>].contains[<[first]>]> ) && ( not <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>].flag[private_flags].if_null[<list[]>].contains[<[first]>]> ) && ( not <[flag_operations].contains[<[first]>]> ):
						- define target <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>]>
						- define public_flags <[target].flag[public_flags]||null>
						- define private_flags <[target].flag[private_flags]||null>
						- define fragile_flags <[target].flag[fragile_flags]||null>
						- define context <context.args.get[2]||null>
						- define options <context.args.exclude[<[target].name>|<[context]>]||null>
					- else:
						####################################
						# |------- invalid target -------| #
						####################################
						- narrate "<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>."
						- stop
				- else:
					##################################
					# |------- null context -------| #
					##################################
					- narrate "<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>."
					- stop
				
				####################################
				# |------- define options -------| #
				####################################
				- define option_1 <[options].get[1]||null>
				- define option_2 <[options].get[2]||null>
				- define option_3 <[options].get[3]||null>
				- define option_4 <[options].get[4]||null>
				- define option_5 <[options].get[5]||null>
				- define flag null
				- define operation null
				- define value null
				
				#######################################
				# |------- determine context -------| #
				#######################################
				- if ( not <[public_flags].equals[null]> ) && ( not <[private_flags].equals[null]> ) && ( not <[fragile_flags].equals[null]> ):
					- if ( not <[context].equals[null]> ):
						- if ( <[public_flags]> contains <[context]> ) || ( <[option_1].equals[create]> && not <[public_flags].contains[<[context]>]> && not <[private_flags].contains[<[context]>]> ) || ( <[private_flags].contains[<[context]>]> && <[elevated]> ):
							###############################
							# |------- context 1 -------| #
							###############################
							- define flag <[context]>
							- if ( <[flag_operations]> contains <[option_1]> ) && ( not <[option_1].equals[null]> ):
								- define operation <[option_1]>
								- if ( not <[option_2].equals[null]> ):
									- define value <[option_2]>
								###################################
								# |------- try operation -------| #
								###################################
								- inject perform_flag_operation_task
							- else:
								#######################################
								# |------- invalid operation -------| #
								#######################################
								- if ( not <[operation].equals[null]> ):
									- narrate "<[prefix]> <&f><[operation]> <&c>is not a valid operation for the <&f><[flag]> <&c>flag."
								- else:
									- narrate "<[prefix]> <&c>You must specify a valid <&f>operation <&c>to perform on the <&f><[flag]> <&c>flag."
								- stop
						
						- else if ( <[flag_operations]> contains <[context]> ):
							###############################
							# |------- context 2 -------| #
							###############################
							- define operation <[context]>
							- if ( <[public_flags].contains[<[option_1]>]> ) || ( <[operation].equals[create]> && not <[public_flags].contains[<[option_1]>]> && not <[private_flags].contains[<[option_1]>]> ) || ( <[private_flags].contains[<[option_1]>]> && <[elevated]> ):
								- define flag <[option_1]>
								- if ( not <[option_2].equals[null]> ):
									- define value <[option_2]>
								###################################
								# |------- try operation -------| #
								###################################
								- inject perform_flag_operation_task
							- else:
								##################################
								# |------- invalid flag -------| #
								##################################
								- narrate "<[prefix]> <&c>You must specify a valid <&f>flag <&c>to complete the <&f><[operation]> <&c>operation."
								- stop
						
						- else:
							#################################
							# |------- invalid arg -------| #
							#################################
							- narrate "<[prefix]> <&c>You must specify either an existing <&f>flag <&c>or <&f>operation <&c>for the target <&f><[target].name.if_null[<[target].id.if_null[<[target]>]>]><&c>."
							- stop
				- else:
					####################################
					# |------- null container -------| #
					####################################
					- narrate "<[prefix]> <&c>The target does not have the required <&f>containers <&c>to use flag edit commands."
					- stop

			- else if ( not <player.flag[flag_editor].if_null[true]> ):
				##############################
				# |------- disabled -------| #
				##############################
				- narrate "<[prefix]> <&c>You must enable the <&f>flag editor <&c>to use this command. <&7>/dev flag"
				- stop
			
			- else:
				##################################
				# |------- unauthorized -------| #
				##################################
				- narrate "<[prefix]> <&c>You are not authorized to use <&f>flag <&c>commands. <&4>Administration has been notified<&c>."
				- announce to_console "<&lb>Flag Editor<&rb> -<&gt> <&lb>Notification<&rb> - <player.name> attempted to execute administrative command /flag."
				- stop
			
			

# | ---------------------------------------------- FLAG EDITOR | TASKS ---------------------------------------------- | #


perform_flag_operation_task:
    type: task
	debug: true
	script:
		#################################
		# |------- define data -------| #
		#################################
		- define data <[target].flag[<[flag]>].if_null[<server.flag[<[flag]>].if_null[null]>]>
		- define tagged <[target].has_flag[<[flag]>].if_null[<server.has_flag[<[flag]>].if_null[null]>]>
		- define entity <[target].name.if_null[<[target].id.if_null[<[target]>]>]>
		- define valid true
		- define public false
		- define private false
		- define fragile false
		- define structure null
		- define container public_flags
		
		#####################################
		# |------- container check -------| #
		#####################################
		- if ( <[fragile_flags]> contains <[flag]> ):
			- define fragile true
			- define valid false
		- if ( <[public_flags]> contains <[flag]> ):
			- define public true
		- if ( <[private_flags]> contains <[flag]> ):
			- define private true
			- define container private_flags
		- if ( <[public]> && <[private]> ):
			- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>is contained within' the <&f>public <&c>and <&f>private <&c>databases. This typically means there's a <&4>critical error <&c>within' the script's logic."
			- debug error "[Flag Editor] -<&gt> [Error] -<&gt> [<player.name>] The flag: <[flag]> is contained within' the public and private databases. This typically means there's a critical error within' the task logic."
			- stop
		
		#####################################
		# |------- structure check -------| #
		#####################################
		- if ( not <[data].equals[null]> ) && ( not <[operation].equals[create]> ):
			- if ( <[data].starts_with[<list[]>]> ):
				- define structure list
			- else if ( <[data].starts_with[<map[].before[<&rb>]>]> ):
				- define structure map
			- else:
				- define structure data
		
		#####################################
		# |------- define prefixes -------| #
		#####################################
		- define prefix_flag <script[flag_editor_config].parsed_key[prefixes].get[flag]>
		- define prefix_cont <script[flag_editor_config].parsed_key[prefixes].get[container]>
		- define prefix_oper <script[flag_editor_config].parsed_key[prefixes].get[operation]>
		- define prefix_struct <script[flag_editor_config].parsed_key[prefixes].get[structure]>
		
		#########################################
		# |------- determine operation -------| #
		#########################################
		- choose <[operation]>:
			- default:
				#############################
				# |------- invalid -------| #
				#############################
				- narrate "<[prefix]> <&f><[operation]> <&c>is not a valid flag operation."
			
			- case null:
				##########################
				# |------- null -------| #
				##########################
				- narrate "<[prefix]> <&c>You must specify an <&f>operation <&c>to perform on the <&f><[flag]> <&c>flag."
			
			- case view:
				##########################
				# |------- view -------| #
				##########################
				- if ( <[tagged]> ):
					- if ( <[public]> && not <[private]> ) || ( <[private]> && not <[public]> && <[elevated]> ):
						- if ( <[fragile]> ):
							- inject flag_editor_dialog
						- if ( <[valid]> ):
							- narrate "<&nl><[prefix]> <&f>Targeting <&b><[entity]> <&f><[container]>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_struct]>"
							- if ( <[structure].equals[data]> ):
								- if ( <[data].equals[<empty>]> ):
									- narrate "    <&7>- <&f>empty"
								- else:
									- narrate "    <&7>- <&f><[data]>"
							- else:
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
							- narrate "<[prefix]> <&c>Cancelled operation <&f><[operation]> <&c>on protected flag <&f><[flag]><&c>."
					- else:
						- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>is private and cannot be <&f>viewed<&c>."
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>doesn't contain the <&f><[flag]> <&c>flag."
			
			- case create:
				############################
				# |------- create -------| #
				############################
				- if ( not <[tagged]> && not <[public]> && not <[private]> ):
					- if ( not <[value].equals[null]> ):
						- if ( <[value].equals[--data]> ) || ( <[value].equals[--empty]> ) || ( <[value].equals[--null]> ):
							- flag <[target]> <[flag]>:<empty>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
						- else if ( <[value].equals[--list]> ) || ( <[value].equals[--li]> ):
							- flag <[target]> <[flag]>:<list[]>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>list<&f>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
						- else if ( <[value].equals[--map]> ) || ( <[value].equals[--dict]> ):
							- flag <[target]> <[flag]>:<map[]>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>hash map<&f>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
						- else:
							- flag <[target]> <[flag]>:<[value]>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate "<&nl><[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to the value <&b><[value]><&f>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
					- else:
						- flag <[target]> <[flag]>:<empty>
						- flag <[target]> <[container]>:->:<[flag]>
						- narrate "<&nl><[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>."
						- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
				- else:
					- narrate "<[prefix]> <&c>Flag <&f><[flag]> <&c>already exists in flags <&f><[container]> <&c>database."
			
			- case delete:
				############################
				# |------- delete -------| #
				############################
				- if ( <[tagged]> ):
					- if ( <[public]> && not <[private]> ) || ( <[private]> && not <[public]> && <[elevated]> ):
						- if ( <[fragile]> ):
							- inject flag_editor_dialog
						- if ( <[valid]> ):
							- flag <[target]> <[flag]>:!
							- flag <[target]> <[container]>:<-:<[flag]>
							- narrate "<&nl><[prefix]> <&f>Permanently deleted <&b><[flag]> <&f>flag from the target <&b><[entity]><&f>."
							- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_cont]>"
						- else:
							- narrate "<[prefix]> <&c>Cancelled operation <&f><[operation]> <&c>on protected flag <&f><[flag]><&c>."
					- else:
						- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>is private and cannot be deleted."
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>does not contain the <&f><[flag]> <&c>flag."
			
			- case add:
				#########################
				# |------- add -------| #
				#########################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( not <[value].equals[null]> ):
							- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate "<&nl><[prefix]> <&f>Added <&b><[value]> <&f>to the <&b><[flag]> <&f>flag."
								- narrate "<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[value]> <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f><[flag]> <&c>flag."
					- else if ( <[structure].equals[list]> ):
						- if ( not <[value].equals[null]> ):
							- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate "<&nl><[prefix]> <&f>Added <&b><[value]> <&f>to the <&b><[flag]> <&f>flag."
								- narrate "<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[value]> <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f><[flag]> <&c>flag."
					- else if ( <[structure].equals[map]> ):
						- define key <[value]>
						- define value <[option_3]>
						- define prefix_key <script[flag_editor_config].parsed_key[prefixes].get[key]>
						- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
						- if ( not <[key].equals[null]> ):
							- if ( not <[value].equals[null]> ):
								- if ( not <[data].contains[<[key]>]> ):
									- define copy <[data].include[<[key]>=<[value]>]>
									- flag <[target]> <[flag]>:<[copy]>
									- narrate "<&nl><[prefix]> <&f>Added <&b><[key]> <&f>key to the <&b><[flag]> <&f>flag."
									- narrate "<[prefix_oper]> <[prefix_key]> <[prefix_flag]> <[prefix_struct]>"
								- else:
									- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[key]> <&c>key."
							- else:
								- narrate "<[prefix]> <&c>You must specify a <&f>value <&c>for the key <&f><[key]> <&c>to <&f>add <&c>this element to the <&f>map <&c>data structure."
						- else:
							- narrate "<[prefix]> <&c>You must specify a <&f>key<&c>: <&f>value <&c>pair to <&f>add <&c>elements to <&f>map <&c>data structures."
				- else:
					- narrate "<[prefix]> <&f><[entity]> <&c>doesn't have the <&f><[flag]> <&c>flag."
			
			- case remove:
				############################
				# |------- remove -------| #
				############################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( not <[value].equals[null]> ):
							- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b><[value]> <&f>from the <&b><[flag]> <&f>flag."
								- narrate "<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[value]> <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f><[flag]> <&c>flag."
					- else if ( <[structure].equals[list]> ):
						- if ( not <[value].equals[null]> ):
							- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b><[value]> <&f>from the <&b><[flag]> <&f>flag."
								- narrate "<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[value]> <&c>value."
						- else:
							- narrate "<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f><[flag]> <&c>flag."
					- else if ( <[structure].equals[map]> ):
						- define key <[value]>
						- define value <[option_3]>
						- define prefix_key <script[flag_editor_config].parsed_key[prefixes].get[key]>
						- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
						- if ( not <[key].equals[null]> ):
							- if ( <[data].contains[<[key]>]> ):
								- define copy <[data].exclude[<[key]>]>
								- flag <[target]> <[flag]>:<[copy]>
								- narrate "<&nl><[prefix]> <&f>Removed <&b><[key]> <&f>from the <&b><[flag]> <&f>flag."
								- narrate "<[prefix_oper]> <[prefix_key]> <[prefix_flag]> <[prefix_struct]>"
							- else:
								- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[key]> <&c>key."
						- else:
							- narrate "<[prefix]> <&c>You must specify a <&f>key <&c>to <&f>remove <&c>from the <&f>map <&c>data structure."
				- else:
					- narrate "<[prefix]> <&f><[entity]> <&c>doesn't have the <&f><[flag]> <&c>flag."
			
			- case rename:
				############################
				# |------- rename -------| #
				############################
				- if ( <[tagged]> ):
					- if ( <[public]> && not <[private]> ) || ( <[private]> && not <[public]> && <[elevated]> ):
						- if ( <[fragile]> ):
							- inject flag_editor_dialog
						- if ( <[valid]> ):
							- if ( not <[value].equals[null]> ):
								- define prefix_value <script[flag_editor_config].parsed_key[prefixes].get[value]>
								- if ( not <[public_flags].contains[<[value]>]> ) && ( not <[private_flags].contains[<[value]>]> ):
									- flag <[target]> <[flag]>:!
									- flag <[target]> <[container]>:<-:<[flag]>
									- flag <[target]> <[value]>:<[data]>
									- flag <[target]> <[container]>:->:<[value]>
									- narrate "<&nl><[prefix]> <&f>Renamed <&b><[flag]> <&f>flag to <&b><[value]> <&f>from the target <&b><[entity]><&f>."
									- narrate "<[prefix_oper]> <[prefix_flag]> <[prefix_value]>"
								- else:
									- narrate "<[prefix]> <&c>A flag with the name <&f><[value]> <&c>already exists in target <&f><[entity]><&c>."
							- else:
								- narrate "<[prefix]> <&c>You must specify a <&f>name <&c>to rename the <&f><[flag]> <&c>flag."
						- else:
							- narrate "<[prefix]> <&c>Cancelled operation <&f><[operation]> <&c>on protected flag <&f><[flag]><&c>."
					- else:
						- narrate "<[prefix]> <&c>The flag <&f><[flag]> <&c>is private and cannot be renamed."
				- else:
					- narrate "<[prefix]> <&c>Target <&f><[entity]> <&c>does not contain the <&f><[flag]> <&c>flag."
			
			- case public --public private --private fragile --fragile:
				###############################
				# |------- container -------| #
				###############################
				- narrate null

			- case reset:
				###########################
				# |------- reset -------| #
				###########################
				- narrate null
			
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
	debug: true
	script:
		- narrate "    This dialog will confirm sensitive changes, such as flag structural changes, before peforming the operation.    "
		- narrate "         (example: adding a value to a non-list | non-map flag, changing the flag's overall data structure)         "
		- narrate "                                        (editing data keys | values)                                                "
		- narrate "                                   (creating | deleting | reseting flags )                                          "
		- define valid true



# | ---------------------------------------------- FLAG EDITOR | EVENTS --------------------------------------------- | #


flag_editor_config_events:
	######################################
	# |------- event properties -------| #
	######################################
	type: world
	debug: false
	events:
		################################
		# |------- flag check -------| #
		################################
		after player joins:
			- if not ( <player.has_flag[private_flags]> ):
				- flag <player> private_flags:!|:<list[public_flags|private_flags|fragile_flags]>
			- if not ( <player.has_flag[public_flags]> ):
				- flag <player> public_flags:!|:<list[]>
				- if not ( <player.flag[private_flags].contains[public_flags].if_null[true]> ):
					- flag <player> private_flags:->:public_flags
			- if not ( <player.has_flag[fragile_flags]> ):
				- flag <player> fragile_flags:!|:<list[]>
				- if not ( <player.flag[private_flags].contains[fragile_flags].if_null[true]> ):
					- flag <player> private_flags:->:fragile_flags



# | ------------------------------------------------------------------------------------------------------------------------------ | #

