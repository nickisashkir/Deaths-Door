scoreboard players add $next_grave_id graves.dummy 1
data modify storage graves:main creation.gb_args set from storage graves:main creation.macro_args
execute store result storage graves:main creation.gb_args.grave_id int 1.0 run scoreboard players get $next_grave_id graves.dummy
function graves_back:build_listing with storage graves:main creation.gb_args
data remove storage graves:main creation.gb_args
