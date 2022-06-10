


# | ---------------------------------------------- CITIZENS EDITOR | INVENTORIES ---------------------------------------------- | #



citizens_editor_main_menu_gui:
    type: inventory
    debug: false
    data:
        shortcuts: 6
    inventory: CHEST
    title: <&5><&l>NPC Editor
    gui: true
    definitions:
        profiles-page: <item[book].with_flag[npce-gui-button:profiles-page].with[display=<&d><&l>NPC<&sp>Profiles]>
        corner-material: <item[<script[citizens_editor_config].data_key[gui].get[corner-material]||white_stained_glass_pane>].with[display=<&d> <empty>]>
        edge-material: <item[<script[citizens_editor_config].data_key[gui].get[edge-material]||purple_stained_glass_pane>].with[display=<&d> <empty>]>
    slots:
        - [corner-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [corner-material]
        - [edge-material] [] [profiles-page] [] [profiles-page] [] [profiles-page] [] [edge-material]
        - [edge-material] [] [] [] [] [] [] [] [edge-material]
        - [edge-material] [] [profiles-page] [] [profiles-page] [] [profiles-page] [] [edge-material]
        - [corner-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [edge-material] [corner-material]



# | ------------------------------------------------------------------------------------------------------------------------------ | #



citizens_editor_profiles_gui:
    type: inventory
    debug: false
    inventory: CHEST
    title: <&5><&l>Profile List
    gui: true
    slots:
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []
        - [] [] [] [] [] [] [] [] []



# | ------------------------------------------------------------------------------------------------------------------------------ | #


