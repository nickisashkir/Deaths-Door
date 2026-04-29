scoreboard objectives add graves.tp trigger 'Teleport to Grave'
scoreboard objectives add graves.dummy dummy
scoreboard players reset * graves.tp
scoreboard players enable @a graves.tp
schedule function graves_back:schedule_2t 2 replace
