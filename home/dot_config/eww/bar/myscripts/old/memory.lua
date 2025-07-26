--------------------------

local aw = require("awesome")
local icons = require("zbxi/icons")

local cmd = [[head -n 3 /proc/meminfo]]
local pattern = [[(%d+)]]

return function(updateTime)
  assert(
    type(updateTime) == "number",
    "Invalid input. 1° parameter is the update time in seconds, and must be a number."
  )
  assert(updateTime > 0, "Invalid input. 1° parameter must be higher than 0.")
  return aw.awful.widget.watch(cmd, updateTime, function(widget, stdout)
    local iter = stdout:gmatch(pattern)
    local total, _, available = iter(), iter(), iter()
    local percentage = math.floor((((total - available) / total) * 100) + 0.5)
    widget:set_text(icons.ram .. " " .. percentage --[=[.. "%"]=])
  end)
end
