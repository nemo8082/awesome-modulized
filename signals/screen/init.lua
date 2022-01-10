local awful = require("awful")

local vars = require 'variables'
local wallpaper = require 'widgets/wallpaper'
local wibox = require 'widgets/wibox'

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", wallpaper.set_wallpaper)

-- Add widgets for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    wallpaper.set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(vars.tags, s, awful.layout.layouts[1])
    
    -- Build the wibox
    wibox.create(s)
end)

