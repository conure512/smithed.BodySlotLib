# Applies a modifier that is restored after the player dies;
# for more information, see the function "smithed.bodyslot:apply_modifier".

# Author: Conure512

# Macro Arguments
# modifier (String): The name of a modifier defined in a datapack.
#	NOTE: Unlike the other function, this one doesn't accept inlined objects.

# @s: The affected player


function smithed.bodyslot:_backend/ensure_body_item
$item modify entity @s armor.body $(modifier)

function smithed.bodyslot:_backend/macro.load_player with entity @s
$data modify storage smithed:bodyslot current_player.modifiers append value {modifier:"$(modifier)"}
function smithed.bodyslot:_backend/macro.save_player with entity @s