# Body Slot Lib | v0.2 (Draft)
Author: Conure512

For: Smithed Project


This datapack library, and the associated proposed conventions, make it easy for other pack creators to make use of the player's hidden Body and Saddle Slots. Since the player has no way to manually access these slots and they are considered Equipment slots by the game, it is convenient to use them for things such as applying custom enchantments to a player without needing them to have an item equipped. However, since there are only two hardcoded slots, these slots threaten to be a major source of conflict between separate datapacks that are all trying to make use of them. By following the outlined conventions and (potentially) making use of this library, datapack creators can rest assured that they'll run into no conflicts with other packs - provided those other packs *also* follow these conventions.


The existence of two slots leaves convenient room to have separate conventions for each one.


## Saddle Conventions
The Saddle slot follows a very simple ethos: never LEAVE anything there. Any pack creator can put ANY item into the saddle slot, provided that that item is removed so quickly that no other pack would have time to observe it. For example, if I put an item into the saddle slot with a custom enchantment on it, the enchantment should use a location_changed trigger (which always triggers on first equip) to run a function that clears the saddle slot. It might also be smart to apply Curse of Vanishing (or a custom enchantment with the same effect) just to ensure absolute safety.

This convention makes the Saddle slot ideal for applying *Instant Effects*. For example, a custom enchantment can set fire to the player, apply a potion effect for a non-integer number of seconds, or cause custom explosions that are credited to the player; all of these effects only need a mere instant to run. This means that an item can be equipped, have its enchantment apply an effect, and then have that same enchantment clear the saddle slot, all within the span of less than a tick.

In an attempt to prevent loads of different packs from each defining their own function that does nothing but clear the saddle slot, such a function has been provided by this library; custom enchantments can point to the function "smithed.bodyslot:clear_saddle_slot" if your pack happens to be using this library.


## Body Conventions
While the Saddle slot covers all Instant Effects, the Body slot is left to cover pretty much everything else. It's possible that your particular use case requires that the equipped item stays on the player for some extended period of time, or even indefinitely. Damage resistances/immunities, and other obscure enchantment-based effects like Soul Speed, would fall into this category. In that case, these conventions require you to use the body slot, and to use this library; without this library, cross-pack compatibility cannot be guaranteed.

This library/convention is centered around the idea that as long as a pack wants to make use of the body slot, one special pre-designated item must stay on the player's body slot at all times, and packs that wish to apply long-lasting effects must run *Item Modifiers* on the body slot. The library provides functions that allow you to do this easily.

Packs that wish to use the body slot must use the following functions from this library to do so.

`function smithed.bodyslot:apply_modifier {modifier:<your_item_modifier>}`

This function simply applies the given Item Modifier to the item in your body slot. If no such item exists yet, the function smithed.bodyslot:_backend/ensure_body_item automatically runs to ensure that a suitable item is present. (See inside this function for the definition of the standard item.) In other words, it's always safe to run the "apply_modifier" function without the need to place an item in the body slot yourself.

The passed item modifier can either be the String ID of a modifier defined in a datapack, or a fully-inlined NBT object representing a new item modifier. See the comments on this function for additional rules about what types of modifiers are allowed; in general, modifiers that replace or entirely remove item components should be avoided whenever possible, to prevent as many conflicts as possible.

An example use case of this function is to create a modifier that adds your custom enchantment; perhaps you want the player to be immune to a certain damage type for the next 10 minutes, so you create an enchantment that provides that immunity, create a modifier that applies that enchantment, and then pass that modifier into this function.

Note that any modifiers applied by this function will not be preserved with the player dies (unless keepInventory is enabled).

`function smithed.bodyslot:apply_persistent_modifier {modifier:<your_item_modifier>}`

This function applies an item modifier just as before, and also ensures that if the player dies without keepInventory, the same modifier is applied again as soon as the player respawns.

Unlike the previous function, inlined NBT modifier definitions are not allowed; this function only accepts string IDs of modifiers defined in datapacks.

`function smithed.bodyslot:remove_persistent_modifier {modifier:<your_item_modifier>}`

This function "un-registers" a given modifier ID from the player, so they'll no longer receive this modifier again upon respawning. It does NOT undo the effects of a modifier that is currently on the player's body item; in order to undo the effects of any modifier, you must create a new modifier that undoes it and apply it using the first function (apply_modifier). So, for example, if you no longer want the player to have your custom enchantment from the first example, you must create a set_enchantments modifier that removes that specific enchantment.


# ==== Examples of Using This Library ====


## Example A: A Simple Immunity

I want to grant the player permanent immunity to Arrows. I don't want to give them a custom item that accomplishes this; they should be immune to arrows no matter what they're wearing. Therefore, I should grant this immunity through their hidden Body item.

Step 1) Create the Enchantment
Currently, the only way to give specific damage immunities is with a custom enchantment. So first, I'll simply create an enchantment that grants this immunity.

Step 2) Create the Modifier
The modifier should look something like this:

`{
	"function": "set_enchantments",
	"enchantments": { "my_custom_enchant": 1 }
}`

Notice that I'm being very careful to use a function that won't mess with other packs' enchantments on the same item, if they exist. "set_enchantments" is the right way to do this, as opposed to "set_components", which would totally overwrite the enchantments component.

I can either define that modifier in a datapack and take its ID, or define it directly as NBT.

Step 3) Apply It
I'll run this command AS the player:

`execute as <player> run function smithed.bodyslot:apply_modifier {modifier:<my_modifier_here>}`

The player will now have arrow immunity. However, if they die, and keepInventory is disabled, this effect will be gone.


## Example B: A Predetermined Buff

I want the player to have a Soul Speed-like effect for the next 15 minutes, and they should be able to die as much as they want without losing this effect. We have keepInventory off, so if I use the previous method, they WILL lose it when they die. Therefore, I should use a *persistent* modifier.
(If you plan on doing this example yourself as an exercise, make sure you do make your own enchantment rather than just trying it with Soul Speed; the vanilla Soul Speed is defined to only work in the feet slot!)

Step 1) Create the relevant enchantment and item modifier to apply that enchantment (steps 1 and 2 from the first example). Remember that in this case, the modifier NEEDS to be defined in a datapack, and not inlined!

Step 2) Apply a Persistent Modifier

`execute as <player> run function smithed.bodyslot:apply_persistent_modifier {modifier:<my_modifier_here>}`

The player will now have this Soul Speed-like buff, and it will NOT be lost on death.
However, I said that I wanted it to only last a limited time. I've got a timer that ticks down from 15 minutes, so when it reaches zero, I'll need to UNDO this effect.

Step 3) The Reverse Modifier
First and foremost, the effect needs to end *right now*. So, I need a new item modifier that *removes* the enchantment I applied earlier.

`{
	"function": "set_enchantments",
	"enchantments": { "my_custom_enchant": 0 }
}`

Again, this modifier only deals with my enchantment, not any others; in this case, setting the level to 0 will end up removing the enchantment.

I'll then apply this new modifier:

`execute as <player> run function smithed.bodyslot:apply_modifier {modifier:<that_reverse_modifier>}`

Now, the player won't have the Soul Speed effect anymore. However, remember that when the player respawns, they'll still have that enchantment applied, because it was registered as a persistent modifier. To undo this, we'll need to do one more thing:

Step 4) Un-Register the Original Modifier
The ID of the original modifier is still saved in storage, so I need to unregister it.

	execute as <player> run function smithed.bodyslot:remove_persistent_modifier {modifier:<the_original_modifier>}

Now, once all of that is done, the player will be fully rid of that custom effect.
