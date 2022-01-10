local awful = require("awful")
local wibox = require("wibox")

local leftwidgets = require 'widgets/wibox/left'
local middlewidgets = require 'widgets/wibox/middle'
local rightwidgets = require 'widgets/wibox/right'

-- Create the wibox
local function create_wibox(s)
    s.wibox = awful.wibar({ position = "top", screen = s })
end

-- Add widgets to the wibox
local function setup_wibox(s)
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            leftwidgets.get(s)
        },
        -- Middle widgets
        middlewidgets.get(s),
        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            rightwidgets.get(s)
        },
    }
end

local _M = {}

-- Build the wibox
function _M.create(s)
    create_wibox(s)
    setup_wibox(s)
end

return _M

