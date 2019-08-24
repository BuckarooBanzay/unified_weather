local MP = minetest.get_modpath("unified_weather")

unified_weather = {
	state = {} -- playername -> weather_def
}

-- dofile(MP.."/register.lua")
-- dofile(MP.."/cycle.lua")


minetest.register_on_joinplayer(function(player)
end)

minetest.register_on_leaveplayer(function(player)
	unified_weather.state[player:get_player_name()] = nil
end)


function update_weather(player, def)
	local ppos = player:get_pos()
	local player_name = player:get_player_name()

	if def == "rain" then
		player:set_sky({r=150, g=150, b=150},"plain",{})
		player:set_clouds({
			thickness=16,
			color={r=243, g=214, b=255, a=229},
			ambient={r=0, g=0, b=0, a=255},
			density=0.9,
			height=100,
			speed={y=-2,x=-1}
		})

		if math.random(2) == 1 then
			minetest.sound_play("unified_weather_rain", {
				to_player = player_name,
				gain = 1.0,
				fade = 0.5,
				pos = vector.add(ppos, {x=0, y=5, z=0})
			})
		end

		minetest.add_particlespawner({
			amount = 1000,
			time = 2,
			minpos = vector.add(ppos, {x=-20, y=10, z=-20}),
			maxpos = vector.add(ppos, {x=20, y=10, z=20}),
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
			playername = player_name
		})
	elseif def == "snow" then
		minetest.add_particlespawner({
			amount = 1000,
			time = 5,
			minpos = vector.add(ppos, {x=-20, y=5, z=-20}),
			maxpos = vector.add(ppos, {x=20, y=10, z=20}),
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
			playername = player_name
		})
	else
		player:set_sky({r=0, g=0, b=0},"regular",{})
		player:set_clouds({
			thickness=16,
			color={r=243, g=214, b=255, a=229},
			ambient={r=0, g=0, b=0, a=255},
			density=0.4,
			height=100,
			speed={y=-2,x=-1}
		})
	end
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 2 then return end
	timer=0

  for _, player in ipairs(minetest.get_connected_players()) do
		local playername = player:get_player_name()
		local weather_def = unified_weather.state[playername]

		if weather_def then
			update_weather(player, weather_def)
		end
  end

end)


minetest.register_chatcommand("weather", {
	func = function(name, params)
		unified_weather.state[name] = params
	end
})
