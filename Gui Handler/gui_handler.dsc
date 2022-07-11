# + ------------------------------------------------------------------------------------------------------------------ +
# |
# |  Gui Handler - Denizen Library
# |
# + ------------------------------------------------------------------------------------------------------------------ +
#
#
# @Htools               LLC
# @author               HollowTheSilver
# @date                 07/11/2022
# @script-version       DEV-1.0.1
# @denizen-build-1.2.4  REL-1771
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Description:
# - A denizen library designed to handle multiple graphical user interfaces and manage uix back-end tasks.
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Installation:
# - Upload the 'Gui Handler' folder into your 'scripts' directory and reload denizen with /ex reload.
#
# Help:
# - For library documentation please visit: https://htools/gui-handler/docs (coming soon)
#
#
# ------------------------------------------------------------------------------------------------------------------ +
#
#
# Usage:
# - A denizen library is a script, or collection of script(s), that is utilized as a local api for any denizen project.
#
# Summary:
# - This library creates a simple snapshot of your denizen script (application), then registers the application with the
# - gui handler's manager. Once registered, you can utilize the library to create any number of inventory scripts using the
# - various handler uix tasks. This delegates all back-end logic to the handler, including more complicated processes such
# - as pagination and hierarchy, rather than requiring the implementation of these design patterns directly.
#
# - This library can simultaneously manage multiple graphical user interface applications with a single installation, and is
# - intended to be a core utility for any denizen script(s) implementing inventory type script containers.
#
# - For detailed documentation please visit: https://htools/gui-handler/docs (coming soon)
#
#
# | ----------------------------------------------  GUI HANDLER | APPLICATION  ---------------------------------------------- | #



gui_handler:
    ####################################################################
    # | -------------------  |  Gui Handler  |  -------------------- | #
    ####################################################################
    # | ---                                                      --- | #
    # | ---  This script represents the main uix handler of any  --- | #
    # | ---  denizen application. These scripts should only be   --- | #
    # | ---  edited if you intend to directly adjust sensitive   --- | #
    # | ---  reference data and tasks that affect the operation  --- | #
    # | ---  and functionality of subsequent gui scripts.        --- | #
    # | ---                                                      --- | #
    ####################################################################
    type: world
    debug: true
    data:
        config:
            ####################################################################
            # | ----------------------  |  Config  |  ---------------------- | #
            ####################################################################
            # | ---                                                      --- | #
            # | ---  This file represents the default configuration for  --- | #
            # | ---  uix manager operations, affecting all scripts that  --- | #
            # | ---  utilize the handler script.                         --- | #
            # | ---                                                      --- | #
            ####################################################################
            log-path: plugins/Denizen/data/Htools/gui_handler/logs
            prefixes:
                main: &7[&d&lGui-Handler&7]
            dependencies:
                # |--------------------------------------------------------------| #
                # | ---   These dependencies are treated as priorty lists    --- | #
                # | ---   that are checked when the gui manager utilizes a   --- | #
                # | ---   dependency throughout run time. The data is read   --- | #
                # | ---   in descending order, so this means that in cases   --- | #
                # | ---   where only one element of a specific category is   --- | #
                # | ---   required, such as a permissions plugin, the first  --- | #
                # | ---   element found will be chosen. You should consider  --- | #
                # | ---   these facts when listing related plugins.          --- | #
                # |--------------------------------------------------------------| #
                plugins:
                    # | ---  plugin name  --- | #
                    - UltraPermissions
                    - LuckPerms
                    - Essentials
    events:
        ##################################################
        # | ---  |        manager events        |  --- | #
        ##################################################
        after custom event id:gui_handler_placeholder_event:
            - narrate gui_handler_placeholder_event



