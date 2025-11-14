# If the affected player has the provided modifier registered as a persistent modifier,
# this function simply removes that modifier from the registry so it is no longer applied at respawn.

# To fully reverse the effects of an applied modifier effective immediately, you must create
# a new modifier that undoes the first one, and then call "apply_modifier" with that new one.

# Author: Conure512

# Macro Arguments:
# modifier (String): ID of item modifier to un-register

# @s: Affected player


function smithed.bodyslot:_backend/macro.load_player with entity @s
$data remove storage smithed:bodyslot current_player.modifiers[{modifier:"$(modifier)"}]
function smithed.bodyslot:_backend/macro.save_player with entity @s