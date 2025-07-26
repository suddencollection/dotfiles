local temperature = {
	low = 45,
	high = 80,
	critical = 90,
}

local aw = require("awesome")
local icons = require("zbxi/icons")
local cmd = "sensors"

local sensor = "gigabyte_wmi-virtual-0"
local index = 3

local function getTemperature(stdout)
	assert(type(stdout) == "string", "Invalid input")

	-- For a reason I can't understand, using the top level 'sensor' and 'index' causes the text to freeze in time, hence the need for these copies
	local s = sensor
	local i = index

	-- iterate lines
	local iter = string.gmatch(stdout, "[^\r\n]+")

	for line in iter do
		if line == s then
			-- skip to choosen index
			while i ~= 0 do
				iter()
				i = i - 1
			end

			-- return temp
			line = iter()
			return tonumber(string.match(line, "(%d+)%.%d°C"))
		end
	end
	error("Something has gone very wrong. Check the configuration parameters.")
end

local function getLevel(temp)
	assert(type(temp) == "number", "Invalid input.")
	return 0
end

return function(updateTime)
	assert(
		type(updateTime) == "number",
		"Invalid input. 1° parameter is the update time in seconds, and must be a number."
	)
	assert(updateTime > 0, "Invalid input. 1° parameter must be higher than 0.")

	return aw.awful.widget.watch(cmd, updateTime, function(widget, stdout)
		local temp = getTemperature(stdout)
		local icon = icons["thermometer_" .. getLevel(temp)]
		widget:set_text(icon .. " " .. temp .. "°C")
	end)
end