# | ------------------------------------------------------------------------------------------------------------------------------ | #


    app:
        get:
            version:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            ast:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            root:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            gui:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            page:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
        reset:
            all:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            ast:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
            data:
                ##########################################################
                # | ---  |               gui task               |  --- | #
                ##########################################################
                # | ---                                            --- | #
                # | ---  Required:  script-id | root | cache-id    --- | #
                # | ---                                            --- | #
                ##########################################################
                - narrate placeholder
        register:
            ########################################
            # | ---  |      gui task      |  --- | #
            ########################################
            # | ---                          --- | #
            # | ---  Required:  script-id    --- | #
            # | ---                          --- | #
            ########################################
            # |------- define data -------| #
            - define prefix <script.data_key[data.config.prefixes.main].parse_color.strip_color>
            # |------- reset status flags -------| #
            - flag <player> <script.name>.current:!
            - flag <player> <script.name>.next:!
            - flag <player> <script.name>.previous:!
            # |------- validate application -------| #
            - define app-id <script.name>.<[script-id]>
            - if ( not <server.flag[<[app-id]>.ast].exists> ):
                - run <script.name> path:app.build def.script-id:<[script-id]> save:build
                - if ( not <entry[build].created_queue.determination.get[1]> ):
                    - define message "<[prefix]> -<&gt> <[script-id]>.start(app) -<&gt> failed."
                    - debug error <[message]>
                    - log <[message]> type:severe file:<script.data_key[data.config.log-path]>/<[script-id]>_log.txt
                    - determine false
            # |------- validate dependencies -------| #
            - run <script.name> path:validate.dependencies def.script-id:<[script-id]> save:dependencies
            - if ( <entry[dependencies].created_queue.determination.get[1]> ):
                - determine true
            - else:
                - define message "<[prefix]> -<&gt> <[script-id]>.validate(dependencies) -<&gt> failed."
                - debug error <[message]>
                - log <[message]> type:severe file:<script.data_key[data.config.log-path]>/<[script-id]>_log.txt
                - determine false
        unregister:
            ########################################
            # | ---  |      gui task      |  --- | #
            ########################################
            # | ---                          --- | #
            # | ---  Required:  script-id    --- | #
            # | ---                          --- | #
            ########################################
            - narrate placeholder
        build:
            ########################################
            # | ---  |      gui task      |  --- | #
            ########################################
            # | ---                          --- | #
            # | ---  Required:  script-id    --- | #
            # | ---                          --- | #
            ########################################
            # |------- define data -------| #
            - define prefix <script.data_key[data.config.prefixes.main].parse_color.strip_color>
            # |------- build gui-files -------| #
            - foreach <server.scripts> as:script:
                - if ( <[script].contains_text[<[script-id]>]> ):
                    - define file-name <[script].relative_filename.after_last[/].before_last[.]>
                    - if ( <[script].ends_with[root_gui]> ):
                        - define root-id <[script].name.after[<[script-id]>_].before_last[_gui].replace_text[_].with[-]>
                    - else if ( <[script].ends_with[gui]> || <[script].ends_with[page]> ):
                        - define <[file-name]>:->:<[script].name.after[<[script-id]>_]>
            # |------- define ast -------| #
            - if ( <[root-id].exists> ):
                - define ast.<[root-id]>:<empty>
                # |------- build ast -------| #
                - foreach <queue.definitions> as:gui-file:
                    - if ( <[gui-file].contains_text[gui]> ):
                        - define page-ids <definition[<[gui-file]>]>
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
                            - define message "<[prefix]> -<&gt> <script.name>.build(<[script-id]>) -<&gt> '<[gui-file]>.dsc' missing valid 'gui-id'."
                            - debug error <[message]>
                            - log <[message]> type:severe file:<script.data_key[data.config.log-path]>/<[script-id]>_log.txt
                            - foreach next
            - else:
                - define message "<[prefix]> -<&gt> <script.name>.build(<[script-id]>) -<&gt> missing 'root-id'."
                - debug error <[message]>
                - log <[message]> type:severe file:<script.data_key[data.config.log-path]>/<[script-id]>_log.txt
            # |------- store ast -------| #
            - if ( <[ast].exists> ):
                - flag server <script.name>.<[script-id]>.ast:<[ast]>
                - determine true
            - else:
                - define message "<[prefix]> -<&gt> <script.name>.build(<[script-id]>) -<&gt> ast compilation failed."
                - debug error <[message]>
                - log <[message]> type:severe file:<script.data_key[data.config.log-path]>/<[script-id]>_log.txt
                - determine false



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    open:
        gui:
            ##############################################
            # | ---  |         gui task         |  --- | #
            ##############################################
            # | ---                                --- | #
            # | ---  Required:  script-id          --- | #
            # | ---                                --- | #
            # | ---  Optional:  gui-id | prefix    --- | #
            # | ---                                --- | #
            ##############################################
            # |------- application data -------| #
            - define root <server.flag[<script.name>.<[script-id]>.ast].keys.first>-gui
            - define blacklist <list[dialog-gui]>
            - if not ( <[prefix].exists> ):
                - define prefix <script.data_key[data.config.prefixes.main].parse_color.strip_color>
            # |------- default target -------| #
            - if ( not <[gui-id].exists> ):
                - define gui-id <[root]>
            # |------- inventory data -------| #
            - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[null]>]>
            - define flagged <server.flag[<script.name>.<[script-id]>.inventories].contains[<[gui-id]>]>
            # |------- authentication check -------| #
            - if ( <[flagged]> ) && ( <[noted]> ):
                - define validated true
            - else:
                # |------- validate inventory -------| #
                - run <script.name> path:validate.gui def.script-id:<[script-id]> def.gui-id:<[gui-id]> def.prefix:<[prefix]> save:validated_gui
                - if ( <entry[validated_gui].created_queue.determination.get[1]> ):
                    # |------- redefine inventory data -------| #
                    - define noted <server.notes[inventories].contains[<inventory[<[gui-id]>].if_null[false]>]>
                    - define flagged <server.flag[<script.name>.<[script-id]>.inventories].contains[<[gui-id]>]>
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
                - if ( <player.flag[<script.name>.current].if_null[<[root]>]> == <[root]> ):
                    - flag <player> <script.name>.next:!|:<list[<empty>]>
                # |------- navigation data -------| #
                - define current <player.flag[<script.name>.current].if_null[<[root]>]>
                - define next <player.flag[<script.name>.next].if_null[<list[<empty>]>]>
                - define previous <player.flag[<script.name>.previous].if_null[<list[<empty>]>]>
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
                        - flag <player> <script.name>.next:->:<[current]>
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
                        - flag <player> <script.name>.previous:->:<[current]>
                - else:
                    - if not ( <player.has_flag[<script.name>.previous]> ):
                        - flag <player> <script.name>.previous:!|:<list[<empty>]>
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
                        - flag <player> <script.name>.next:->:<[gui-id]>
                # |---------------------------------------------| #
                # | ---  Open and set the 'target' gui-id.  --- | #
                # |---------------------------------------------| #
                - flag <player> <script.name>.current:<[gui-id]>
                - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                - inventory open destination:<[gui-id]>
                # |---------------------------------------------------------| #
                # | ---  Set and validate the current working 'cache'.  --- | #
                # |---------------------------------------------------------| #
                - define cache-id <script.name>.next
                - inject <script.name> path:validate.cache
                - determine true
            - else:
                - determine false
        previous:
            ################################################
            # | ---  |           gui task         |  --- | #
            ################################################
            # | ---                                  --- | #
            # | ---  Required:  script-id | gui-id   --- | #
            # | ---                                  --- | #
            # | ---  Optional:  prefix               --- | #
            # | ---                                  --- | #
            ################################################
            # |------- app data -------| #
            - define root <server.flag[<script.name>.<[script-id]>.ast].keys.first>-gui
            - define blacklist <list[dialog-gui]>
            # |------- navigation data -------| #
            - define current <player.flag[<script.name>.current]>
            - define next <player.flag[<script.name>.next]>
            - define previous <player.flag[<script.name>.previous]>
            # |------- check context -------| #
            - choose <[gui-id]>:
                - case previous-page:
                    # |------------------------------------------------------------------| #
                    # | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
                    # |------------------------------------------------------------------| #
                    - if ( <[previous].contains[<[current]>]> ):
                        - flag <player> <script.name>.previous:<-:<[current]>
                    # |--------------------------------------------------------------------| #
                    # | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
                    # | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
                    # |--------------------------------------------------------------------| #
                    - if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
                        # |---------------------------------------------------------| #
                        # | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
                        # |---------------------------------------------------------| #
                        - if ( not <[next].contains[<[current]>]> ) && ( not <[blacklist].contains[<[current]>]> ):
                            - flag <player> <script.name>.next:->:<[current]>
                        # |----------------------------------------------------| #
                        # | ---  Define the 'target' gui-id to the latest  --- | #
                        # | ---  gui-id from the 'previous-cache'.         --- | #
                        # |----------------------------------------------------| #
                        - define gui-id <player.flag[<script.name>.previous].last>
                        # |-----------------------------------------------------------------| #
                        # | ---  Remove the 'target' gui-id from the 'previous-cache'.  --- | #
                        # |-----------------------------------------------------------------| #
                        - if ( <[previous].contains[<[gui-id]>]> ):
                            - flag <player> <script.name>.previous:<-:<[gui-id]>
                        # |-------------------------------------------------------| #
                        # | ---  Open and set the 'target' gui-id inventory.  --- | #
                        # |-------------------------------------------------------| #
                        - flag <player> <script.name>.current:<[gui-id]>
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - inventory open destination:<[gui-id]>
                        - determine true
                    - else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
                        # |-----------------------------------------------------------| #
                        # | ---  The 'previous-cache' is empty. Close inventory.  --- | #
                        # |-----------------------------------------------------------| #
                        - inventory close
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - flag <player> <script.name>.next:<list[<empty>]>
                        - flag <player> <script.name>.current:null
                        - determine false
                    - else:
                        # |-----------------------------------------------------------| #
                        # | ---  The 'current' and 'target' gui-id are identical. --- | #
                        # |-----------------------------------------------------------| #
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - determine false
                - case previous-page-2:
                    # |------------------------------------------------------------------| #
                    # | ---  Remove the 'current' gui-id from the 'previous-cache'.  --- | #
                    # |------------------------------------------------------------------| #
                    - if ( <[previous].contains[<[current]>]> ):
                        - flag <player> <script.name>.previous:<-:<[current]>
                    # |--------------------------------------------------------------------| #
                    # | ---  Ensure the 'target' gui-id entry in the 'previous-cache'  --- | #
                    # | ---  doesn't match the 'current' or 'root' gui-id(s).          --- | #
                    # |--------------------------------------------------------------------| #
                    - if ( <[current]> != <[root]> ) && ( <[current]> != <[previous].exclude[<[current]>].last.if_null[null]> ):
                        # |---------------------------------------------------------| #
                        # | ---  Add the 'current' gui-id to the 'next-cache'.  --- | #
                        # |---------------------------------------------------------| #
                        - if ( <[next].contains[<[current]>]> ):
                            - flag <player> <script.name>.next:<-:<[current]>
                        # |----------------------------------------------------| #
                        # | ---  Define the 'target' gui-id to the latest  --- | #
                        # | ---  gui-id from the 'previous-cache'.         --- | #
                        # |----------------------------------------------------| #
                        - define gui-id <player.flag[<script.name>.previous].last>
                        # |----------------------------------------------------| #
                        # | ---  Define the next 'target' gui-id to the    --- | #
                        # | ---  latest gui-id from the 'previous-cache'.  --- | #
                        # |----------------------------------------------------| #
                        - define gui-id-after <player.flag[<script.name>.previous].exclude[<[gui-id]>].last>
                        # |------------------------------------------------------------| #
                        # | ---  Remove the 'target' gui-id from the 'next-cache'  --- | #
                        # | ---  and 'previous-cache'.                             --- | #
                        # |------------------------------------------------------------| #
                        - if ( <[next].contains[<[gui-id]>]> ):
                            - flag <player> <script.name>.next:<-:<[gui-id]>
                        - if ( <[previous].contains[<[gui-id]>]> ):
                            - flag <player> <script.name>.previous:<-:<[gui-id]>
                        # |----------------------------------------------------------------| #
                        # | ---  Remove the 'after' gui-id from the 'previous-cache'.  --- | #
                        # |----------------------------------------------------------------| #
                        - if ( <[previous].contains[<[gui-id-after]>]> ):
                            - flag <player> <script.name>.previous:<-:<[gui-id-after]>
                        # |------------------------------------------------------| #
                        # | ---  Open and set the 'after' gui-id inventory.  --- | #
                        # |------------------------------------------------------| #
                        - flag <player> <script.name>.current:<[gui-id-after]>
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - inventory open destination:<[gui-id-after]>
                        - determine true
                    - else if ( <[current]> == <[root]> ) && ( <[previous].is_empty> ):
                        # |-----------------------------------------------------------| #
                        # | ---  The 'previous-cache' is empty. Close inventory.  --- | #
                        # |-----------------------------------------------------------| #
                        - inventory close
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - flag <player> <script.name>.next:<list[<empty>]>
                        - flag <player> <script.name>.current:null
                        - determine false
                    - else:
                        # |-----------------------------------------------------------| #
                        # | ---  The 'current' and 'target' gui-id are identical. --- | #
                        # |-----------------------------------------------------------| #
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - determine false
        next:
            ################################################
            # | ---  |          gui task          |  --- | #
            ################################################
            # | ---                                  --- | #
            # | ---  Required:  script-id | gui-id   --- | #
            # | ---                                  --- | #
            # | ---  Optional:  prefix               --- | #
            # | ---                                  --- | #
            ################################################
            # |------- app data -------| #
            - define root <server.flag[<script.name>.<[script-id]>.ast].keys.first>-gui
            - define blacklist <list[dialog-gui]>
            # |------- navigation data -------| #
            - define current <player.flag[<script.name>.current]>
            - define next <player.flag[<script.name>.next]>
            - define previous <player.flag[<script.name>.previous]>
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
                            - flag <player> <script.name>.previous:->:<[current]>
                        # |------- next-cache data -------| #
                        - if ( <[current]> == <[root]> ):
                            - define gui-id <player.flag[<script.name>.next].first>
                        - else:
                            - define gui-id <player.flag[<script.name>.next].last>
                        # |------- open next-cached -------| #
                        - flag <player> <script.name>.current:<[gui-id]>
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - inventory open destination:<[gui-id]>
                        - determine true
                    - else:
                        # |------- end cache -------| #
                        - playsound <player> sound:<server.flag[citizens_editor.settings.interface.settings.sounds.left-click-button]> pitch:1
                        - determine false



