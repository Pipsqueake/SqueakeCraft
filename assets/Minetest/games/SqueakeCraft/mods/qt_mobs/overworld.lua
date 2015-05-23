-- overworld mobs

minetest.register_craftitem("qt_mobs:rotten_flesh", {
	description = "Zombie Flesh",
	inventory_image = "zombie_flesh.png",
	on_use = minetest.item_eat(-1),
})

minetest.register_craftitem("qt_mobs:armor_frag_diamond", {
	description = "Diamond Armor Fragments",
	inventory_image = "diamond_armor_frag.png",
})

minetest.register_craft({
	output = 'default:gold_ingot 2',
	recipe = {
		{'qt_mobs:armor_frag_diamond'},
	}
})

minetest.register_craftitem("qt_mobs:armor_frag_mese", {
	description = "Mese Armor Fragments",
	inventory_image = "gold_armor_frag.png",
})

minetest.register_craft({
	output = 'default:mese_crystal 2',
	recipe = {
		{'qt_mobs:armor_frag_mese'},
	}
})

minetest.register_craftitem("qt_mobs:armor_frag_gold", {
	description = "Gold Armor Fragments",
	inventory_image = "gold_armor_frag.png",
})

minetest.register_craft({
	output = 'default:gold_ingot 2',
	recipe = {
		{'qt_mobs:armor_frag_gold'},
	}
})

minetest.register_craftitem("qt_mobs:armor_frag_steel", {
	description = "Steel Armor Fragments",
	inventory_image = "steel_armor_frag.png",
})

minetest.register_craft({
	output = 'default:steel_ingot 2',
	recipe = {
		{'qt_mobs:armor_frag_steel'},
	}
})

qt_mobs:register_mob("qt_mobs:zombie", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"zombie.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "qt_mobs:rotten_flesh",
		chance = 1,
		min = 1,
		max = 4,},
		{name = "default:steel_ingot",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 150,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "zombie",
	sounds = {
		random = "undead_mob_grunt",
	},
})

qt_mobs:register_spawn("qt_mobs:zombie", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_zombie", {
	description = "Spawn Zombie",
	inventory_image = "spawn_zombie.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:zombie")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_zombie", {
	description = "Zombie Spawner",
	paramtype = "light",
	tiles = {"zombie_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


minetest.register_abm({
	nodenames = {"qt_mobs:spawner_zombie"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:zombie" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:zombie")
			end
		end
	end
 })

qt_mobs:register_mob("qt_mobs:zombie_armored", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"zombie_armored.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "qt_mobs:rotten_flesh",
		chance = 1,
		min = 1,
		max = 4,},
		{name = "qt_mobs:armor_frag_steel",
		chance = 2,
		min = 1,
		max = 4,},
		{name = "qt_mobs:armor_frag_mese",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 125,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "zombie",
	sounds = {
		random = "undead_mob_grunt",
	},
})
qt_mobs:register_spawn("qt_mobs:zombie_armored", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_zombie_armored", {
	description = "Spawn Armored Zombie",
	inventory_image = "spawn_zombie.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:zombie_armored")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_zombie_armored", {
	description = "Armored Zombie Spawner",
	paramtype = "light",
	tiles = {"zombie_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_zombie_armored"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:zombie_armored" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:zombie_armored")
			end
		end
	end
 })

qt_mobs:register_mob("qt_mobs:zombie_elite", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"zombie_elite.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "qt_mobs:rotten_flesh",
		chance = 1,
		min = 1,
		max = 4,},
		{name = "qt_mobs:armor_frag_gold",
		chance = 2,
		min = 1,
		max = 4,},
		{name = "qt_mobs:armor_frag_diamond",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "zombie",
	sounds = {
		random = "undead_mob_grunt",
	},
})
qt_mobs:register_spawn("qt_mobs:zombie_elite", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_zombie_elite", {
	description = "Spawn Elite Zombie",
	inventory_image = "spawn_zombie.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:zombie_elite")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_zombie_elite", {
	description = "Elite Zombie Spawner",
	paramtype = "light",
	tiles = {"zombie_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_zombie_elite"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:zombie_elite" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:zombie_elite")
			end
		end
	end
 })

qt_mobs:register_mob("qt_mobs:skeleton", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"skeleton.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "default:bone",
		chance = 1,
		min = 2,
		max = 4,},
		{name = "default:steel_ingot",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 150,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "skeleton",
	sounds = {
		random = "skeleton",
	},
})
qt_mobs:register_spawn("qt_mobs:skeleton", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_skeleton", {
	description = "Spawn Skeleton",
	inventory_image = "spawn_skeleton.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:skeleton")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_skeleton", {
	description = "Skeleton Spawner",
	paramtype = "light",
	tiles = {"skeleton_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_skeleton"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:skeleton" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:skeleton")
			end
		end
	end
 })

