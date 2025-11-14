# Updates the "player_registry" field in storage with the current values in "current_player".
# The "current_player" field is also wiped clean afterward.

# Author: Conure512

# Macro Context: Base Player NBT


$data modify storage smithed:bodyslot player_registry[{UUID:$(UUID)}] set from storage smithed:bodyslot current_player
data remove storage smithed:bodyslot current_player