local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local menubar = require("menubar")

local vars = require 'variables'

-- {{{ Launcher widget
local awesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", vars.manual_cmd },
   { "edit config", vars.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

-- Global as needed in binding/global/key.lua
-- So no need to create a getter
-- (As this no module imports other modules
-- but only his submodules)
mainmenu = awful.menu({ items = { { "awesome", awesomemenu, beautiful.awesome_icon },
                                    { "open terminal", vars.terminal }
                                  }
                        })

local launcher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Taglist widget
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local function create_taglist(s)
   s.taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
   }
end
-- }}}

-- Promptbox widget
local function create_promptbox(s)
    s.promptbox = awful.widget.prompt()
end

local _M = {}

-- Return all the left widgets for the wibox
function _M.get(s)
   create_taglist(s)
   create_promptbox(s)
   return
         launcher,
         s.taglist,
         s.promptbox
end

-- Return all the left widgets for the wibox
function _M.get(s)
   create_taglist(s)
   create_promptbox(s)
   return
         launcher,
         s.taglist,
         s.promptbox
end

return _M
