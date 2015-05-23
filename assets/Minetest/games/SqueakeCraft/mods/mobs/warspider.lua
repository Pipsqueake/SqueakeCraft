
-- Glowtest Spider

mobs:register_mob("mobs:warspider", {
    type = "warpet",
    attacks_monsters = true,
    hp_min = 20,
    hp_max = 40,
    owner = "",
    collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
    textures = {"mobs_warspider.png"},
    visual_size = {x=7,y=7},
    visual = "mesh",
    mesh = "mobs_spider.x",
    makes_footstep_sound = true,
    sounds = {
        random = "mobs_spider",
    },
    view_range = 1000,
    monsterrange = 30,
    monsterdetect = false,
    walk_velocity = 4,
    run_velocity = 4,
    armor = 200,
    damage = 3,
    drops = {
        {name = "default:string",
        chance = 1,
        min = 1,
        max = 5,},
    },
    light_resistant = false,
    drawtype = "front",
    water_damage = 5,
    lava_damage = 5,
    light_damage = 0,
    on_rightclick = nil,
    attack_type = "dogfight",


    on_rightclick = function(self, clicker)
        tool = clicker:get_wielded_item()
        if tool:get_name() == "default:sign_wall" then
            self.owner = clicker:get_player_name()
        elseif tool:get_name() == "mobs:egg" then
            clicker:get_inventory():add_item("main", "mobs:spideregg")
            clicker:get_inventory():remove_item("main", "mobs:egg")
        else
            minetest.add_entity(self.object:getpos(), "mobs:warspider")
            self.object:remove()
        end
    end,

    animation = {
        speed_normal = 20,
        speed_run = 30,
        stand_start = 1,
        stand_end = 1,
        walk_start = 20,
        walk_end = 40,
        run_start = 20,
        run_end = 40,
        punch_start = 50,
        punch_end = 90,
    },
    jump = true,
    sounds = {},
    step = 1,
})

minetest.register_craftitem("mobs:spideregg", {
description = "Spider Egg",
    inventory_image = "spideregg.png",
    groups = {misc = 1},

    on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                minetest.add_entity(pointed_thing.above, "mobs:littlespider")
                itemstack:take_item()
            end
            return itemstack
    end,
})
