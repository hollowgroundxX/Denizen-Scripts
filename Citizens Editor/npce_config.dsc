# + ------------------------------------------------------------------------------------------------------------------ +
# |
# |  Htools -> Citizens Editor
# |
# + ------------------------------------------------------------------------------------------------------------------ +
#
#
# @author HollowTheSilver
# @date 2022/06/08
# @denizen-build REL-1751 or DEV-5882
# @script-version 1.0.7
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Description:
# - A complete gui based citizens npc editor.
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Installation:
# - Upload the script into your 'scripts' directory and reload denizen with /ex reload.
#
# Help:
# - Type command "/npcedit help" to get usage info in-game.
#
# Permissions:
# - Use command: htools.npc_editor.use
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
# - /npcedit
#
# Context 2:
# - /npcedit debug (toggle)
#
#
# | ---------------------------------------------- CITIZENS EDITOR | DATA --------------------------------------------- | #



citizens_editor_config:
	############################################
	# |------- citizens editor config -------| #
	############################################
	type: data
	prefixes:
		main: "<&7>[<&d><&l>NpcEditor<&7>]"
		debug: "<&7>[<&b>Debug<&7>]"
		proximity: "<&7>[<&b><&l>NPC.<npc.id.if_null[null]><&7>]"
	permissions:
		use-command: htools.npc_editor.use
	gui:
		corner-material: white_stained_glass_pane
		edge-material: purple_stained_glass_pane
	interrupt:
		settings:
			# | ---  This value represents the delay in-between interrupt proximity updates.  --- | #
			# | ---  Adjust this setting if your server in behind on ticks (laggy) and is     --- | #
			# | ---  having trouble syncing interrupt data with proximity events.             --- | #
			# | ---  t = ticks | s = seconds | none = seconds                                 --- | #
			interrupt-delay: 5t
		fishermen:
			# | ---  This value represents the amount of 'seconds' it takes to finalize the  --- | #
			# | ---  fishing location selection process. This is determined only in seconds  --- | #
			# | ---  and does accept a suffix of 's' or 't'.                                 --- | #
			select-location-timeout: 10
		navigating:
			placeholder: null
		scripts:
			# | ---  additional dependency scripts  --- | #
			- null



# | ------------------------------------------------------------------------------------------------------------------------------ | #