# | ------------------------------------------------------------------------------------------------------------------------------ | #



    validate:
        cache:
            ##########################################################
            # | ---  |               gui task               |  --- | #
            ##########################################################
            # | ---                                            --- | #
            # | ---  Required:  script-id | root | cache-id    --- | #
            # | ---                                            --- | #
            ##########################################################
            - if ( <player.flag[<script.name>.current].ends_with[-page]> ):
                - define current <player.flag[<script.name>.current].before[-page]>
                # |-------------------------------------------------------------| #
                # | ---  Get the last 'parent' gui-id from the 'cache' and  --- | #
                # | ---  list every 'relative' of the 'current' gui-id.     --- | #
                # |-------------------------------------------------------------| #
                - define cache <player.flag[<[cache-id]>]>
                - define parent <[cache].get[<[cache].find_all_partial[-gui].last>].before[-gui].if_null[null]>
                - define group <server.flag[<script.name>.<[script-id]>.ast.<[root].before[-gui]>.<[parent]>].if_null[<list[empty]>]>
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
                    - determine true
                - else:
                    - determine false
        dependencies:
            ########################################
            # | ---  |      gui task      |  --- | #
            ########################################
            # | ---                          --- | #
            # | ---  Required:  script-id    --- | #
            # | ---                          --- | #
            ########################################
            # |------- define data -------| #
            - define prefix <script.data_key[data.config.prefixes.main].parse_color.strip_color>
            - define plugins <script.data_key[data.config.dependencies.plugins]||null>
            - define loaded_plugins <list[]>
            # |------- plugin check -------| #
            - if not ( <[plugins].equals[null]> ):
                - foreach <[plugins]> as:plugin:
                    - if ( <[plugin].equals[<empty>]> ) || ( <[plugin].equals[null]> ) || ( not <plugin[<[plugin]>].exists> ):
                        - foreach next
                    - else:
                        - define listed <server.plugins.if_null[<list[]>]>
                        - if ( <[listed]> contains <plugin[<[plugin]>]> ):
                            - define loaded_plugins:->:<[plugin]>
                            - announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' was successfully loaded."
                        - else:
                            - announce to_console "<[prefix]> -<&gt> <&lb>Validate-Plugins<&rb> - The plugin '<[plugin]>' could not be located and was subsequently skipped."
            # |------- set permissions handler -------| #
            - foreach <server.flag[<script.name>.dependencies.plugins]> as:plugin:
                - choose <[plugin]>:
                    - case default:
                        - foreach next
                    - case UltraPermissions:
                        - flag server <script.name>.permissions_handler:<[plugin]>
                    - case LuckPerms:
                        - flag server <script.name>.permissions_handler:<[plugin]>
                    - case Essentials:
                        - flag server <script.name>.permissions_handler:<[plugin]>
                - foreach stop
            # |------- set dependencies -------| #
            - flag server <script.name>.dependencies.plugins:<[loaded_plugins]>
            - if ( not <server.flag[<script.name>.dependencies.scripts].contains[<[script-id]>]> ):
                - flag server <script.name>.dependencies.scripts:->:<[script-id]>
            - determine true
        gui:
            ################################################
            # | ---  |          gui task          |  --- | #
            ################################################
            # | ---                                  --- | #
            # | ---  Required:  script-id | gui-id   --- | #
            # | ---                                  --- | #
            # | ---  Optional:  prefix               --- | #
            # | ---                                  --- | #
            ################################################
            # |------- default target -------| #
            - if not ( <[prefix].exists> ):
                - define prefix <script.data_key[data.config.prefixes.main].parse_color.strip_color>
            - if ( not <[gui-id].exists> ):
                - define gui-id <player.flag[<script.name>.current]>
            - else if ( <[gui-id]> == previous-page ):
                - define gui-id <player.flag[<script.name>.previous].last>
            - else if ( <[gui-id]> == previous-page-2 ):
                - define last <player.flag[<script.name>.previous].last>
                - define gui-id <player.flag[<script.name>.previous].exclude[<[last]>].last>
            # |------- inventory data -------| #
            - define root-node <server.flag[<script.name>.<[script-id]>.ast].keys.first>
            - define ast <server.flag[<script.name>.<[script-id]>.ast.<[root-node]>]||null>
            - define inventories <script.name>.<[script-id]>.inventories
            - if ( <[ast]> != null ):
                - if ( <[root-node]> == <[gui-id].before[-gui]> ):
                    # |------- set inventory-id -------| #
                        - define inventory <inventory[<[script-id]>_<[gui-id].replace_text[-].with[_]>].if_null[null]>
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
                            - determine true
                # |------- build inventory -------| #
                - foreach <[ast]> key:parent-id as:pages:
                    - if ( <[parent-id]> == <[gui-id].before[-gui]> ) || ( <[pages].contains[<[gui-id].before[-page]>]> ):
                        # |------- set inventory-id -------| #
                        - define inventory <inventory[<[script-id]>_<[gui-id].replace_text[-].with[_]>].if_null[null]>
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
                            - determine true
                - determine false
            - else:
                - narrate "<[prefix]> <&c>Missing root '<&f><[gui-id]><&c>' in application uix syntax tree."



# | ------------------------------------------------------------------------------------------------------------------------------ | #


