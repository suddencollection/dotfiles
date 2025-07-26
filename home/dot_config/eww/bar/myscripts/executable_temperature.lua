#!/usr/bin/env lua

local cmd = "sensors"
-- local sensor = "gigabyte_wmi-virtual-0"
-- local index = 3
local info = {
	sensor = "k10temp-pci-00c3",
	index = 1,
}

local function getTemperature(stdout)
	assert(type(stdout) == "string", "Invalid input")

	-- For a reason I can't understand, using the top level 'sensor' and 'index' causes the text to freeze in time, hence the need for these copies

	-- iterate lines
	local iter = string.gmatch(stdout, "[^\r\n]+")

	for line in iter do
		if line == info.sensor then
			-- skip to choosen index
			while info.index ~= 0 do
				iter()
				info.index = info.index - 1
			end

			-- return temp
			line = iter()
			return tonumber(string.match(line, "(%d+)%.%d°C"))
		end
	end
	error("Something has gone very wrong. Check the configuration parameters.")
end

-- local function getLevelIcon(temp)
-- 	assert(type(temp) == "number", "Invalid input.")
--
-- 	if temp >= 90 then
-- 		return ""
-- 	elseif temp >= 80 then
-- 		return ""
-- 	elseif temp >= 70 then
-- 		return ""
-- 	elseif temp >= 60 then
-- 		return ""
-- 	else
-- 		return ""
-- 	end
-- end
--
-- local currentLevel = getLevelIcon(currentTemp)

local currentTemp = getTemperature(io.popen(cmd):read("*a"))
print(currentTemp --[=[.. "°C"]=])
