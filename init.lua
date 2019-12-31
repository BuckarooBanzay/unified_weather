local MP = minetest.get_modpath("unified_weather")

unified_weather = {
	state = {} -- playername -> weather_def
}

dofile(MP.."/api.lua")
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
		local playername = player:get_player_name()
		local weather_name = unified_weather.state[playername]
		local weather_def = unified_weather.get_weather(weather_name)

		if weather_def then
			weather_def.on_step(player, dtime)
		end
  end

end)


minetest.register_chatcommand("weather", {
	func = function(name, params)
		unified_weather.state[name] = params
	end
})
