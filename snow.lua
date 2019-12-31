local timer = 0

unified_weather.register_weather("snow", {
	on_step = function(player, dtime, intensity)
		timer = timer + dtime
		if timer < 2 then return end
		timer=0

		local ppos = player:get_pos()
		local player_name = player:get_player_name()
		local is_inside = unified_weather.is_pos_inside(ppos)

		local min_y = 2
		if is_inside then
			min_y = 10
		end

		--player:set_sky({r=0, g=0, b=0},"regular",{})
		player:set_sky({r=100, g=100, b=100},"plain",{})

		minetest.add_particlespawner({
	    amount = 500 * (intensity or 1),
	    time = 5,
	    minpos = vector.add(ppos, {x=-20, y=min_y, z=-20}),
	    maxpos = vector.add(ppos, {x=20, y=10, z=20}),
	    minvel = {x=0, y=-1.5, z=0},
	    maxvel = {x=0, y=-3, z=0},
	    minacc = {x=0, y=0, z=0},
	    maxacc = {x=0, y=0, z=0},
	    minexptime = 6,
	    maxexptime = 6,
	    minsize = 1,
	    maxsize = 1.4,
	    collisiondetection = true,
	    collision_removal = true,
	    object_collision = true,
	    vertical = true,
	    texture = "unified_weather_snowflake" .. math.random(1, 12) .. ".png",
	    playername = player_name
	  })

	end
})
