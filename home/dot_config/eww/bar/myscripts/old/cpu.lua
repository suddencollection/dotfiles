#!/usr/bin/env lua

local aw = require("awesome")
local icons = require("zbxi/icons")

local cmd = [[head -n 1 /proc/stat]]
local pattern = [[(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)]]

local prev = {
  idle = 0,
  total = 0,
}

return function(updateTime)
  assert(
    type(updateTime) == "number",
    "Invalid input. 1° parameter is the update time in seconds, and must be a number."
  )
  assert(updateTime > 0, "Invalid input. 1° parameter must be higher than 0.")
  return aw.awful.widget.watch(cmd, updateTime, function(widget, stdout)
    -- interpret
    local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ = stdout:match(pattern)
    local total = user + nice + system + idle + iowait + irq + softirq + steal
    local diff_idle = idle - tonumber(prev.idle)
    local diff_total = total - tonumber(prev.total)
    local diff_usage = (100 * (diff_total - diff_idle) / (diff_total + 5))

    -- store date for the next iteration
    prev.total = total
    prev.idle = idle

    -- build
    widget:set_text(icons.cpu .. " " .. math.floor(diff_usage + 0.5)--[=[ .. "%"]=])
  end)
end
