$data modify storage graves_back:main target set from storage graves_back:main index[{id: $(grave_id)}]
execute unless data storage graves_back:main target run return run tellraw @s {color:"red",text:"That grave no longer exists."}
function graves_back:check_owner with storage graves_back:main target
