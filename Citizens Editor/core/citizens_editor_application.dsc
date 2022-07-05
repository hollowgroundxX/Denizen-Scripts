


# | ----------------------------------------------  CITIZENS EDITOR | APPLICATION  --------------------------------------------- | #



citizens_editor_application:
    #####################################################################################
	# |-----------------------------  Htools Application  ----------------------------| #
	#####################################################################################
	# | ---																		  --- | #
	# | ---   This script represents the main application handler of an Htools    --- | #
	# | ---   denizen script. This script should only be edited if you intend to  --- | #
    # | ---	  directly adjust sensitive reference data that directly effects the  --- | #
    # | ---	  functionality of subsequent inventory scripts.                      --- | #
    # | ---																		  --- | #
	#####################################################################################
    type: custom
    tags:
        get_ast:
            - determine <script.data_key[abstract-syntax-tree]>
        get_root:
            - determine <script.data_key[abstract-syntax-tree].keys.first>-gui
    data:
        placeholder: placeholder
    ####################################################################
    # | ---  |              Abstract Syntax Tree              |  --- | #
    ####################################################################
    # | ---  		                                             --- | #
    # | ---  This data structure represents the main application --- | #
    # | ---  hierarchy that influences various behaviors of the  --- | #
    # | ---  gui script events. This data structure must follow  --- | #
    # | ---  an intended format that's detailed below. Any and   --- | #
    # | ---  all other inventory detailed logic should be within --- | #
    # | ---  the individual 'gui.dsc' scripts directly rather    --- | #
    # | ---  than the abstract syntax tree below.                --- | #
    # | ---  		                                             --- | #
    ####################################################################
    abstract-syntax-tree:
        main-menu:
            - <empty>
        skin-editor:
            - skin
        profile-editor:
            - profile
        settings:
            - permissions
            - prefixes
            - interrupt
            - profiles
            - gui
        dialog:
            - <empty>
    ####################################################################
    # | ---  |                 Data Structure                 |  --- | #
    ####################################################################
    # | ---														 --- | #
    # | ---														 --- | #
    # | ---			ROOT-ID:                                     --- | #
    # | ---														 --- | #
    # | ---				GUI-ID:                                  --- | #
    # | ---														 --- | #
    # | ---					- PAGE-ID-1							 --- | #
    # | ---  		                                             --- | #
    # | ---					- PAGE-ID-2							 --- | #
    # | ---														 --- | #
    # | ---					- PAGE-ID-3							 --- | #
    # | ---														 --- | #
    # | ---  		                                             --- | #
    ####################################################################
    # | ---  |                     root-id                    |  --- | #
    ####################################################################
    # | ---														 --- | #
    # | ---  The first 'gui-id' in the data structure is         --- | #
    # | ---  interpreted as the 'root' node, and the 'node'(s)   --- | #
    # | ---  contained will be recognized as valid 'gui-id'(s).  --- | #
    # | ---  This 'root-id' represents the initial or "main"     --- | #
    # | ---  inventory of the application, and will be the very  --- | #
    # | ---  first inventory displayed on command execution.     --- | #
    # | ---  		                                             --- | #
    ####################################################################
    # | ---  |                     gui-id                     |  --- | #
    ####################################################################
    # | ---														 --- | #
    # | ---  A 'unique-id' that matches a registered inventory   --- | #
    # | ---  'script-id'. This 'unique-id' should not contain    --- | #
    # | ---  any spaces and only be deliminated by a dash '-'.   --- | #
    # | ---  		                                             --- | #
    # | ---  This 'gui-id' should be a list that contains unique --- | #
    # | ---  'page-id'(s) that matches a registered inventory    --- | #
    # | ---  'script-id'. A 'gui-id' that doesn't contain any    --- | #
    # | ---  pages should be listed as '<empty>' or 'null'.      --- | #
    # | ---  		                                             --- | #
    # | ---  The formatting for an 'inventory-id' containing a   --- | #
    # | ---  'gui-id' should be prefixed with 'citizens_editor'  --- | #
    # | ---  and suffixed with '_gui'. This 'inventory-id' must  --- | #
    # | ---  be a registered inventory 'script-id' contained in  --- | #
    # | ---  the /guis directory.                                --- | #
    # | ---														 --- | #
    # |--------------------------------------------------------------| #
    # | ---                        example                       --- | #
    # |--------------------------------------------------------------| #
    # | ---														 --- | #
    # | ---  		                                             --- | #
    # | ---                        gui-id                        --- | #
    # | ---                    ______________                    --- | #
    # | ---                    |  'gui-id'  |                    --- | #
    # | ---  	               profile-editor                    --- | #
    # | ---  		                                             --- | #
    # | ---                     inventory-id                     --- | #
    # | ---      ___________________________________________     --- | #
    # | ---      |   'prefix'   |   'gui-id'   |  'suffix' |     --- | #
    # | ---  	 citizens_editor_profile_editor_gui              --- | #
    # | ---  		                                             --- | #
    # | ---														 --- | #
    ####################################################################
    # | ---  |                    page-id                     |  --- | #
    ####################################################################
    # | ---  		                                             --- | #
    # | ---  A 'unique-id' that matches a registered inventory   --- | #
    # | ---  'script-id'. This 'unique-id' should not contain    --- | #
    # | ---  any spaces and only be deliminated by a dash '-'.   --- | #
    # | ---  		                                             --- | #
    # | ---  This 'page-id' will be recognized and interpreted   --- | #
    # | ---  differently than a 'gui-id' data node. A 'page-id'  --- | #
    # | ---  is a descendant of the most recent 'gui-id' in the  --- | #
    # | ---  data tree, and has some special properties applied  --- | #
    # | ---  at the script's runtime. The first unique property  --- | #
    # | ---  of a 'page-id' is possessing potential 'relatives'. --- | #
    # | ---  A 'relative' is any other 'page-id' that derives    --- | #
    # | ---  from the same 'gui-id'.                             --- | #
    # | ---  		                                             --- | #
    # | ---  The formatting for an 'inventory-id' containing a   --- | #
    # | ---  'page-id' should be prefixed with 'citizens_editor' --- | #
    # | ---  and suffixed with '_page'. This 'inventory-id' must --- | #
    # | ---  be a registered inventory 'script-id' contained in  --- | #
    # | ---  the /guis directory.                                --- | #
    # | ---														 --- | #
    # |--------------------------------------------------------------| #
    # | ---                       example                        --- | #
    # |--------------------------------------------------------------| #
    # | ---  		                                             --- | #
    # | ---														 --- | #
    # | ---                       page-id                        --- | #
    # | ---                    _____________                     --- | #
    # | ---                    | 'page-id' |                     --- | #
    # | ---  	                permissions                      --- | #
    # | ---  		                                             --- | #
    # | ---                    inventory-id                      --- | #
    # | ---       ________________________________________       --- | #
    # | ---       |  'prefix'  |  'page-id'  |  'suffix' |       --- | #
    # | ---  	  citizens_editor_permissions_page               --- | #
    # | ---														 --- | #
    # | ---  		                                             --- | #
    ####################################################################
    # | ---  |                  inventory-id                  |  --- | #
    ####################################################################
    # | ---														 --- | #
    # | ---  The concept of prefixes and suffixes such as 'gui'  --- | #
    # | ---  and 'page' applies only to an inventory 'script-id' --- | #
    # | ---  , and is required to be recognized as valid by the  --- | #
    # | ---  syntax tree and other relevant scripts.             --- | #
    # | ---  		                                             --- | #
    # | ---  The autofilled suffix applied to these 'id'(s) is   --- | #
    # | ---  determined completely on the suffix found within    --- | #
    # | ---  the valid registered inventory 'script-id'.         --- | #
    # | ---  		                                             --- | #
    # | ---  A valid 'gui-id' will automatically be interpreted  --- | #
    # | ---  with a suffix of '-gui' when being proccessed by    --- | #
    # | ---  the ast. Similarly, a valid 'page-id' will also be  --- | #
    # | ---  automatically interpreted, but with a suffix of     --- | #
    # | ---  '-page' instead. This means if you include the      --- | #
    # | ---  characters '-gui' to any 'gui-id', it will be saved --- | #
    # | ---  as '<id>-gui-gui' in any relevant data caches, like --- | #
    # | ---  the pagination caches used throughout the script.   --- | #
    # | ---  		                                             --- | #
    ####################################################################



