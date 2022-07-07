


# | ----------------------------------------------  HTOOLS | UIX MANAGER  ---------------------------------------------- | #



htools_uix_manager:
    ####################################################################
    # | ----------------  |  Htools UIX Manager  |  ---------------- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  This script represents the main uix handler of this --- | #
    # | ---  denizen application. These scripts should only be   --- | #
    # | ---  edited if you intend to directly adjust sensitive   --- | #
    # | ---  reference data and tasks that affect the operation  --- | #
    # | ---  and functionality of subsequent gui scripts.        --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                      gui                       |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  When creating a 'gui-file', you must consider two   --- | #
    # | ---  separate, but equally important factors;            --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                   script-id                    |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  The 'script-id' is the actual script file name that --- | #
    # | ---  will contain various 'inventory-id'(s), typically   --- | #
    # | ---  found within the '/guis' directory.                 --- | #
    # | ---                                                      --- | #
    # | ---  A 'script-id' should not contain any spaces or      --- | #
    # | ---  delimiters besides an underscore.                   --- | #
    # | ---                                                      --- | #
    # | ---  A 'script-id' must start with the characters        --- | #
    # | ---  'citizens_editor_gui' and end with any 'unique-id'. --- | #
    # | ---                                                      --- | #
    # |--------------------------------------------------------------| #
    # | ---                       example                        --- | #
    # |--------------------------------------------------------------| #
    # | ---                                                      --- | #
    # | ---                      script-id                       --- | #
    # | ---    ______________________________________________    --- | #
    # | ---    |     'prefix'     |   'uuid'   | 'file.ext' |    --- | #
    # | ---    citizens_editor_gui_my_script_id.dsc              --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                  inventory-id                  |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  The 'inventory-id' is the unique name given to any  --- | #
    # | ---  inventory script within a valid 'script-id'.        --- | #
    # | ---                                                      --- | #
    # | ---  An 'inventory-id' should not contain any spaces or  --- | #
    # | ---  delimiters besides an underscore.                   --- | #
    # | ---                                                      --- | #
    # | ---  An 'inventory-id' must start with the characters    --- | #
    # | ---  'citizens_editor', contain a 'unique-id' and end    --- | #
    # | ---  with one of three unique keywords shown below.      --- | #
    # | ---                                                      --- | #
    # |--------------------------------------------------------------| #
    # | ---                       examples                       --- | #
    # |--------------------------------------------------------------| #
    # | ---                                                      --- | #
    # | ---                     inventory-id                     --- | #
    # | ---        _______________________________________       --- | #
    # | ---        |   'prefix'   |  'uuid'  | 'keyword' |       --- | #
    # | ---        citizens_editor_my_inv_id_root                --- | #
    # | ---        _______________________________________       --- | #
    # | ---        |   'prefix'   |  'uuid'  | 'keyword' |       --- | #
    # | ---        citizens_editor_my_inv_id_gui                 --- | #
    # | ---        _______________________________________       --- | #
    # | ---        |   'prefix'   |  'uuid'  | 'keyword' |       --- | #
    # | ---        citizens_editor_my_inv_id_page                --- | #
    # | ---                                                      --- | #
    # |--------------------------------------------------------------| #
    # | ---                       example                        --- | #
    # |--------------------------------------------------------------| #
    # | ---                                                      --- | #
    # | ---                 generated structure                  --- | #
    # | ---                _____________________                 --- | #
    # | ---                                                      --- | #
    # | ---                ast:                                  --- | #
    # | ---                  root-uid:                           --- | #
    # | ---                      gui-uid:                        --- | #
    # | ---                          - page-uid                  --- | #
    # | ---                      gui-uid:                        --- | #
    # | ---                          - page-uid                  --- | #
    # | ---                          - page-uid                  --- | #
    # | ---                          - page-uid                  --- | #
    # | ---                _____________________                 --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                      root                      |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  An 'inventory-id' suffixed with the 'root' keyword  --- | #
    # | ---  is interpreted as the 'root-id' of the 'gui-file'.  --- | #
    # | ---  The 'root-id' is referenced in various sections of  --- | #
    # | ---  the manager and is considered the top of the gui    --- | #
    # | ---  hierarchy. There should only ever be one 'root-id'  --- | #
    # | ---  amongst your 'inventory-id'(s) at any given time.   --- | #
    # | ---  If more than one 'inventory-id' is found to contain --- | #
    # | ---  the 'root' keyword, the queue will be cancelled and --- | #
    # | ---  the source will be notified.                        --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                      gui                       |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  An 'inventory-id' suffixed with the 'gui' keyword   --- | #
    # | ---  is interpreted as a valid 'gui-id' of the manager.  --- | #
    # | ---  The 'gui-id' is below the 'root-id' and above the   --- | #
    # | ---  'page-id' within the gui hierarchy.                 --- | #
    # | ---                                                      --- | #
    # | ---  There should only be one 'gui-id' per 'gui-file'.   --- | #
    # | ---  The 'gui-id' is interpreted as the root of the      --- | #
    # | ---  containing 'gui-file'. A valid 'gui-id' can store   --- | #
    # | ---  multiple 'page-id'(s) in the form of a list, that   --- | #
    # | ---  descends from the 'gui-id' container.               --- | #
    # | ---                                                      --- | #
    ####################################################################
    # | ---  |                      page                      |  --- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  An 'inventory-id' suffixed with the 'page' keyword  --- | #
    # | ---  is interpreted as a valid 'page-id' of the manager. --- | #
    # | ---  The 'page-id' is below the 'gui-id' and retains the --- | #
    # | ---  lowest position in the gui hierarchy.               --- | #
    # | ---                                                      --- | #
    # | ---  There can be multiple 'page-id'(s) per 'gui-file'.  --- | #
    # | ---  The 'page-id' is interpreted as a descendent of the --- | #
    # | ---  'gui-id' of any given 'gui-file'.                   --- | #
    # | ---                                                      --- | #
    # | ---  A valid 'page-id' is recognized and interpreted     --- | #
    # | ---  differently than any other 'id' in a 'gui-file'.    --- | #
    # | ---                                                      --- | #
    # | ---  A 'page-id' is a descendant of the most recent      --- | #
    # | ---  'gui-id' in the current working 'gui-file', and has --- | #
    # | ---  some special properties applied at the script's     --- | #
    # | ---  runtime. The first unique property of a 'page-id'   --- | #
    # | ---  is the ability to possess 'relatives'. A 'relative' --- | #
    # | ---  is any other 'page-id' that derives from the same   --- | #
    # | ---  'gui-id' of any given 'script-id'.                  --- | #
    # | ---                                                      --- | #
    ####################################################################
    type: world
    debug: true
    events:
	    ##################################################
        # | ---  |        manager events        |  --- | #
        ##################################################
        after custom event id:placeholder:
            - narrate placeholder



