
-- Glowtest Spider

mobs:register_mob("mobs:spider", {
    type = "animal",
    hp_min = 20,
    hp_max = 40,
    collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
    textures = {"mobs_spider.png"},
    visual_size = {x=7,y=7},
    visual = "mesh",
    mesh = "mobs_spider.x",
    makes_footstep_sound = true,
    sounds = {
        random = "mobs_spider",
    },
    view_range = 15,
    walk_velocity = 1,
    run_velocity = 3,
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
        if tool:get_name() == "mobs:bee" then
            clicker:get_inventory():remove_item("main", "mobs:bee")
            minetest.add_entity(self.object:getpos(), "mobs:warspider")
            self.object:remove()
        end
    end,

    animation = {
        speed_normal = 15,
        speed_run = 15,
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
mobs:register_spawn("mobs:spider", {"default:desert_stone", "ethereal:crystal_topped_dirt", "default:dirt_with_grass","default:dirt"}, 20, -1, 7000, 1, 31000)

-- Ethereal crystal spike compatibility

if not minetest.get_modpath("ethereal") then
    minetest.register_alias("ethereal:crystal_spike", "default:sandstone")
end

