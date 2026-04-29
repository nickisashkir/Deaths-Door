schedule function graves_back:schedule_2t 2 replace
execute as @a[scores={graves.tp=1..}] run function graves_back:teleport_self
scoreboard players set @a graves.tp 0
scoreboard players enable @a graves.tp
