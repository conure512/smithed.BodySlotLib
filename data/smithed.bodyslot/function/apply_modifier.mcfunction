# If the datapack wishes to utilize the player's body slot to apply a custom effect to the player,
# simply call this macro function with an item modifier that applies that effect.
# For example, if I wish for the player to be under the effects of a custom enchantment without the need
# to put that enchantment on one of the player's items, I would specify that the enchantment works on the
# Body slot, make a modifier that adds that enchantment to an item,
# and then call this function with that modifier.

# Wherever possible, it's required to use modifiers that merge or update data instead of overwriting it;
# for example, instead of using "set_components" with the enchantments component, use "set_enchantments".

# Effects applied by this function will be lost when the player dies (unless keepInventory is true);
# To ensure that effects are persistent through death, call the function "smithed.bodyslot:apply_persistent_modifier" instead.

# Author: Conure512

# Macro Arguments
# modifier (String or Object): An item modifier, either the name of a modifier defined in a datapack or an inlined NBT modifier object.

# @s: The affected player


function smithed.bodyslot:_backend/ensure_body_item
$item modify entity @s armor.body $(modifier)