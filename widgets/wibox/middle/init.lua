local awful = require("awful")
local gears = require("gears")

 -- Tasklist widget
local tasklist_buttons = gears.table.join(
    awful.button({ },           -- Modkey
                 1,             -- Button
                 function (c)   -- On press
                     if c == client.focus then
                         c.minimized = true
                     else
                         c:emit_signal(
                         "request::activate",
                         "tasklist",
                         {raise = true})
                     end
                 end
                 ),             -- On release (optional)
    awful.button({ }, 
                 3,
                 function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 
                 4, 
                 function () awful.client.focus.byidx(1) end),
    awful.button({ }, 
                 5, 
                 function () awful.client.focus.byidx(-1) end))

local function create_tasklist(s)
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }
end
-- }}}

local _M = {}

function _M.get(s)
   create_tasklist(s)
   return
       s.mytasklist
end

return _M