qt_mobs:register_mob("qt_mobs:skeleton_advanced", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"skeleton_advanced.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "default:default_bone",
		chance = 1,
		min = 2,
		max = 4,},
		{name = "qt_mobs:armor_frag_steel",
		chance = 2,
		min = 1,
		max = 4,},
		{name = "qt_mobs:armor_frag_mese",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 125,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "skeleton",
	sounds = {
		random = "skeleton",
	},
})
qt_mobs:register_spawn("qt_mobs:skeleton_advanced", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_skeleton_advanced", {
	description = "Spawn Advanced Skeleton",
	inventory_image = "spawn_skeleton.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:skeleton_advanced")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_skeleton_advanced", {
	description = "Advanced Skeleton Spawner",
	paramtype = "light",
	tiles = {"skeleton_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_skeleton_advanced"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:skeleton_advanced" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:skeleton_advanced")
			end
		end
	end
 })

qt_mobs:register_mob("qt_mobs:skeleton_carbonized", {
	type = "monster",
	hp_max = 10,
	collisionbox = {-0.4, -1, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "basic_zombie.x",
	textures = {"skeleton_carbonic.png"},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 1,
	drops = {
		{name = "default:coal_lump",
		chance = 1,
		min = 3,
		max = 6,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 125,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 188,
		run_start = 168,
		run_end = 188,
		punch_start = 0,
		punch_end = 79,
	},
	allience = "skeleton",
	sounds = {
		random = "skeleton",
	},
})
qt_mobs:register_spawn("qt_mobs:skeleton_carbonized", {"default:dirt_with_grass", "default:dirt", "default:stone", "default:sand", "default:desert_sand"}, 3, -1, 900, 3, 31000)

minetest.register_craftitem("qt_mobs:spawn_skeleton_carbonized", {
	description = "Spawn Carbonized Skeleton",
	inventory_image = "spawn_skeleton_carbonized.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:skeleton_carbonized")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_skeleton_carbonized", {
	description = "Carbonized Skeleton Spawner",
	paramtype = "light",
	tiles = {"carbonized_skeleton_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_skeleton_carbonized"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:skeleton_carbonized" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 8 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:skeleton_carbonized")
			end
		end
	end
 })


qt_mobs:register_mob("qt_mobs:boss_grim_reaper", {
	type = "monster",
	hp_max = 125,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "grim_reaper.x",
	textures = {"grim_reaper.png"},
	visual_size = {x=5, y=5},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1.5,
	damage = 3,
	drops = {
		{name = "default:obsidian",
		chance = 2,
		min = 3,
		max = 6,},
		{name = "default:gold_ingot",
		chance = 2,
		min = 0,
		max = 1,},
	},
	armor = 80,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 36,
		run_start = 37,
		run_end = 49,
		punch_start = 37,
		punch_end = 49,
		speed_normal = 15,
		speed_run = 15,
	},
	allience = "grim_reaper",
	sounds = {
		random = "grim_reaper",
	},
})

minetest.register_craftitem("qt_mobs:spawn_boss_grim_reaper", {
	description = "Spawn Grim Reaper Boss",
	inventory_image = "spawn_skeleton_carbonized.png",
	liquids_pointable = false,
	stack_max = 64,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			minetest.env:add_entity(p, "qt_mobs:boss_grim_reaper")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

minetest.register_node("qt_mobs:spawner_boss_grim_reaper", {
	description = "Criminal Spawner",
	paramtype = "light",
	tiles = {"grim_reaper_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",
	groups = {cracky=1,level=1},
	drop = "default:steel_ingot",
})


 minetest.register_abm({
	nodenames = {"qt_mobs:spawner_boss_grim_reaper"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 30)) do
			if obj:is_player() then
				player_near = true
			else
				if obj:get_luaentity().name == "qt_mobs:boss_grim_reaper" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < 8 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				--p.y = p.y+1
				local ll = minetest.env:get_node_light(p)
				local wtime = minetest.env:get_timeofday()
				if not ll then return end
				if ll > 20 then return end
				if ll < -1 then return end
				if minetest.env:get_node(p).name ~= "air" then return end
				p.y = p.y+1
				if minetest.env:get_node(p).name ~= "air" then return end
				if (wtime > 0.2 and wtime < 0.805) and pos.y > 0 then return end
				p.y = p.y-1
				minetest.env:add_entity(p, "qt_mobs:boss_grim_reaper")
			end
		end
	end
 })