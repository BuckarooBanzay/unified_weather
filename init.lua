local MP = minetest.get_modpath("unified_weather")

unified_weather = {
	state = {}
}

dofile(MP.."/api.lua")
dofile(MP.."/weather.lua")
dofile(MP.."/common.lua")
dofile(MP.."/snow.lua")
dofile(MP.."/rain.lua")


minetest.register_on_joinplayer(function(player)
end)

minetest.register_on_leaveplayer(function(player)
	unified_weather.state[player:get_player_name()] = nil
end)


minetest.register_globalstep(function(dtime)
  for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:get_pos()
		local playername = player:get_player_name()

		local biome_data = minetest.get_biome_data(ppos)
		local biome_name = minetest.get_biome_name(biome_data.biome)

		if biome_name == "snowy_grassland" then
			unified_weather.state[playername] = "snow"
		else
			unified_weather.state[playername] = nil
		end

  end

end)

minetest.register_globalstep(function(dtime)
	local is_raining = unified_weather.is_raining()

  for _, player in ipairs(minetest.get_connected_players()) do
		local playername = player:get_player_name()

		local weather_name = unified_weather.state[playername]
		local weather_def = unified_weather.get_weather(weather_name)

		if weather_def and is_raining then
			weather_def.on_step(player, dtime)
		end
  end

end)


minetest.register_chatcommand("weather", {
	func = function(name, params)
		unified_weather.state[name] = params
	end
})

minetest.register_chatcommand("get_biome", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local ppos = player:get_pos()

		local biome_data = minetest.get_biome_data(ppos)
		local biome_name = minetest.get_biome_name(biome_data.biome)

		return true, biome_name
	end
})
