

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 2 then return end
	timer=0

  for _, player in ipairs(minetest.get_connected_players()) do
    local pos = player:get_pos()
    local data = minetest.get_biome_data(pos) -- biome, heat, humidity
    local biome_name = minetest.get_biome_name(data.biome)

    print("Player: pos=" .. minetest.pos_to_string(pos) .. " biome=" .. biome_name ..
      " heat=" .. data.heat .. " humidity=" .. data.humidity)
  end

end)
