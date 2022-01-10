local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Keyboard layout switcher widget
keyboardlayout = awful.widget.keyboardlayout()

-- Clock widget
textclock = wibox.widget.textclock()

-- System tray widget
systray = wibox.widget.systray()

-- Layout selection widget
local function create_layoutbox(s)
   s.layoutbox = awful.widget.layoutbox(s)
   s.layoutbox:buttons(gears.table.join(
                       awful.button({ }, -- Modkey
                                    1,   -- Button
                                    function () awful.layout.inc( 1) end), -- On press
                       awful.button({ }, 3, function () awful.layout.inc(-1) end),
                       awful.button({ }, 4, function () awful.layout.inc( 1) end),
                       awful.button({ }, 5, function () awful.layout.inc(-1) end)))
end

local _M = {}

function _M.get(s)
   create_layoutbox(s)
   return
         keyboardlayout,
         wibox.widget.systray(),
         textclock,
         s.layoutbox
end

return _M
