# Called by advancement smithed.bodyslot:death

# Detects when the player dies via an advancement, and if keepInventory is false,
# the player is marked for modifier re-evaluation upon respawning.

# Author: Conure512


advancement revoke @s only smithed.bodyslot:death
execute unless function smithed.bodyslot:_backend/test.keep_inventory run advancement revoke @s only smithed.bodyslot:respawn