# | ----------------------------------------------  CITIZENS EDITOR | APPLICATION HANDLER  ---------------------------------------------- | #



citizens_editor_gui_handler:
    type: world
    debug: true
    events:
		###################################################
        # | ---  |        presence events        |  --- | #
        ###################################################
        after custom event id:placeholder:
            - narrate placeholder



# | ----------------------------------------------  CITIZENS EDITOR | APPLICATION TASKS  ---------------------------------------------- | #



    open_inventory:
        ####################################################
        # | ---  |            gui task            |  --- | #
        ####################################################
		# | ---										 --- | #
        # | ---  Required:  prefix | gui-id          --- | #
		# | ---										 --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- application data -------| #
        - define root <custom_object[citizens_editor_application].get_root>
        - define blacklist <list[dialog-gui]>
        # |------- default target -------| #
        - if ( not <[gui-id].exists> ):
            - define gui-id <[root]>
        # |------- inventory data -------| #
        - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
        - define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
        # |------- authentication check -------| #
        - if ( <[flagged]> ) && ( <[noted]> ):
            - define validated true
        - else:
            # |------- validate inventory -------| #
            - inject <script.name> path:validate_inventory
            # |------- redefine inventory data -------| #
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
            - define flagged <server.flag[citizens_editor.inventories].contains[<[gui-id]>]>
            # |------- authentication re-check -------| #
            - if ( <[flagged]> ) && ( <[noted]> ):
                - define validated true
        # |------- validation check -------| #
        - if ( <[validated].if_null[false]> ):
            # |-----------------------------------------------------------| #
            # | ---  If the 'current' gui-id is the root, clear the   --- | #
            # | ---  'next-cache'. This block resets the 'next-cache' --- | #
            # | ---  when starting from a new parent gui.             --- | #
            # |-----------------------------------------------------------| #
            - if ( <player.flag[citizens_editor.gui.current].if_null[<[root]>]> == <[root]> ):
                - flag <player> citizens_editor.gui.next:!|:<list[<empty>]>
            # |------- navigation data -------| #
            - define current <player.flag[citizens_editor.gui.current].if_null[<[root]>]>
            - define next <player.flag[citizens_editor.gui.next].if_null[<list[<empty>]>]>
            - define previous <player.flag[citizens_editor.gui.previous].if_null[<list[<empty>]>]>
            # |--------------------------------------------------| #
            # | ---  This if block prevents the 'root' from  --- | #
            # | ---  adding itself to the 'next-cache'.      --- | #
            # |--------------------------------------------------| #
            - if ( <[current]> != <[root]> ):
                - if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
                    # |---------------------------------------------------------| #
                    # | ---  Add the 'current' gui-id to the 'next-cache',  --- | #
                    # | ---  to be later utilized by the 'next_page' task.  --- | #
                    # |---------------------------------------------------------| #
                    - flag <player> citizens_editor.gui.next:->:<[current]>
            # |---------------------------------------------------------| #
            # | ---  This if block prevents the 'root' from adding  --- | #
            # | ---  itself to the 'previous-cache' at the first    --- | #
            # | ---  instantiation of the 'root' gui-id.            --- | #
            # |---------------------------------------------------------| #
            - if ( <[gui-id]> != <[root]> ):
                - if ( not <[previous].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
                    # |-------------------------------------------------------------| #
                    # | ---  Add the 'current' gui-id to the 'previous-cache',  --- | #
                    # | ---  to be later utilized by the 'previous_page' task.  --- | #
                    # |-------------------------------------------------------------| #
                    - flag <player> citizens_editor.gui.previous:->:<[current]>
            - else:
                - if not ( <player.has_flag[citizens_editor.gui.previous]> ):
                    - flag <player> citizens_editor.gui.previous:!|:<list[<empty>]>
            # |---------------------------------------------| #
            # | ---  Open and set the 'target' gui-id.  --- | #
            # |---------------------------------------------| #
            - flag <player> citizens_editor.gui.current:<[gui-id]>
            - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
            - inventory open destination:<[gui-id]>
            # |----------------------------------------------------------| #
            # | ---  This block prevents the 'root' and blacklisted  --- | #
            # | ---  from adding themselves to the 'next-cache'.     --- | #
            # |----------------------------------------------------------| #
            - if ( <[gui-id]> != <[root]> ) && ( not <[blacklist].contains[<[gui-id]>]> ):
                - if ( not <[next].contains[<[gui-id]>]> ):
                    # |--------------------------------------------------------| #
                    # | ---  Add the 'target' gui-id to the 'next-cache',  --- | #
                    # | ---  to be later utilized by the 'next_page' task. --- | #
                    # |--------------------------------------------------------| #
                    - flag <player> citizens_editor.gui.next:->:<[gui-id]>
            # |---------------------------------------------------------| #
            # | ---  Set and validate the current working 'cache'.  --- | #
            # |---------------------------------------------------------| #
            - define cache-id citizens_editor.gui.next
            - inject <script.name> path:validate_cache

        # |------- debug output -------| #
        - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
        - narrate "Next: <player.flag[citizens_editor.gui.next]>"
        - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open_previous_inventory:
        ####################################################
        # | ---  |            gui task            |  --- | #
        ####################################################
		# | ---										 --- | #
        # | ---  Required:  prefix | gui-id          --- | #
		# | ---										 --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- app data -------| #
        - define root <custom_object[citizens_editor_application].get_root>
        - define blacklist <list[dialog-gui]>
        # |------- navigation data -------| #
        - define current <player.flag[citizens_editor.gui.current]>
        - define next <player.flag[citizens_editor.gui.next]>
        - define previous <player.flag[citizens_editor.gui.previous]>
        # |------- check context -------| #
        - choose <[gui-id]>:
            - case previous-page:
                # |------------------------------------------------------------------| #
                # | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
                # |------------------------------------------------------------------| #
                - if ( <[previous].contains[<[current]>]> ):
                    - flag <player> citizens_editor.gui.previous:<-:<[current]>
                # |--------------------------------------------------------------------| #
                # | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
                # | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
                # |--------------------------------------------------------------------| #
                - if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
                    # |---------------------------------------------------------| #
                    # | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
                    # |---------------------------------------------------------| #
                    - if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:->:<[current]>
                    # |----------------------------------------------------| #
                    # | ---  Define the 'target' gui-id to the latest  --- | #
                    # | ---  gui-id from the 'previous-cache'.         --- | #
                    # |----------------------------------------------------| #
                    - define gui-id <player.flag[citizens_editor.gui.previous].last>
                    # |-----------------------------------------------------------------| #
                    # | ---  Remove the 'target' gui-id from the 'previous-cache'.  --- | #
                    # |-----------------------------------------------------------------| #
                    - if ( <[previous].contains[<[gui-id]>]> ):
                        - flag <player> citizens_editor.gui.previous:<-:<[gui-id]>
                    # |-------------------------------------------------------| #
                    # | ---  Open and set the 'target' gui-id inventory.  --- | #
                    # |-------------------------------------------------------| #
                    - flag <player> citizens_editor.gui.current:<[gui-id]>
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                    - inventory open destination:<[gui-id]>
                - else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
                    # |-----------------------------------------------------------| #
                    # | ---  The 'previous-cache' is empty. Close inventory.  --- | #
                    # |-----------------------------------------------------------| #
                    - inventory close
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                    - flag <player> citizens_editor.gui.next:<list[<empty>]>
                    - flag <player> citizens_editor.gui.current:null
                - else:
                    # |-----------------------------------------------------------| #
                    # | ---  The 'current' and 'target' gui-id are identical. --- | #
                    # |-----------------------------------------------------------| #
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
            - case previous-page-2:
                # |------------------------------------------------------------------| #
                # | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
                # |------------------------------------------------------------------| #
                - if ( <[previous].contains[<[current]>]> ):
                    - flag <player> citizens_editor.gui.previous:<-:<[current]>
                # |--------------------------------------------------------------------| #
                # | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
                # | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
                # |--------------------------------------------------------------------| #
                - if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
                    # |---------------------------------------------------------| #
                    # | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
                    # |---------------------------------------------------------| #
                    - if ( <[next].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.next:<-:<[current]>
                    # |----------------------------------------------------| #
                    # | ---  Define the 'target' gui-id to the latest  --- | #
                    # | ---  gui-id from the 'previous-cache'.         --- | #
                    # |----------------------------------------------------| #
                    - define gui-id <player.flag[citizens_editor.gui.previous].last>
                    # |----------------------------------------------------| #
                    # | ---  Define the next 'target' gui-id to the    --- | #
                    # | ---  latest gui-id from the 'previous-cache'.  --- | #
                    # |----------------------------------------------------| #
                    - define gui-id-after <player.flag[citizens_editor.gui.previous].exclude[<[gui-id]>].last>
                    # |------------------------------------------------------------| #
                    # | ---  Remove the 'target' gui-id from the 'next-cache'  --- | #
                    # | ---  and 'previous-cache'.                             --- | #
                    # |------------------------------------------------------------| #
                    - if ( <[next].contains[<[gui-id]>]> ):
                        - flag <player> citizens_editor.gui.next:<-:<[gui-id]>
                    - if ( <[previous].contains[<[gui-id]>]> ):
                        - flag <player> citizens_editor.gui.previous:<-:<[gui-id]>
                    # |----------------------------------------------------------------| #
                    # | ---  Remove the 'after' gui-id from the 'previous-cache'.  --- | #
                    # |----------------------------------------------------------------| #
                    - if ( <[previous].contains[<[gui-id-after]>]> ):
                        - flag <player> citizens_editor.gui.previous:<-:<[gui-id-after]>
                    # |------------------------------------------------------| #
                    # | ---  Open and set the 'after' gui-id inventory.  --- | #
                    # |------------------------------------------------------| #
                    - flag <player> citizens_editor.gui.current:<[gui-id-after]>
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                    - inventory open destination:<[gui-id-after]>
                - else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
                    # |-----------------------------------------------------------| #
                    # | ---  The 'previous-cache' is empty. Close inventory.  --- | #
                    # |-----------------------------------------------------------| #
                    - inventory close
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                    - flag <player> citizens_editor.gui.next:<list[<empty>]>
                    - flag <player> citizens_editor.gui.current:null
                - else:
                    # |-----------------------------------------------------------| #
                    # | ---  The 'current' and 'target' gui-id are identical. --- | #
                    # |-----------------------------------------------------------| #
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1

        # |------- debug output -------| #
        - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
        - narrate "Next: <player.flag[citizens_editor.gui.next]>"
        - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open_next_inventory:
        ####################################################
        # | ---  |            gui task            |  --- | #
        ####################################################
		# | ---										 --- | #
        # | ---  Required:  prefix | gui-id          --- | #
		# | ---										 --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- app data -------| #
        - define root <custom_object[citizens_editor_application].get_root>
        - define blacklist <list[dialog-gui]>
        # |------- navigation data -------| #
        - define current <player.flag[citizens_editor.gui.current]>
        - define next <player.flag[citizens_editor.gui.next]>
        - define previous <player.flag[citizens_editor.gui.previous]>
        # |------- check context -------| #
        - choose <[gui-id]>:
            - case next-page:
                # |----------------------------------------------------------------| #
                # | ---  Ensure the 'target' gui-id entry in the 'next-cache'  --- | #
                # | ---  exists, and doesn't match the 'current' gui-id.       --- | #
                # |----------------------------------------------------------------| #
                - if ( <[current]> != <[next].last.if_null[null]> ) && ( <[next].last.exists> ):
                    # |------- add to previous-cache -------| #
                    - if ( not <[previous].contains[<[current]>]> ):
                        - flag <player> citizens_editor.gui.previous:->:<[current]>
                    # |------- next-cache data -------| #
                    - if ( <[current]> == <[root]> ):
                        - define gui-id <player.flag[citizens_editor.gui.next].first>
                    - else:
                        - define gui-id <player.flag[citizens_editor.gui.next].last>
                    # |------- open next-cached -------| #
                    - flag <player> citizens_editor.gui.current:<[gui-id]>
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                    - inventory open destination:<[gui-id]>
                - else:
                    # |------- end cache -------| #
                    - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1

        # |------- debug output -------| #
        - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
        - narrate "Next: <player.flag[citizens_editor.gui.next]>"
        - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #


    validate_cache:
        ######################################################
        # | ---  |             gui task             |  --- | #
        ######################################################
        # | ---										   --- | #
        # | ---  Required:  prefix | root | cache-id   --- | #
        # | ---										   --- | #
        ######################################################
        - ratelimit <player> 1t
        - if ( <player.flag[citizens_editor.gui.current].ends_with[-page]> ):
            - define current <player.flag[citizens_editor.gui.current].before[-page]>
            # |-------------------------------------------------------------| #
            # | ---  Get the last 'parent' gui-id from the 'cache' and  --- | #
            # | ---  list every 'relative' of the 'current' gui-id.     --- | #
            # |-------------------------------------------------------------| #
            - define cache <player.flag[<[cache-id]>]>
            - define parent <[cache].get[<[cache].find_all_partial[-gui].last>].before[-gui].if_null[null]>
            - define group <server.flag[citizens_editor.ast.<[parent]>].if_null[<list[empty]>]>
            - define relative <[cache].last.if_null[null]>
            # |------------------------------------------------------------| #
            # | ---  Remove any 'related' gui-ids from the 'cache' to  --- | #
            # | ---  ensure the 'current' gui-id is the last item in   --- | #
            # | ---  the 'cache', following the 'parent' gui-id.       --- | #
            # |------------------------------------------------------------| #
            - if ( <[parent]>-gui != <[root]> ) && ( <[group]> contains <[current]> ) && ( <[cache]> contains <[relative]> ):
                - foreach <[group].exclude[<[current]>]> as:related:
                    - if ( <[cache]> contains <[related]>-page ):
                        - flag <player> <[cache-id]>:<-:<[related]>-page



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    validate_inventory:
        ####################################################
        # | ---  |            gui task            |  --- | #
        ####################################################
        # | ---										 --- | #
        # | ---  Required:  prefix | gui-id          --- | #
        # | ---										 --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- default target -------| #
        - if ( not <[gui-id].exists> ):
            - define gui-id <player.flag[citizens_editor.gui.current]>
        - else if ( <[gui-id]> == previous-page ):
            - define cached-gui <[gui-id]>
            - define gui-id <player.flag[citizens_editor.gui.previous].last>
        - else if ( <[gui-id]> == previous-page-2 ):
            - define cached-gui <[gui-id]>
            - define last <player.flag[citizens_editor.gui.previous].last>
            - define gui-id <player.flag[citizens_editor.gui.previous].exclude[<[last]>].last>
        - else if ( <[gui-id].exists> ):
            - define cached-gui <[gui-id]>
            - define gui-id <[gui-id]>
        # |------- inventory data -------| #
        - define ast <server.flag[citizens_editor.ast].if_null[null]>
        - define inventories citizens_editor.inventories
        - if ( <[ast]> != null ):
            # |------- build inventory -------| #
            - foreach <[ast]> key:parent-id as:pages:
                - if ( <[parent-id]> == <[gui-id].before[-gui]> ) || ( <[pages].contains[<[gui-id].before[-page]>]> ):
                    # |------- set inventory-id -------| #
                    - define inventory "<inventory[citizens_editor_<[gui-id].replace_text[-].with[_]>].if_null[<inventory[citizens editor <[gui-id].replace_text[-].with[<&sp>]>].if_null[null]>]>"
                    # |------- refresh inventory -------| #
                    - if ( <[inventory]> != null ):
                        # |------- cached data -------| #
                        - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[false]>]>
                        - define flagged <server.flag[<[inventories]>].contains[<[gui-id]>].if_null[false]>
                        # |------- presence check -------| #
                        - if ( <[flagged]> ) && ( <[noted]> ):
                            # |------- delete inventory -------| #
                            - note remove as:<[gui-id]>
                            # |------- create inventory -------| #
                            - note <[inventory]> as:<[gui-id]>
                        - else if ( not <[flagged]> ) && ( not <[noted]> ):
                            # |------- create inventory -------| #
                            - note <[inventory]> as:<[gui-id]>
                            - flag server <[inventories]>:->:<[gui-id]>
                            # |------- log message -------| #
                            - narrate "<[prefix]> Inventory.<[gui-id]> successfully cached."
                        - else:
                            # |------- invalid inventory -------| #
                            - narrate "<[prefix]> <&c>The inventory '<[gui-id]>' is not properly cached within the inventories database."
                        - foreach stop
        # |------- reset gui-id -------| #
        - if ( <[cached-gui].exists> ):
            - define gui-id <[cached-gui]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #


