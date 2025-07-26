#!/usr/bin/env lua

local commands = {
	get_master = [[amixer get Master]],
	increase_volume = [[amixer set 'Master' 5%+]],
	decrease_volume = [[amixer set 'Master' 5%-]],
	mute_volume = [[amixer set 'Master' toggle]],
}

local function getVolume(stdout)
	assert(type(stdout) == "string", "Invalid input")

	local iter = stdout:gmatch("%[(%d+)%%%]")
	return math.floor((tonumber(iter()) + tonumber(iter())) / 2)
	-- error("Something has gone very wrong. Check the configuration parameters.")
end

local function getLevelIcon(volume)
	if volume == 0 then
		return "󰖁"
	elseif volume < 40 then
		return "󰕿"
	elseif volume < 70 then
		return "󰖀"
	else
		return "󰕾"
	end
end

local volume = getVolume(io.popen(commands.get_master):read("*a"))
local icon = getLevelIcon(volume)

if volume < 10 then
	print(volume --[=[.. "% "]=]) -- this space is a special unicode character
else
	print(volume --[=[.. "% "]=])
end
