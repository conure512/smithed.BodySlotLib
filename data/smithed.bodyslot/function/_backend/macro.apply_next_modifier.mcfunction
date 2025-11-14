# Iterative function that applies persistent modifiers one at a time from the storage list

# Author: Conure512

# Macro Arguments:
# modifier (String): ID of modifier to apply

# @s: Affected player


$item modify entity @s armor.body $(modifier)
data remove storage smithed:bodyslot current_player.modifiers[0]
execute if data storage smithed:bodyslot current_player.modifiers[0] run function smithed.bodyslot:_backend/macro.apply_next_modifier with storage smithed:bodyslot current_player.modifiers[0]