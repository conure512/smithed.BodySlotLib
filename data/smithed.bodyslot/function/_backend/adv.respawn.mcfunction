# Called by advancement smithed.bodyslot:respawn

# If the player had any persistent modifiers registered to them,
# this function re-applies them when the player respawns.
# It also has the convenient side-effect of setting up a registry entry
# for the player as soon as they join the world.

# Author: Conure512


function smithed.bodyslot:_backend/macro.load_player with entity @s
execute unless data storage smithed:bodyslot current_player.modifiers[0] run return run data remove storage smithed:bodyslot current_player

function smithed.bodyslot:_backend/ensure_body_item
function smithed.bodyslot:_backend/macro.apply_next_modifier with storage smithed:bodyslot current_player.modifiers[0]
data remove storage smithed:bodyslot current_player