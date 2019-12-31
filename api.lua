
local data = {} -- name -> def

function unified_weather.register_weather(name, def)
	data[name] = def
end

function unified_weather.get_weather(name)
	return data[name]
end
