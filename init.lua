local MP = minetest.get_modpath("unified_weather")

unified_weather = {}

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

local function get_biome_name(pos)
	local biome_data = minetest.get_biome_data(pos)
	return minetest.get_biome_name(biome_data.biome)
end

local function get_biome_intensity(center_pos, biome_name)
	local intensity = 0
	local increment = 15
	local west_pos = vector.add(center_pos, {x=-increment, y=0, z=0 })
	local north_pos = vector.add(center_pos, {x=0, y=0, z=increment })
	local east_pos = vector.add(center_pos, {x=increment, y=0, z=0 })
	local south_pos = vector.add(center_pos, {x=0, y=0, z=-increment })

	if get_biome_name(center_pos) == biome_name then
		intensity = intensity + 0.2
	end
	if get_biome_name(west_pos) == biome_name then
		intensity = intensity + 0.2
	end
	if get_biome_name(north_pos) == biome_name then
		intensity = intensity + 0.2
	end
	if get_biome_name(east_pos) == biome_name then
		intensity = intensity + 0.2
	end
	if get_biome_name(south_pos) == biome_name then
		intensity = intensity + 0.2
	end

	return intensity
end

minetest.register_globalstep(function(dtime)

  for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:get_pos()
		local intensity

		intensity = get_biome_intensity(ppos, "snowy_grassland")
		intensity = intensity  + get_biome_intensity(ppos, "taiga")

		if intensity > 0 then
			local weather_def = unified_weather.get_weather("snow")

			if weather_def then
				weather_def.on_step(player, dtime, intensity)
			end
		end
  end

end)


minetest.register_chatcommand("get_biome", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local ppos = player:get_pos()

		local biome_data = minetest.get_biome_data(ppos)
		local biome_name = minetest.get_biome_name(biome_data.biome)

		return true, biome_name
	end
})
