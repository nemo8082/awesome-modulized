local awful = require("awful")
local gears = require("gears")

local mod = require 'bindings.mod'

-- Global as needed in /rules
-- So no need to create a getter
-- (As this no module imports other modules
-- but only his submodules)
clientbuttons = gears.table.join(
    awful.button({ },          -- Modkey
                 1,            -- Button
                 function (c)  -- On press
                     c:emit_signal("request::activate", "mouse_click", {raise = true})
                 end
                 ),            -- On release (optional)
    awful.button({ mod.super },
                 1,
                 function (c)
                     c:emit_signal("request::activate", "mouse_click", {raise = true})
                     awful.mouse.client.move(c)
                 end),
    awful.button({ mod.super },
                 3,
                 function (c)
                     c:emit_signal("request::activate", "mouse_click", {raise = true})
                     awful.mouse.client.resize(c)
                 end)
)