# | ----------------------------------------------  HTOOLS | MANAGER TASKS  ---------------------------------------------- | #



    build:
        ####################################################
        # | ---  |          manager task          |  --- | #
        ####################################################
        # | ---                                      --- | #
        # | ---  Required:  prefix                   --- | #
        # | ---                                      --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- build data structures -------| #
        - foreach <server.scripts> as:script:
            - define file-name <[script].relative_filename.after_last[/].before_last[.]>
            - if ( <[script].contains_text[citizens_editor]> ) && ( <[script].ends_with[root]> ):
                - define root-id <[script].name.after[citizens_editor_].before_last[_root].replace_text[_].with[-]>
            - else if ( <[script].contains_text[citizens_editor]> ) && ( <[script].ends_with[gui]> || <[script].ends_with[page]> ):
                - define <[file-name]>:->:<[script].name.after[citizens_editor_]>
        # |------- define root-id -------| #
        - if ( <[root-id].exists> ):
            - define <[ast]>.<[root-id]>: <empty>
        - else:
            - narrate "<[prefix]> <&c>Missing <&f>root-id<&c>: '<&f>htools.uix.manager<&c>' exited."
            - stop
        # |------- build abstract syntax tree -------| #
        - foreach <queue.definitions> as:definition:
            - if ( <[definition].contains_text[citizens_editor]> ) && ( <[definition].contains_text[gui]> ):
                - define page-ids <definition[<[definition]>]>
                - foreach <[page-ids]> as:inventory-id:
                    - if ( <[inventory-id].ends_with[gui]> ):
                        - define gui-id <[inventory-id].before_last[_gui].replace_text[_].with[-]>
                        - define page-ids:<-:<[inventory-id]>
                    - else if ( <[inventory-id].ends_with[page]> ):
                        - define page-ids:<-:<[inventory-id]>
                        - define page-ids:->:<[inventory-id].before_last[_page].replace_text[_].with[-]>
                - if ( <[gui-id].exists> ):
                    - define ast.<[root-id]>.<[gui-id]>:<[page-ids]>
                - else:
                    - narrate "<[prefix]> <&c>Missing <&f>root-id <&c>for: '<&f><[definition]>.dsc<&c>' - did you forget to include '<&f>gui' at the end of your inventory <&f>script-id<&c>?"
                    - foreach next
        # |------- store ast -------| #
        - flag server citizens_editor.ast:<[ast]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open:
        ####################################################
        # | ---  |          manager task          |  --- | #
        ####################################################
        # | ---                                      --- | #
        # | ---  Required:  prefix | gui-id          --- | #
        # | ---                                      --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- application data -------| #
        - define root <server.flag[citizens_editor.ast].keys.first>-gui
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
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[false]>]>
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
            # |---------------------------------------------| #
            # | ---  Open and set the 'target' gui-id.  --- | #
            # |---------------------------------------------| #
            - flag <player> citizens_editor.gui.current:<[gui-id]>
            - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
            - inventory open destination:<[gui-id]>
            # |---------------------------------------------------------| #
            # | ---  Set and validate the current working 'cache'.  --- | #
            # |---------------------------------------------------------| #
            - define cache-id citizens_editor.gui.next
            - inject <script.name> path:validate_cache

        - if ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
            # |------- debug output -------| #
            - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
            - narrate "Next: <player.flag[citizens_editor.gui.next]>"
            - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open_previous:
        ####################################################
        # | ---  |          manager task          |  --- | #
        ####################################################
        # | ---                                      --- | #
        # | ---  Required:  prefix | gui-id          --- | #
        # | ---                                      --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- app data -------| #
        - define root <server.flag[citizens_editor.ast].keys.first>-gui
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

        - if ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
            # |------- debug output -------| #
            - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
            - narrate "Next: <player.flag[citizens_editor.gui.next]>"
            - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open_next:
        ####################################################
        # | ---  |          manager task          |  --- | #
        ####################################################
        # | ---                                      --- | #
        # | ---  Required:  prefix | gui-id          --- | #
        # | ---                                      --- | #
        ####################################################
        - ratelimit <player> 1t
        # |------- app data -------| #
        - define root <server.flag[citizens_editor.ast].keys.first>-gui
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

        - if ( <player.flag[citizens_editor.debug_mode].if_null[false]> ):
            # |------- debug output -------| #
            - narrate "<&nl>Current: <player.flag[citizens_editor.gui.current]>"
            - narrate "Next: <player.flag[citizens_editor.gui.next]>"
            - narrate "Previous: <player.flag[citizens_editor.gui.previous]><&nl>"



