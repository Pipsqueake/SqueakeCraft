-- Warthog

mobs:register_mob("mobs:pumba", {
	type = "animal",
	hp_min = 10,
	hp_max = 25,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_pumba.png"},
	visual = "mesh",
	mesh = "mobs_pumba.x",
	makes_footstep_sound = true,
	walk_velocity = 2,
	armor = 200,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	sounds = {
		random = "mobs_pig",
	},
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 55,
		walk_start = 70,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
jump = true,
step = 1,
passive = true,

	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 then
				self.food = 0
				self.tamed = true
				minetest.sound_play("mobs_pig", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return
		end
	end,
	
})
mobs:register_spawn("mobs:pumba", {"ethereal:mushroom_dirt", "default:dirt_with_grass","default:dirt","default:snow", "default:snowblock"}, 20, 8, 9000, 1, 31000)