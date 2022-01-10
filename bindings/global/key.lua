local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local vars = require 'variables'
local mod = require 'bindings.mod'

local globalkeys = gears.table.join(
    -- Awesome
    awful.key({ mod.super,           },   -- Mod keys
              "s",                        -- Key
              hotkeys_popup.show_help,    -- On press
              {description="show help",   -- Description
              group="awesome"}),          -- Group
    awful.key({ mod.super,           },
              "w",
              function () mainmenu:show() end,
              {description = "show main menu",
              group = "awesome"}),
    awful.key({ mod.super, mod.ctrl },
              "r",
              awesome.restart,
              {description = "reload awesome",
              group = "awesome"}),
    awful.key({ mod.super, mod.shift   },
              "q",
              awesome.quit,
              {description = "quit awesome",
              group = "awesome"}),
    awful.key({ mod.super },
              "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().promptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt",
              group = "awesome"}),
    -- Tag
    awful.key({ mod.super,           }, 
              "Left",
              awful.tag.viewprev,
              {description = "view previous",
              group = "tag"}),       
    awful.key({ mod.super,           },
              "Right",
              awful.tag.viewnext,
              {description = "view next",
              group = "tag"}),
    awful.key({ mod.super,           },
              "Escape",
              awful.tag.history.restore,
              {description = "go back",
              group = "tag"}),
    -- Client
    awful.key({ mod.super,           },
              "j",
              function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index",
              group = "client"}),
    awful.key({ mod.super,           },
              "k",
              function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", 
              group = "client"}),
    awful.key({ mod.super, mod.shift  },
              "j",
              function () awful.client.swap.byidx(  1) end,
              {description = "swap with next client by index",
              group = "client"}),
    awful.key({ mod.super, mod.shift   },
              "k", function () awful.client.swap.byidx( -1) end,
              {description = "swap with previous client by index",
              group = "client"}),
    awful.key({ mod.super,           },
              "u",
              awful.client.urgent.jumpto,
              {description = "jump to urgent client",
              group = "client"}),
    awful.key({ mod.super,           },
              "Tab",
              function ()
                  awful.client.focus.history.previous()
                  if client.focus then
                      client.focus:raise()
                  end
              end,
              {description = "go back",
              group = "client"}),
    awful.key({ mod.super, mod.ctrl },
              "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized",
              group = "client"}),
    -- Screen
    awful.key({ mod.super, mod.ctrl },
              "j",
              function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen",
              group = "screen"}),
    awful.key({ mod.super, mod.ctrl },
              "k",
              function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen",
              group = "screen"}),
    -- Launcher
    awful.key({ mod.super,           },
              "Return",
              function () awful.spawn(vars.terminal) end,
              {description = "open a terminal",
              group = "launcher"}),
    awful.key({ mod.super },
              "r",
              function () awful.screen.focused().promptbox:run() end,
              {description = "run prompt",
              group = "launcher"}),
    awful.key({ mod.super },
              "p",
              function() menubar.show() end,
              {description = "show the menubar",
              group = "launcher"}),
    -- Layout
    awful.key({ mod.super,           },
              "l",
              function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor",
              group = "layout"}),
    awful.key({ mod.super,           },
              "h",
              function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor",
              group = "layout"}),
    awful.key({ mod.super, mod.shift   },
              "h",
              function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients",
              group = "layout"}),
    awful.key({ mod.super, mod.shift   },
              "l",
              function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients",
              group = "layout"}),
    awful.key({ mod.super, mod.ctrl },
              "h",
              function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns",
              group = "layout"}),
    awful.key({ mod.super, mod.ctrl },
              "l",
              function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns",
              group = "layout"}),
    awful.key({ mod.super,           },
              "space",
              function () awful.layout.inc( 1) end,
              {description = "select next",
              group = "layout"}),
    awful.key({ mod.super, mod.shift   },
              "space",
              function () awful.layout.inc(-1) end,
              {description = "select previous",
              group = "layout"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, vars.tagscount do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ mod.super }, "#" .. i + vars.tagscount,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ mod.super, mod.ctrl }, "#" .. i + vars.tagscount,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ mod.super, mod.shift }, "#" .. i + vars.tagscount,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ mod.super, mod.ctrl, mod.shift }, "#" .. i + vars.tagscount,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Set keys
root.keys(globalkeys)
