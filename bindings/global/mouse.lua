local awful = require("awful")
local gears = require("gears")

root.buttons(gears.table.join(
    awful.button({ },                                   -- Modkey
                 3,                                     -- Button
                 function () mainmenu:toggle() end--,   -- On press
                 ),                                     -- On release (optional)
    awful.button({ }, 
                 4,
                 awful.tag.viewnext),
    awful.button({ },
                 5,
                 awful.tag.viewprev)
))
