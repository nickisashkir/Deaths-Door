$execute in $(dimension) run tp @s $(x) $(y) $(z)
effect give @s minecraft:resistance 10 4 false
effect give @s minecraft:fire_resistance 10 0 false
$tellraw @s [{color:"gray",text:"Teleported to your grave at "},{color:"yellow",text:"$(x_int), $(y_int), $(z_int)"},{color:"dark_gray",text:" (10s grace)"}]