# | ------------------------------------------------------------------------------------------------------------------------------ | #


    validate_cache:
        ######################################################
        # | ---  |           manager task           |  --- | #
        ######################################################
        # | ---                                        --- | #
        # | ---  Required:  prefix | root | cache-id   --- | #
        # | ---                                        --- | #
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
            - define group <server.flag[citizens_editor.ast.<[root].before[-gui]>.<[parent]>].if_null[<list[empty]>]>
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
        # | ---  |          manager task          |  --- | #
        ####################################################
        # | ---                                      --- | #
        # | ---  Required:  prefix | gui-id          --- | #
        # | ---                                      --- | #
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
        - define root-node <server.flag[citizens_editor.ast].keys.first>
        - define ast <server.flag[citizens_editor.ast.<[root-node]>]||null>
        - define inventories citizens_editor.inventories
        - if ( <[ast]> != null ):
            - if ( <[root-node]> == <[gui-id].before[-gui]> ):
                # |------- set inventory-id -------| #
                    - define inventory "<inventory[citizens_editor_<[gui-id].replace_text[gui].with[root].replace_text[-].with[_]>].if_null[<inventory[citizens editor <[gui-id].replace_text[gui].with[root].replace_text[-].with[<&sp>]>].if_null[null]>]>"
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
                            - narrate "<[prefix]> <&c>The inventory '<&f><[gui-id]><&c>' is not properly cached within the inventories database."
                        - goto end
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
                            - narrate "<[prefix]> <&c>The inventory '<&f><[gui-id]><&c>' is not properly cached within the inventories database."
                        - foreach stop
        - else:
            - narrate "<[prefix]> <&c>Missing root '<&f><[gui-id]><&c>' in application uix syntax tree."
        - mark end
        # |------- reset gui-id -------| #
        - if ( <[cached-gui].exists> ):
            - define gui-id <[cached-gui]>



# | ------------------------------------------------------------------------------------------------------------------------------ | #


