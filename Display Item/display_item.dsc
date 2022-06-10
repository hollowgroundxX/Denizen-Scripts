# + ------------------------------------------------------------------------------------------------------------------ +
# |
# |  Htools -> Display Item Script
# |
# + ------------------------------------------------------------------------------------------------------------------ +
#
#
# @author HollowTheSilver
# @date 2022/06/03
# @denizen-build REL-1751 or DEV-5882
# @script-version 1.0.3
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Description:
# - A simple command that allows authorized players to visually display an item or block they are holding.
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Installation:
# - Upload the script into your 'scripts' directory and reload denizen with /ex reload.
#
# Help:
# - Type command "/display help" to get usage info in-game.
#
# Permissions:
# - Use command: htools.display_item
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Usage:
#
# () = optional
# {} = required
#
# Context 1:
# - /display (duration)
#
#
# | ---------------------------------------------- FLAG EDITOR | DATA --------------------------------------------- | #



display_item_config:
	###################################
	# |------- config script -------| #
	###################################
	type: data
	prefixes:
		main: "<&7>[<&d><&l>Display<&7>]"
	permissions:
		use-command: none
	settings:
		max-height: 4
		max-duration: 25
		default-cooldown: 10
		display-timeout: 10



# | ---------------------------------------------- DISPLAY ITEM | COMMANDS ---------------------------------------------- | #



display_item_command:
	####################################
	# |------- command script -------| #
	####################################
	type: command
	debug: false
	name: display
	description: Flag editor command.
	usage: /display
	aliases:
        - show
		- displayitem
        - showitem
	script:
		# |------- command data -------| #
		- ratelimit <player> 1t
		- define prefix <script[display_item_config].parsed_key[prefixes].get[main].if_null[null]>
		- define permission <script[display_item_config].data_key[permissions].get[use-command]>
		- define timeout <script[display_item_config].data_key[settings].get[display-timeout].if_null[null]>
		- define max_length <script[display_item_config].data_key[settings].get[max-duration].if_null[null]>
		- define max_height <script[display_item_config].data_key[settings].get[max-height].if_null[null]>
		- if ( <context.args.get[1]||null> == null ):
			- define duration <script[display_item_config].data_key[settings].get[default-cooldown].if_null[null]>
		- else:
			- define duration <context.args.get[1]>
		- if ( <player.gamemode> == survival ) || ( <player.gamemode> == creative ):
			# |------- permissions check -------| #
			- if ( <player.has_permission[<[permission]>].global> ) || ( <[permission]> == <empty> ) || ( <[permission]> == none ) || ( <[permission]> == null ):
				# |------- validate data -------| #
				- if ( not <player.has_flag[display_in_progress]> ) && ( not <player.has_flag[display_duration]> ):
					- if ( <[duration].is_integer> ) && ( <[duration]> != null ):
						- if ( <[duration]> <= <[max_length]> ):
							- flag <player> display_duration:<[duration]> expire:<[timeout]>s
							- define timeout <[timeout].mul_int[20]>
							- bossbar create id:display_item title:<&d>Display<&sp>Mode:<&sp><&sp><&a>Enabled progress:1 color:purple style:solid
						- else:
							- narrate "<[prefix]> <&f>The maximum <&b>duration <&f>allowed is <&b><[max_length]> <&f>seconds."
							- stop
					- else:
						- narrate "<[prefix]> <&f>Duration must be an <&b>integer <&f>for command <&b>/display."
						- stop
					# |------- select location -------| #
					- while ( true ):
						- if ( <player.has_flag[display_duration]> ) && ( <[loop_index]> <= <[timeout]> ):
							- define valid false
							- define location <player.cursor_on_solid[5].if_null[null]>
							- if ( <[location].equals[null]> ):
								- wait 1t
								- while next
							# |------- validate location -------| #
							- while ( true ):
								- if ( <[loop_index]> <= <[max_height]> ):
									- define above <[location].above>
									- if ( <[above].material> == <material[air]> ) || ( <[above].material> == <material[void_air]> ):
										- define valid true
										- while stop
									- else:
										- define location <[above]>
										- while next
								- else:
									- while stop
							# |------- display location -------| #
							- if ( <[valid]> ):
								- debugblock <[location].above> color:green alpha:0.75 d:2t
							- wait 1t
							- while next
						- else:
							- while stop
					# |------- command cleanup -------| #
					- bossbar remove id:display_item
				- else:
					- narrate "<[prefix]> <&c>You are already <&f>displaying <&c>an item."
					- stop
			- else:
				# |------- unauthorized -------| #
				- narrate "<[prefix]> <&c>You do not have permission to use the <&f>/<context.alias> <&c>command."
				- stop


# | ---------------------------------------------- DISPLAY ITEM | HANDLERS ---------------------------------------------- | #



display_item_handlers:
	###################################
	# |------- event handler -------| #
	###################################
    type: world
    debug: false
    events:
		##################################
		# |------- click events -------| #
		##################################
		on player flagged:display_duration clicks block:
			# |------- context data -------| #
			- ratelimit <player> 1t
			- define location <context.location.if_null[null]>
			- define item <player.item_in_hand.if_null[null]>
			- define duration <player.flag[display_duration].if_null[null]>
			- define max_height <script[display_item_config].data_key[settings].get[max-height].if_null[null]>
			# |------- validate location -------| #
			- if ( <[item]> != <item[air]> ) && ( <[item]> != null ) && ( <[location]> != null ):
				# | the 'display_block' flag prevents initial block placement | #
				- flag <player> display_block:true expire:2t
				- while ( true ):
					- if ( <[loop_index]> <= <[max_height]> ):
						- define above <[location].above>
						- if ( <[above].material> == <material[air]> ) || ( <[above].material> == <material[void_air]> ):
							- while stop
						- else:
							- define location <[above]>
							- while next
					- else:
						- stop
				# |------- display item -------| #
				- flag <player> display_in_progress:<[location]> expire:<[duration]>s
				- displayitem <[item]> <[location]> duration:<[duration]>s
			# |------- flag cleanup -------| #
			- if ( <player.has_flag[display_duration]> ):
				- flag <player> display_duration:!
		
		##################################
		# |------- place events -------| #
		##################################
		on player flagged:display_in_progress places block:
			# |------- prevent block place -------| #
			- if ( <player.has_flag[display_block]> ) || ( <player.flag[display_in_progress].above.if_null[null]> == <context.location> ):
				- determine cancelled



# | ------------------------------------------------------------------------------------------------------------------------------ | #


