$execute unless entity @s[nbt={UUID: $(owner_uuid)}] run return run tellraw @s {color:"red",text:"That isn't your grave."}
function graves_back:do_tp with storage graves_back:main target
