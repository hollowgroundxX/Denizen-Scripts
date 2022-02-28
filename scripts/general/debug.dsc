

# | ---------------------------------------------- DEBUG | COMMANDS ---------------------------------------------- | #


list_flags:
	type: command
	debug: false
	name: listflags
	script:		
		- narrate "<server.list_flags>"
		- narrate "<player.list_flags>"


flag_test:
	type: command
	debug: false
	name: resetflags
	script:
		#################################
		# |------- check flags -------| #
		#################################
		- if not ( <player.has_flag[public_flags]> ):
			- flag <player> public_flags:!|:li@flag_editor|flag_proximity
		- if not ( <server.has_flag[public_flags]> ):
			- flag server public_flags:!|:li@
		
		- if not ( <player.has_flag[private_flags]> ):
			- flag <player> private_flags:!|:li@public_flags|private_flags|fragile_flags
		- if not ( <server.has_flag[private_flags]> ):
			- flag server private_flags:!|:li@public_flags|private_flags|fragile_flags
		
		- if not ( <player.has_flag[fragile_flags]> ):
			- flag <player> fragile_flags:!|:li@
		- if not ( <server.has_flag[fragile_flags]> ):
			- flag server fragile_flags:!|:li@
		
		
		
		################################
		# |------- delete old -------| #
		################################
		- if ( <player.has_flag[[flag]]> ):
			- flag <player> [flag]:!
		- if ( <server.has_flag[[flag]]> ):
			- flag server [flag]:!
		
		- if ( <player.has_flag[test]> ):
			- flag <player> test:!
		- if ( <server.has_flag[test]> ):
			- flag server test:!
		
		- if ( <player.has_flag[testing]> ):
			- flag <player> testing:!
		- if ( <server.has_flag[testing]> ):
			- flag server testing:!
		
		- if ( <player.has_flag[sign_prompt]> ):
			- flag <player> sign_prompt:!
		- if ( <server.has_flag[sign_prompt]> ):
			- flag server sign_prompt:!
		
		- if ( <player.has_flag[flags_public]> ):
			- flag <player> flags_public:!
		- if ( <server.has_flag[flags_public]> ):
			- flag server flags_public:!
		
		- if ( <player.has_flag[flags_private]> ):
			- flag <player> flags_private:!
		- if ( <server.has_flag[flags_private]> ):
			- flag server flags_private:!
		
		- if ( <player.has_flag[flags_fragile]> ):
			- flag <player> flags_fragile:!
		- if ( <server.has_flag[flags_fragile]> ):
			- flag server flags_fragile:!



# | ------------------------------------------------------------------------------------------------------------------------------ | #

