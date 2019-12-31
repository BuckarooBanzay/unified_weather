
-- checks if the position is inside (has a solid roof)
function unified_weather.is_pos_inside(pos)
	for y=pos.y+2, pos.y+20 do
		local node = minetest.get_node_or_nil({ x=pos.x, y=y, z=pos.z })
		if node and node.name ~= "air" then
			return true
		end
	end

	return false
end
