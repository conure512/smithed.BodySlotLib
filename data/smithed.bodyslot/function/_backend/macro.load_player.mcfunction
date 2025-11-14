# Searches the storage slot for the player's data and saves it to "current_player".
# If the player doesn't have an entry yet, a new entry is added for them.
# NOTE: This function requires that "current_player" doesn't exist at first in order to work properly.

# Author: Conure512

# Macro Context: Base Player NBT

# @s: The player whose data was passed into the macro


$data modify storage smithed:bodyslot current_player set from storage smithed:bodyslot player_registry[{UUID:$(UUID)}]
execute if data storage smithed:bodyslot current_player run return 0
data modify storage smithed:bodyslot current_player set value {modifiers:[]}
data modify storage smithed:bodyslot current_player.UUID set from entity @s UUID
data modify storage smithed:bodyslot player_registry append from storage smithed:bodyslot current_player