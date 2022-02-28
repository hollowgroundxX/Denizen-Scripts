#
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
# Installation:
# - Upload the script into your 'scripts' directory and reload denizen.
# 
# Usage:
# - Type command "/flag" to get usage info in-game.
# 
#
# -------------------------------------------------------------------------------------------- +
#
# You can execute the command in two seperate contexts:
#
# - Context 1: /flag {target} {flag_id} {operation} {value|options}
#
# - Context 2: /flag {target} {operation} {flag_id} {value|options}
#
# - Defaults: The {target} argument is optional and defaults to <server>. 
# 
# -------------------------------------------------------------------------------------------- +
#  
# [Targets]: server | player_name | npc_id
# 
# [Operations]: view | assign | create | delete | add | remove | edit | reset | sort
# 
# [Containers]: public_flags | private_flags | fragile_flags
#
# -------------------------------------------------------------------------------------------- +
#
# Description...
#
#
#
#
#
# -------------------------------------------------------------------------------------------- +



# | ---------------------------------------------- FLAG EDITOR | EVENTS --------------------------------------------- | #


flag_editor_data_events:
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
			- if not ( <player.has_flag[public_flags]> ):
				- flag <player> public_flags:!|:li@
			- if not ( <player.has_flag[private_flags]> ):
				- flag <player> private_flags:!|:li@public_flags|private_flags|fragile_flags
			- if not ( <player.has_flag[fragile_flags]> ):
				- flag <player> fragile_flags:!|:li@
	
	
	
# | ---------------------------------------------- FLAG EDITOR | DATA --------------------------------------------- | #


flag_editor_data:
	#################################
	# |------- editor data -------| #
	#################################
    type: data
	prefix: Flag
	operations:
		- view
		- create
		- delete
		- add
		- remove
		- update
		- edit
		- reset
		- sort
	
	
	
# | ---------------------------------------------- FLAG EDITOR | COMMANDS ---------------------------------------------- | #


