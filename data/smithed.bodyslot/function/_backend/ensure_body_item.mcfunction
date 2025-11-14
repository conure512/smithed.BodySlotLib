# If the player has no item in their body slot, a standard item is added.
# If an item already exists, it is tested to ensure it has the correct
# base properties, which are added if not present.

# Author: Conure512

# @s: Affected player


execute unless items entity @s armor.body * run return run item replace entity @s armor.body with music_disc_5[!jukebox_playable,custom_data={smithed:{bodyslot:1b,ignore:{functionality:1b,crafting:1b}}},equippable={slot:"body",equip_sound:{sound_id:"minecraft:silent",range:0f},dispensable:0b,swappable:0b,damage_on_hurt:0b},enchantments={"minecraft:vanishing_curse":1,"minecraft:binding_curse":1},item_name="Smithed Body Slot Item",item_model="minecraft:barrier",lore=[{text:"If you're seeing this item, one of your",color:"gold"},{text:"datapacks is not obeying conventions!",color:"gold"}]]

execute unless items entity @s armor.body *[enchantments~[{enchantments:"minecraft:binding_curse"},{enchantments:"minecraft:vanishing_curse"}]] run item modify entity @s armor.body smithed.bodyslot:ensure_body_properties