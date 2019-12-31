local timer = 0

unified_weather.register_weather("snow", {
	interval = 2.0,
	on_step = function(player, dtime)
		timer = timer + dtime
		if timer < 2 then return end
		timer=0

		local ppos = player:get_pos()
		local player_name = player:get_player_name()

		minetest.add_particlespawner({
	    amount = 500,
	    time = 5,
	    minpos = vector.add(ppos, {x=-20, y=10, z=-20}),
	    maxpos = vector.add(ppos, {x=20, y=10, z=20}),
	    minvel = {x=0, y=-1.5, z=0},
	    maxvel = {x=0, y=-2, z=0},
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