flag_editor_command:
	########################################
	# |------- command properties -------| #
	########################################
	type: command
	debug: true
	name: flag
	usage: /flag {target} {context} {option1} {option2} {...}
	aliases:
		- flags
	permission: script.command.flag_editor
	permission message: '<gray>[<&b><&l>DevMode<gray>] <red>Entity: <white><player.name>, <red>is not authorized to use <white>flag <red>commands.'
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
		- define prefix <&7>[<&d><&l><script[flag_editor_data].data_key[prefix]><&7>]
		- define flag_operations <script[flag_editor_data].data_key[operations]>
		- define elevated <player.has_permission[script.command.elevated].global>
		- define first <context.args.get[1]||null>
		
		##################################
		# |------- source check -------| #
		##################################
		- if ( <context.source_type> == player ):
			- if ( <player.flag[flag_editor].if_null[false]> ):
				
				#######################################
				# |------- define containers -------| #
				#######################################
				- if ( <[first].equals[server]> ):
					- define public_flags <server.flag[public_flags]||null>
					- define private_flags <server.flag[private_flags]||null>
					- define fragile_flags <server.flag[fragile_flags]||null>
				- else if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ):
					- define public_flags <player.flag[public_flags]||null>
					- define private_flags <player.flag[private_flags]||null>
					- define fragile_flags <player.flag[fragile_flags]||null>
				- else if ( <server.match_player[<[first]>].exists> ) || ( <server.match_offline_player[<[first]>].exists> ):
					- define target <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>]>
					- define public_flags <[target].flag[public_flags]||null>
					- define private_flags <[target].flag[private_flags]||null>
					- define fragile_flags <[target].flag[fragile_flags]||null>
				- else:
					- define public_flags <server.flag[public_flags]||null>
					- define private_flags <server.flag[private_flags]||null>
					- define fragile_flags <server.flag[fragile_flags]||null>
				
				######################################
				# |------- define arguments -------| #
				######################################
				- if ( <[public_flags]> != null ) && ( <[private_flags]> != null ) && ( <[fragile_flags]> != null ):
					- if ( not <context.args.is_empty> ):
						- if ( <[first].equals[server]> ) || ( <[first].equals[me]> ) || ( <[first].equals[myself]> ):
							- if ( <[first].equals[me]> ) || ( <[first].equals[myself]> ):
								- define target <player>
							- else if ( <[first].equals[server]> ):
								- define target server
							- define context <context.args.get[2]||null>
							- define option_1 <context.args.exclude[<[context]>|<[first]>].get[1]||null>
							- define option_2 <context.args.exclude[<[context]>|<[first]>].get[2]||null>
							- define option_3 <context.args.exclude[<[context]>|<[first]>].get[3]||null>
						- else if ( <[public_flags]> contains <[first]> ) || ( <[private_flags]> contains <[first]> ) || ( <[flag_operations]> contains <[first]> ):
							- define target server
							- define context <[first]>
							- define option_1 <context.args.exclude[<[context]>].get[1]||null>
							- define option_2 <context.args.exclude[<[context]>].get[2]||null>
							- define option_3 <context.args.exclude[<[context]>].get[3]||null>
						- else if ( <server.match_player[<[first]>].exists> || <server.match_offline_player[<[first]>].exists> ) && ( not <[public_flags].contains[<[first]>]> ) && ( not <[private_flags].contains[<[first]>]> ) && ( not <[flag_operations].contains[<[first]>]> ):
							- define target <server.match_player[<[first]>].if_null[<server.match_offline_player[<[first]>]>]>
							- define context <context.args.get[2]||null>
							- define option_1 <context.args.exclude[<[target].name>|<[context]>].get[1]||null>
							- define option_2 <context.args.exclude[<[target].name>|<[context]>].get[2]||null>
							- define option_3 <context.args.exclude[<[target].name>|<[context]>].get[3]||null>
						- else:
							####################################
							# |------- invalid target -------| #
							####################################
							- narrate '<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>.'
							- stop
					- else:
						##################################
						# |------- null context -------| #
						##################################
						- narrate '<[prefix]> <&c>You must specify a valid <&f>target<&c>, <&f>flag <&c>or <&f>operation<&c>.'
						- stop
				- else:
					####################################
					# |------- null container -------| #
					####################################
					- narrate '<[prefix]> <&c>The target does not have the required <&f>containers <&c>to use flag edit commands.'
					- stop
				
				####################################
				# |------- define options -------| #
				####################################
				- define flag null
				- define operation null
				- define value null
				
				#######################################
				# |------- determine context -------| #
				#######################################
				- if ( <[context]> != null ):
					- if ( <[public_flags]> contains <[context]> ) || ( <[option_1]> == 'create'  &&  not <[public_flags].contains[<[context]>]> && not <[private_flags].contains[<[context]>]> ) || ( <[private_flags].contains[<[context]>]> && <[elevated]> ):
						###############################
						# |------- context 1 -------| #
						###############################
						- define flag <[context]>
						- if ( <[flag_operations]> contains <[option_1]> ) && ( <[option_1]> != null ):
							- define operation <[option_1]>
							- if ( <[option_2]> != null ):
								- define value <[option_2]>
							###################################
							# |------- try operation -------| #
							###################################
							- inject perform_flag_operation_task
						- else:
							#######################################
							# |------- invalid operation -------| #
							#######################################
							- if ( <[operation]> != null ):
								- narrate '<[prefix]> <&f><[operation]> <&c>is not a valid operation for the <&f><[flag]> <&c>flag.'
							- else:
								- narrate '<[prefix]> <&c>You must specify a valid <&f>operation <&c>to perform on the <&f><[flag]> <&c>flag.'
							- stop
					
					- else if ( <[flag_operations]> contains <[context]> ):
						###############################
						# |------- context 2 -------| #
						###############################
						- define operation <[context]>
						- if ( <[public_flags].contains[<[option_1]>]> ) || ( <[operation]> == 'create'  &&  not <[public_flags].contains[<[option_1]>]> && not <[private_flags].contains[<[option_1]>]> ) || ( <[private_flags].contains[<[option_1]>]> && <[elevated]> ):
							- define flag <[option_1]>
							- if ( <[option_2]> != null ):
								- define value <[option_2]>
							###################################
							# |------- try operation -------| #
							###################################
							- inject perform_flag_operation_task
						- else:
							##################################
							# |------- invalid flag -------| #
							##################################
							- narrate '<[prefix]> <&c>You must specify a valid <&f>flag <&c>to complete the <&f><[operation]> <&c>operation.'
							- stop
					
					- else:
						#################################
						# |------- invalid arg -------| #
						#################################
						- narrate '<[prefix]> <&c>You must specify either an existing <&f>flag <&c>or <&f>operation <&c>for the target <&f><[target].name.if_null[server]><&c>.'
						- stop
			
			- else if ( not <player.flag[flag_editor].if_null[true]> ):
				##############################
				# |------- disabled -------| #
				##############################
				- narrate '<[prefix]> <&c>You must enable the <&f>flag editor <&c>to use this command. <&7>/dev flag'
				- stop
			
			- else:
				##################################
				# |------- unauthorized -------| #
				##################################
				- narrate '<[prefix]> <&c>You are not authorized to use <&f>flag <&c>commands. <&4>Administration has been notified<&c>.'
				- announce to_console '[Flag Editor] -> [Notification] - <player.name> attempted to execute administrative command /flag.'
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
		- define entity <[target].name.if_null[<[target]>]>
		- define valid true
		- define public false
		- define private false
		- define fragile false
		- define structure null
		- define container public_flags
		
		################################
		# |------- data check -------| #
		################################
		- if ( <[fragile_flags]> contains <[flag]> ):
			- define fragile true
			- define valid false
		- if ( <[public_flags]> contains <[flag]> ):
			- define public true
		- if ( <[private_flags]> contains <[flag]> ):
			- define private true
			- define container private_flags
		- if ( <[public]> && <[private]> ):
			- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>is contained within' the <&f>public <&c>and <&f>private <&c>databases. This typically means there's a <&4>critical error <&c>within' the script's logic.' 
			- debug error '[Flag Editor] -> [Error] -> [<player.name>] The flag: <[flag]> is contained within' the public and private databases. This typically means there's a critical error within' the task logic.'
			- stop
		
		#####################################
		# |------- structure check -------| #
		#####################################
		- if ( <[data]> != null ) && ( <[operation]> != create ):
			- if ( not <[data].size.exists> ) && ( <[data]> == <empty> || <[data]> != <empty> ):
				- define structure data
			- else if ( <[data].any.exists.if_null[false]> ):
				- define structure list
			- else if ( <[data].keys.exists.if_null[false]> ):
				- define structure map
				- define key <[value]>
				- define value <[option_3]>
		
		###################################
		# |------- define format -------| #
		###################################
		- define prefix_flag '<&7>[<&d><&l>id<&7><&l>:<&b><[flag]><&7>]'
		- define prefix_oper '<&7>[<&d><&l>op<&7><&l>:<&b><[operation]><&7>]'
		- define prefix_value '<&7>[<&d><&l>val<&7><&l>:<&b><[value]><&7>]'
		- define prefix_key '<&7>[<&d><&l>key<&7><&l>:<&b><[key]><&7>]'
		- define prefix_type '<&7>[<&d><&l>db<&7><&l>:<&b><[structure]><&7>]'
		
		#########################################
		# |------- determine operation -------| #
		#########################################
		- choose <[operation]>:
			- default:
				#############################
				# |------- invalid -------| #
				#############################
				- narrate '<[prefix]> <&f><[operation]> <&c>is not a valid flag operation.'
			
			- case null:
				##########################
				# |------- null -------| #
				##########################
				- narrate '<[prefix]> <&c>You must specify an <&f>operation <&c>to perform on the <&f><[flag]> <&c>flag.'
			
			- case view:
				##########################
				# |------- view -------| #
				##########################
				- if ( <[tagged]> ):
					- if ( <[public]> && not <[private]> ) || ( <[private]> && not <[public]> && <[elevated]> ):
						- if ( <[fragile]> ):
							- inject flag_editor_dialog
						- if ( <[valid]> ):
							- narrate '<[prefix]> <&f>Targeting <&b><[entity]> <&f><[container]>.'
							- narrate '<[prefix_oper]> <[prefix_flag]> <[prefix_type]>'
							- if ( <[structure].equals[data]> ):
								- if ( <[data].equals[<empty>]> ):
									- narrate '    <&7>- <&f>empty'
								- else:
									- narrate '    <&7>- <&f><[data]>'
							- else:
								- if ( <[structure].equals[list]> ):
									- if ( <[data].is_empty> ):
										- narrate '    <&7>- <&f>empty'
									- else:
										- foreach <[data]> as:item:
											- narrate '    <&7>- <&f><[item]>'
								- else if ( <[structure].equals[map]> ):
									- if ( <[data].keys.is_empty> ):
										- narrate '    <&7>- <&b>key<&7>: <&f>empty'
									- else:
										- foreach <[data].keys> as:key:
											- narrate '    <&7>- <&b><[key]><&7>: <&f><[data].get[<[key]>]>'
						- else:
							- narrate '<[prefix]> <&c>Cancelled operation <&f><[operation]> <&c>on protected flag <&f><[flag]><&c>.'
					- else:
						- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>is private and cannot be <&f>viewed<&c>.'
				- else:
					- narrate '<[prefix]> <&c>Target <&f><[entity]> <&c>doesn't contain the <&f><[flag]> <&c>flag.'
			
			- case create:
				############################
				# |------- create -------| #
				############################
				- if ( not <[tagged]> && not <[public]> && not <[private]> ):
					- if ( <[value]> != null ):
						- if ( <[value].equals[--data]> ) || ( <[value].equals[--empty]> ) || ( <[value].equals[--null]> ):
							- flag <[target]> <[flag]>:<empty>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate '<[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>.'
						- else if ( <[value].equals[--list]> ) || ( <[value].equals[--li]> ):
							- flag <[target]> <[flag]>:li@
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate '<[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>list<&f>.'
						- else if ( <[value].equals[--map]> ) || ( <[value].equals[--dict]> ):
							- flag <[target]> <[flag]>:map@[]
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate '<[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created as an empty <&b>hash map<&f>.'
						- else:
							- flag <[target]> <[flag]>:<[value]>
							- flag <[target]> <[container]>:->:<[flag]>
							- narrate '<[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to the value <&b><[value]><&f>.'
					- else:
						- flag <[target]> <[flag]>:<empty>
						- flag <[target]> <[container]>:->:<[flag]>
						- narrate '<[prefix]> <&f>The flag <&b><[flag]> <&f>for target <&b><[entity]> <&f>was successfully created and set to <&b>empty<&f>.'
				- else:
					- narrate '<[prefix]> <&c>Flag <&f><[flag]> <&c>already exists in flags database.'
			
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
							- narrate '<[prefix]> <&f>Permanently deleted <&b><[flag]> <&f>flag from the target <&b><[entity]><&f>.'
						- else:
							- narrate '<[prefix]> <&c>Cancelled operation <&f><[operation]> <&c>on protected flag <&f><[flag]><&c>.'
					- else:
						- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>is private and cannot be deleted.'
				- else:
					- narrate '<[prefix]> <&c>Target <&f><[entity]> <&c>does not contain the <&f><[flag]> <&c>flag.'
			
			- case add:
				#########################
				# |------- add -------| #
				#########################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( <[value]> != null ):
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate '<[prefix]> <&f>Added <&b><[value]> <&f>to the <&b><[flag]> <&f>flag.'
								- narrate '<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_type]>'
							- else:
								- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[value]> <&c>value.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f><[flag]> <&c>flag.'
					- else if ( <[structure].equals[list]> ):
						- if ( <[value]> != null ):
							- if ( not <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:->:<[value]>
								- narrate '<[prefix]> <&f>Added <&b><[value]> <&f>to the <&b><[flag]> <&f>flag.'
								- narrate '<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_type]>'
							- else:
								- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[value]> <&c>value.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a valid <&f>value <&c>to add to the <&f><[flag]> <&c>flag.'
					- else if ( <[structure].equals[map]> ):
						- if ( <[key]> != null ):
							- if ( <[value]> != null ):
								- if ( not <[data].contains[<[key]>]> ):
									- define copy <[data].include[<[key]>=<[value]>]>
									- flag <[target]> <[flag]>:<[copy]>
									- narrate '<[prefix]> <&f>Added <&b><[key]> <&f>key to the <&b><[flag]> <&f>flag.'
									- narrate '<[prefix_oper]> <[prefix_key]> <[prefix_flag]> <[prefix_type]>'
								- else:
									- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>already contains the <&f><[key]> <&c>key.'
							- else:
								- narrate '<[prefix]> <&c>You must specify a <&f>value <&c>for the key <&f><[key]> <&c>to <&f>add <&c>this element to the <&f>map <&c>data structure.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a <&f>key<&c>: <&f>value <&c>pair to <&f>add <&c>elements to <&f>map <&c>data structures.'
				- else:
					- narrate '<[prefix]> <&f><[entity]> <&c>doesn't have the <&f><[flag]> <&c>flag.'		
			
			- case remove:
				############################
				# |------- remove -------| #
				############################
				- if ( <[tagged]> ):
					- if ( <[structure].equals[data]> ):
						- if ( <[value]> != null ):
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate '<[prefix]> <&f>Removed <&b><[value]> <&f>from the <&b><[flag]> <&f>flag.'
								- narrate '<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_type]>'
							- else:
								- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[value]> <&c>value.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f><[flag]> <&c>flag.'
					- else if ( <[structure].equals[list]> ):
						- if ( <[value]> != null ):
							- if ( <[data].contains[<[value]>]> ):
								- flag <[target]> <[flag]>:<-:<[value]>
								- narrate '<[prefix]> <&f>Removed <&b><[value]> <&f>from the <&b><[flag]> <&f>flag.'
								- narrate '<[prefix_oper]> <[prefix_value]> <[prefix_flag]> <[prefix_type]>'
							- else:
								- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[value]> <&c>value.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a valid <&f>value <&c>to remove from the <&f><[flag]> <&c>flag.'
					- else if ( <[structure].equals[map]> ):
						- if ( <[key]> != null ):
							- if ( <[data].contains[<[key]>]> ):
								- define copy <[data].exclude[<[key]>]>
								- flag <[target]> <[flag]>:<[copy]>
								- narrate '<[prefix]> <&f>Removed <&b><[key]> <&f>from the <&b><[flag]> <&f>flag.'
								- narrate '<[prefix_oper]> <[prefix_key]> <[prefix_flag]> <[prefix_type]>'
							- else:
								- narrate '<[prefix]> <&c>The flag <&f><[flag]> <&c>doesn't contain the <&f><[key]> <&c>key.'
						- else:
							- narrate '<[prefix]> <&c>You must specify a <&f>key <&c>to <&f>remove <&c>from the <&f>map <&c>data structure.'
				- else:
					- narrate '<[prefix]> <&f><[entity]> <&c>doesn't have the <&f><[flag]> <&c>flag.'
			
			- case update:
				############################
				# |------- update -------| #
				############################
				- narrate null
			
			- case edit:
				##########################
				# |------- edit -------| #
				##########################
				- narrate "this is definetly going to be the most complicated operation and will probably be added last..."
			
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


