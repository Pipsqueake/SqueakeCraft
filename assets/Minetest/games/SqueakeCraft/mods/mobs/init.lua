-- Mob Api (18th Sep 2014)
dofile(minetest.get_modpath("mobs").."/api.lua")

-- Animals inc. Krupnovpavel's warthog and JKmurray's chicken
dofile(minetest.get_modpath("mobs").."/chicken.lua")
dofile(minetest.get_modpath("mobs").."/cow.lua")
dofile(minetest.get_modpath("mobs").."/rat.lua")
dofile(minetest.get_modpath("mobs").."/sheep.lua")
dofile(minetest.get_modpath("mobs").."/warthog.lua")
dofile(minetest.get_modpath("mobs").."/wardog.lua")
dofile(minetest.get_modpath("mobs").."/wolf.lua")


-- Monsters
dofile(minetest.get_modpath("mobs").."/spider.lua")
dofile(minetest.get_modpath("mobs").."/warspider.lua")
dofile(minetest.get_modpath("mobs").."/littlespider.lua")

-- Other monster on qt_mobs (mod by MoNTE48)

-- Meat & Cooked Meat
minetest.register_craftitem("mobs:meat_raw", {
    description = "Raw Meat",
    inventory_image = "mobs_meat_raw.png",
    on_use = minetest.item_eat(3),
    groups = {foodstuffs = 1},
})

minetest.register_craftitem("mobs:meat", {
    description = "Meat",
    inventory_image = "mobs_meat.png",
    on_use = minetest.item_eat(8),
    groups = {foodstuffs = 1},
})

minetest.register_craft({
    type = "cooking",
    output = "mobs:meat",
    recipe = "mobs:meat_raw",
    cooktime = 5,
})


if minetest.setting_get("log_mods") then
    minetest.log("action", "[OK] Mobs loaded")
end
