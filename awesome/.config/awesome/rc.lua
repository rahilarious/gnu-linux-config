-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local lain = require("lain")
local freedesktop = require("freedesktop")
local markup = lain.util.markup



-- ####### Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- #######

-- ####### Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/osmtheme/theme.lua")

terminal = "st"
editor = os.getenv("EDITOR") or "emacs -nw"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.floating,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- #######

-- ####### Helper functions
-- #######


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
		    -- left click to focus, mod+left will move to that tag
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
		    -- right click to toggle tags, mod+right click to copy to tag
		    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
		    -- scroll up and down to switch workspaces/tags whatever you wanna call it
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
		     -- left click focuses
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
		     awful.button({ }, 2, function (c) c:kill() end),
		     -- right click shows active windows/tasks
                     -- awful.button({ }, 3, client_menu_toggle_fn()),
		     -- scroll up and down to switch tasks
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))


awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])


    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
			   -- left, right, scroll up and down
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })


    -- ####### Wibar
    -- Create a textclock widget
    mytextclock = wibox.widget.textclock(markup("#7788af", "  %d-%m %a ") .. markup("#de5e1e", "  %I:%M %p "))


    -- Calendar
    beautiful.cal = lain.widget.cal({
        attach_to = { mytextclock },
        week_number = "right",
        notification_preset = {
            font = "Terminus 14",
            fg   = beautiful.fg_normal,
            bg   = beautiful.bg_normal
        }
    })    

--    local cpu = lain.widget.cpu({
--        settings = function()
--            widget:set_markup(markup.fontfg(beautiful.font, "#e33a6e", "  " .. cpu_now.usage .. "% "))
--        end,
--        timeout = 2
--    })
    
    local temp = lain.widget.temp({
        settings = function()
            widget:set_markup(markup.fontfg(beautiful.font, "#f1af5f", "  " .. coretemp_now .. "°C "))
        end,
        tempfile = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input",
        timeout = 2
    })
    
    local netdowninfo = wibox.widget.textbox()
    local netupinfo = lain.widget.net({
        settings = function()
            --[[ uncomment if using the weather widget
            if iface ~= "network off" and
            string.match(theme.weather.widget.text, "N/A")
            then
                theme.weather.update()
            end
            --]]
            
            widget:set_markup(markup.fontfg(beautiful.font, "#e54c62", "  " .. net_now.sent .. " KiB "))
            netdowninfo:set_markup(markup.fontfg(beautiful.font, "#87af5f", "  " .. net_now.received .. " KiB "))
        end,
        timeout = 2,
        
        
    })
    
--    local memory = lain.widget.mem({
--        settings = function()
--            widget:set_markup(markup.fontfg(beautiful.font, "#e0da37","  " .. mem_now.perc .. "% "))
--        end,
--        timeout = 2
--    })
    
    
    
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
	    s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            netupinfo.widget,
	        netdowninfo,
--            memory.widget,
--            cpu.widget,
            temp.widget,
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- #######
-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function(s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
end)

-- ####### Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- #######

-- ####### Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "i",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey , "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "s", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "s", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

	
	awful.key({modkey, "Control"}, "c", function() awful.spawn('firefox -P Cooku') end, {description = "Spying firefox", group = "programs"} ),
	awful.key({modkey, "Control"}, "e", function() awful.spawn('emacsclient -c') end, {description = "Emacs", group = "programs"} ),
	awful.key({modkey, "Control"}, "f", function() awful.spawn('firefox -P NiceBoi') end, {description = "firefox", group = "programs"} ),
	awful.key({modkey, "Control"}, "g", function() awful.spawn('copyq show') end, {description = "CopyQ", group = "programs"} ),
	awful.key({modkey, "Control"}, "h", function() awful.spawn(terminal .. " -e" .. " htop -t") end, {description = "htop", group = "programs"} ),
	awful.key({modkey, "Control"}, "i", function() awful.spawn('lxqt-config-input') end, {description = "LXQt Config", group = "programs"} ),
	awful.key({modkey, "Control"}, "k", function() awful.spawn('keepassxc') end, {description = "KeepassXC", group = "programs"} ),
	awful.key({modkey, "Control"}, "o", function() awful.spawn.with_shell('sudo openvpn --config /common/userconfig/openvpn/anony.ovpn') end, {description = "Start VPN", group = "programs"} ),
	awful.key({modkey, "Control"}, "p", function() awful.spawn('pavucontrol') end, {description = "Pavucontrol", group = "programs"} ),
	awful.key({modkey, "Control"}, "t", function() awful.spawn('thunderbird') end, {description = "Thunderbird", group = "programs"} ),
	awful.key({modkey, "Control"}, "v", function() awful.spawn('vlc') end, {description = "VLC media player", group = "programs"} ),

	awful.key({},'XF86AudioRaiseVolume', function() os.execute('pactl set-sink-volume @DEFAULT_SINK@ +10%') end, {description = "Increase Vol", group = "misc"} ),
	awful.key({},'XF86AudioLowerVolume', function() os.execute('pactl set-sink-volume @DEFAULT_SINK@ -10%') end, {description = "Decrease Vol", group = "misc"} ),
	awful.key({},'XF86AudioMute', function() os.execute('pactl set-sink-mute @DEFAULT_SINK@ toggle') end, {description = "Vol Mute Toggle", group = "misc"} ),
	awful.key({},'XF86MonBrightnessUp', function() os.execute('xbacklight -inc 5') end, {description = "Increase brightness", group = "misc"} ),
	awful.key({},'XF86MonBrightnessDown', function() os.execute('xbacklight -dec 5') end, {description = "Decrease brightness", group = "misc"} ),
	awful.key({},'XF86TouchpadToggle', function() awful.spawn.with_shell('~/.sexyscripts/toggletouchpad.sh') end, {description = "Toggle Touchpad", group = "misc"} ),
	awful.key({modkey},'z', function() awful.spawn.with_shell('~/.sexyscripts/i3lock.sh') end, {description = "Lock screen", group = "misc"} ),
	awful.key({},'Print', function() os.execute('flameshot gui') end, {description = "Take screenshot", group = "misc"} ),



awful.key({ modkey, "Shift" }, "n", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),



    -- Prompt
    awful.key({ modkey },            "Tab",     function () awful.spawn("rofi -show run")  end,
              {description = "run prompt", group = "launcher"})

)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey 	  }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey           }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey}, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
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
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
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

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- #######

-- ####### Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
	  "gcr-prompter",
          "Pavucontrol",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

}


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)


-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
--         and awful.client.focus.filter(c) then
--         client.focus = c
--     end
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)








-- startup script
awful.spawn.with_shell("~/.wmrc")

