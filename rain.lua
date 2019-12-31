local timer = 0

unified_weather.register_weather("rain", {
	on_step = function(player, dtime)
		timer = timer + dtime
		if timer < 2 then return end
		timer=0

		local ppos = player:get_pos()
		local player_name = player:get_player_name()
		local is_inside = unified_weather.is_pos_inside(ppos)

		if math.random(2) == 1 then
			local gain = 1.0

			if is_inside then
				gain = 0.2
			end

			minetest.sound_play("unified_weather_rain", {
				to_player = player_name,
				gain = gain,
				fade = 0.5,
				pos = vector.add(ppos, {x=0, y=5, z=0})
			})
		end

		minetest.add_particlespawner({
			amount = 250,
			time = 2,
			minpos = vector.add(ppos, {x=-20, y=10, z=-20}),
			maxpos = vector.add(ppos, {x=20, y=10, z=20}),
			minvel = {x=0, y=-10, z=0},
			maxvel = {x=0, y=-12, z=0},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 5,
			maxexptime = 5,
			minsize = 2,
			maxsize = 3,
			collisiondetection = true,
			collision_removal = true,
			object_collision = true,
			vertical = true,
			texture = "unified_weather_rain.png",
			playername = player_name
		})


	end
})
