
local threshold = 7
local min = 1
local max = 10
local current = 5

function unified_weather.is_raining()
	return current > threshold
end


local timer = 0
minetest.register_globalstep(function(dtime)

	timer = timer + dtime
	if timer < 2 then
		return
	end
	timer=0

	if math.random(2) == 1 then
		current = current + 0.5
	else
		current = current - 0.5
	end

	if current > max then
		current = max
	elseif current < min then
		current = min
	end


end)


minetest.register_chatcommand("weather_forecast", {
	func = function()
		return true, current
	end
})
