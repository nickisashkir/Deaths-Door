execute store result storage graves_back:main args.grave_id int 1.0 run scoreboard players get @s graves.tp
function graves_back:do_lookup with storage graves_back:main args
data remove storage graves_back:main args
data remove storage graves_back:main target
