--[[ 
This is the default configuration of Awesome 4.3. But it is modularized!
The default one given in documentation isn't modularized at all. 
And it is hard to understand. That probably not perfect but this version of the 
deafult config is easier to understand and it is a better place to start with (imo).
     °
    ° o°
      ° o °   ______
      °O °   /.     \ /|
        ° O 8    V   x |
             \______/ \|

Modularized as following :
     |  -rc.lua-
     |  -> Handle startup errors
     |  -> Load theme
     |  -> |  [widgets]
     |     |  -> |  [wallpaper]
     |     |     |  -> Set the wallpaper
     |     |
     |     |  -> |  [wibox]
     |     |       |  -> Set the wibox widget
     |     |       |  -> |  [left]
     |     |       |     |  -> Widgets to the left of the wibox
     |     |       |
     |     |       |  -> |  [middle]
     |     |       |     |  -> Widgets to the middle of the wibox
     |     |       |
     |     |       |  -> |  [right]
     |     |       |     |  -> Widgets to the right of the wibox
     |
     |  -> |  [bindings]
     |     |  -> |  [global]
     |     |     |  -> |  [key]
     |     |     |     |  -> Manage global key bindings
     |     |     |
     |     |     |  -> |  [mouse]
     |     |     |     |  -> Manage global mouse bindings
     |     |
     |     |  -> |  [client]
     |     |     |  -> |  [key]
     |     |     |     |  -> Manage clients key bindings
     |     |     |
     |     |     |  -> |  [mouse]
     |     |     |     |  -> Manage clients mouse bindings
     |     |
     |     |  -> | -mod.lua-
     |     |     |  -> Defines mod keys
     |
     |  -> |  [rules]
     |     |  -> Defines rules
     | 
     |  -> |  [signals]
     |     |  -> |  [awesome]
     |     |     |  -> Manage awesome signals
     |     |
     |     |  -> |  [screen]
     |     |     |  -> Manage screens signals
     |     |
     |     |  -> |  [client]
     |     |     |  -> Manage clients signals

Nemo : 01/2022
]]

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local beautiful = require("beautiful")
local naughty = require("naughty")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Theme
beautiful.init("~/.config/awesome/themes/lgbt/theme.lua")

require 'widgets'
require 'bindings'
require 'rules'
require 'signals'
