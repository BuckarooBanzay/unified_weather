local MP = minetest.get_modpath("unified_weather")

unified_weather = {

}

dofile(MP.."/register.lua")
dofile(MP.."/cycle.lua")



minetest.register_chatcommand("rain_test", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local ppos = player:get_pos()

		minetest.add_particlespawner({
			amount = 1000,
			time = 5,
			minpos = vector.add(ppos, {x=-10, y=10, z=-10}),
			maxpos = vector.add(ppos, {x=10, y=10, z=10}),
			minvel = {x=2, y=-5, z=0},
			maxvel = {x=2, y=-12, z=0},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 1,
			maxexptime = 5,
			minsize = 20,
			maxsize = 30.7,
			collisiondetection = true,
			collision_removal = true,
			object_collision = true,
			vertical = true,
			texture = "weather_rain.png",
			playername = name
		})
	end
})


minetest.register_chatcommand("snow_test", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local ppos = player:get_pos()

		minetest.add_particlespawner({
			amount = 1000,
			time = 5,
			minpos = vector.add(ppos, {x=-10, y=5, z=-10}),
			maxpos = vector.add(ppos, {x=10, y=10, z=10}),
			minvel = {x=0.5, y=-1, z=0},
			maxvel = {x=1, y=-3, z=0},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 1,
			maxexptime = 5,
			minsize = 20,
			maxsize = 30.7,
			collisiondetection = true,
			collision_removal = true,
			object_collision = true,
			vertical = true,
			texture = "weather_snow.png",
			playername = name
		})
	end
})
