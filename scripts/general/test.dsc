#
#
# - define result "<[result].if_null[]><gray><[value]><[loop_index].equals[<[s_last]>].if_true[ and ].if_false[<[loop_index].equals[<[last]>].if_true
#
# - define usage_loc <script[lib_generic_data].data_key[command.usage.<[usage_name]>].if_null[true].if_true[<proc[<[usage_name]>]>].if_false[<proc[lib_core_command_usage].context[<[usage_name]>]>]>
# - determine <[color].get[error]><script[lib_generic_data].parsed_key[command.error.<[err_type]>]><list[permission|implicit|invalid_player].contains[<[err_type]>].not.if_true[<[color].get[error]><&nl>Usage<&co><&nl><[usa#ge_loc]>].if_false[]>
#
#
#