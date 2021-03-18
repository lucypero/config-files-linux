local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

-- NOTE(lucypero): Helper function to debug the config file. it will show up at
--  ~/.xsession-errors
local function print_debug(str)
    local line = debug.getinfo(1).currentline
    io.stderr:write(string.format("\n[LUCY MESSAGE AT LINE %i OF rc.lua]: %s\n", line, str))
end

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility

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

local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
-- choose your theme here
local theme_path = string.format("%s/.config/awesome/theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)

-- Bling - Utilities for AwesomeWM
local bling = require("bling")

-- NOTE(lucypero): What keys are modkeys on your system:
-- shift       Shift_L (0x32),  Shift_R (0x3e)
-- lock        Caps_Lock (0x9)
-- control     Control_L (0x25),  Control_R (0x69)
-- mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
-- mod2        Num_Lock (0x4d)
-- mod3
-- mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
-- mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)

-- NOTE(lucypero): You may want to use the key "Menu" (the one left to Control_R)


-- NOTE(lucypero): We run my xmodmap file that modifies the mod keys so that they work described as above.



-- TODO(lucypero): awesome is not getting variables from zshenv so i have to hard code programs for now...

-- personal variables
local browser           = os.getenv("BROWSER") or "brave"
local editor            = os.getenv("EDITOR") or "nvim"
-- local browser           = "brave"
-- local editor            = "nvim"
local editorgui         = "geany"
local filemanager       = "thunar"
local mailclient        = "geary"
local mediaplayer       = "mpv"
local terminal          = os.getenv("TERMINAL") or "kitty"

print_debug(string.format("browser is: %s, editor is %s", browser, editor))
-- resizing factor when resizing windows
local resizing_factor = 0.03

-- Set root cursor (default cursor icon)
root.cursor("boat")

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = {"1","2","3","4","5","6","7","8","9"}

local default_layout = awful.layout.suit.tile.right

-- set unique properties on each layout
local tags_description = {
    {},
    {
        -- gaps = 0,
    },
    {
        layout = awful.layout.suit.floating,
    },
    {},
    {},
    {},
    {},
    {},
    {},
}

awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    -- awful.layout.suit.tile,
    -- awful.layout.suit.floating,
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Creating tags
local function create_tags(screen)

    for i,v in ipairs(tags_description) do

        awful.tag.add(awful.util.tagnames[i], {
            screen = s,
            layout = v.layout or default_layout,
            gap = v.gaps or beautiful.useless_gap
        })
    end

    -- View tag 1 on startup
    root.tags()[1]:view_only()

end


-- awful.util.taglist_buttons = my_table.join(
--     awful.button({ }, 1, function(t) t:view_only() end),
--     awful.button({ "Mod4" }, 1, function(t)
--         if client.focus then
--             client.focus:move_to_tag(t)
--         end
--     end),
--     awful.button({ }, 3, awful.tag.viewtoggle),
--     awful.button({ "Mod4" }, 3, function(t)
--         if client.focus then
--             client.focus:toggle_tag(t)
--         end
--     end),
--     awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
--     awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
-- )

-- awful.util.tasklist_buttons = my_table.join(
--     awful.button({ }, 1, function (c)
--         if c == client.focus then
--             c.minimized = true
--         else
--             c:emit_signal("request::activate", "tasklist", {raise = true})
--         end
--     end),
--     awful.button({ }, 3, function ()
--         local instance = nil

--         return function ()
--             if instance and instance.wibox.visible then
--                 instance:hide()
--                 instance = nil
--             else
--                 instance = awful.menu.clients({theme = {width = 250}})
--             end
--         end
--     end),
--     awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
--     awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
-- )

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- Creating things for each screen
awful.screen.connect_for_each_screen(function(s)
    -- Init theme
    beautiful.at_screen_connect(s)

    -- Creating tags
    create_tags(s)
end)

root.buttons(my_table.join(
    -- awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    -- Win4 + scroll wheel: adjust volume
    -- only works if mouse is on no window...
    awful.button({"Mod4"}, 4, function() os.execute("amixer -q set 'Master' 5%+") end),
    awful.button({"Mod4"}, 5, function() os.execute("amixer -q set 'Master' 5%-") end)
))

-- NOTE(lucypero): Utility function to bind multiple key combinations to one action
local function make_keybind(keybinds, action, data)
    -- keybinds = [[{"Mod4"}, "r"], [{"Mod4"}, "o"]]
    local key_objs = {}
    for _, v in ipairs(keybinds) do
        for _, kb in ipairs(awful.key(v[1], v[2], action, data)) do
            table.insert(key_objs, kb)
        end
    end
    return key_objs
end

-- Runs script in ~/.scripts
local function run_script(script_name)
    awful.spawn.with_shell(string.format("%s/.scripts/%s", os.getenv("HOME"), script_name))
end

local function scrot_command(options)
    awful.spawn.with_shell("scrot $(xdg-user-dir PICTURES)/Screenshot_%Y-%m-%d-%Hh%Mm%Ss.png " .. options .. " " .. "-e 'xclip -selection clipboard -t image/png -i $f'") 
end

-- On the fly useless gaps change
local function useless_gaps_resize(thatmuch, s, t)
    local scr = s or awful.screen.focused()
    local tag = t or scr.selected_tag
    tag.gap = tag.gap + tonumber(thatmuch)
    awful.layout.arrange(scr)
end

globalkeys = my_table.join(


    -- -- Bling Tabs hotkeys

    awful.key({"Mod4", "Control"}, "1", function()
        bling.module.tabbed.pick()
        print_debug("tabbed pick")
    end,{description="tabbed pick"}),
    awful.key({"Mod4", "Control"}, "2", function()
        bling.module.tabbed.pop()
        print_debug("tabbed pop")
    end),
    awful.key({"Mod4"}, "Next", function()
        bling.module.tabbed.iter()
        print_debug("tabbed iter")
    end),
    awful.key({"Mod4"}, "Prior", function()
        bling.module.tabbed.iter(-1)
        print_debug("tabbed iter")
    end),

    -- Start up socials on workspace 3 (telegram and discord)
    awful.key({"Mod4", "Shift"}, "s", function()
        awful.spawn.single_instance("telegram-desktop")
        awful.spawn.single_instance("discord --disable-smooth-scrolling")
    end, {description = "Run social programs", group = "hotkeys"}),

    -- Rofi menu - Favorite programs
    awful.key({"Mod4"}, "F1", function() run_script("menu-fav-programs") end),
    -- Rofi menu - System
    awful.key({"Mod4"}, "F2", function() run_script("menu-system") end),
    -- Rofi menu - Switch Window
    awful.key({"Mod4"}, "w", function() awful.spawn("rofi -show window") end),
    -- Rofi menu - Select Emoji
    awful.key({"Mod4"}, "e", function() run_script("menu-emoji") end),
    -- Rofi menu - Kill Process
    awful.key({"Mod4"}, "F4", function() run_script("menu-killprocess") end),

    -- Start up browser
    awful.key({"Mod4", "Shift"}, "b", function() 
        awful.spawn(browser)
    end , {description = "spawn browser", group = "hotkeys"}),

    -- Set Layout from a dmenu. It calls my script 'change-layout' in ~/.scripts
    awful.key({"Mod4", "Mod1"}, "l", function() 
        run_script("change-layout")
    end , {description = "set layout", group = "hotkeys"}),


    -- {{{ Personal keybindings
    -- dmenu
    awful.key({ "Mod4" }, "r", function() awful.spawn("rofi -show run") end,
    {description = "Rofi - Run menu", group = "hotkeys"}),

    -- screenshots
    -- Print: Full screen screenshot
    awful.key({ }, "Print", function () scrot_command("") end,
        {description = "Full Screen", group = "screenshots"}),
    -- Ctrl + Print: Select an area for sreenshot
    awful.key({ "Control"           }, "Print", function () scrot_command("-a $(slop -f '%x,%y,%w,%h')") end,
        {description = "Interactively select rectangle", group = "screenshots"}),
    -- Ctrl + Alt + Print: Screenshot active window
    awful.key({ "Control", "Mod1"  }, "Print", function() scrot_command("-u") end,
        {description = "Focused Window", group = "screenshots"}),
    -- Personal keybindings}}}

    -- Hotkeys Awesome

    awful.key({ "Mod4",           }, "s",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    --------------------
    -- Layout navigation
    --------------------



    -- Mod4 + Tab: Switch to last focused worskpace
    awful.key({"Mod4"}, "Tab", awful.tag.history.restore,
              {description = "go back to previously focused tag", group = "tag"}),

    -- Mod4 + {Vim navigation keys, arrow keys}: Switching focus by direction
    make_keybind({{{ "Mod4" }, "j"},{{ "Mod4" }, "Down"}},
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    make_keybind({{{ "Mod4" }, "k"},{{ "Mod4" }, "Up"}},
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    make_keybind({{{ "Mod4" }, "h"},{{ "Mod4" }, "Left"}},
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    make_keybind({{{ "Mod4" }, "l"},{{ "Mod4" }, "Right"}},
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- Alt + Tab: Go back to previously focused client
    awful.key({"Mod1"}, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end),


    -- -- Alt + [Shift] + Tab: Cycling client focus
    -- awful.key({"Mod1"}, "Tab", function ()
    --     awful.client.focus.byidx(1)
    -- end),
    -- awful.key({"Mod1", "Shift"}, "Tab", function ()
    --     awful.client.focus.byidx(-1)
    -- end),

    --------------------
    -- Layout manipulation
    --------------------

    -- Mod4 + {t,T}: Modify gap size in current gag
    awful.key({ "Mod4"}, "t", function () 
                        local screen = awful.screen.focused()
                        local tag = screen.selected_tag
                        useless_gaps_resize(1,screen,tag)
                    end,
              {description = "Increase gap size in current tag", group = "tag"}),
    awful.key({ "Mod4", "Shift"}, "t", function () 
                        local screen = awful.screen.focused()
                        local tag = screen.selected_tag
                        useless_gaps_resize(-1,screen,tag)
                    end,
              {description = "Decrease gap size in current tag", group = "tag"}),

    -- Cycle through layouts : Mod4 + [Shift] + Space
    awful.key({ "Mod4"}, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ "Mod4", "Shift"}, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    -- Swap client position with the one on (direction) : Mod4 + Control + {vim direction keys,arrows}
    make_keybind({{{ "Mod4", "Control" }, "h"},{{ "Mod4", "Control" }, "Left"}}, function () awful.client.swap.global_bydirection("left")    end,
              {description = "Swap position with client on the left", group = "client"}),
    make_keybind({{{ "Mod4", "Control" }, "l"},{{ "Mod4", "Control" }, "Right"}}, function () awful.client.swap.global_bydirection("right")    end,
              {description = "Swap position with client on the right", group = "client"}),
    make_keybind({{{ "Mod4", "Control" }, "k"},{{ "Mod4", "Control" }, "Up"}}, function () awful.client.swap.global_bydirection("up")    end,
              {description = "Swap position with client on the up", group = "client"}),
    make_keybind({{{ "Mod4", "Control" }, "j"},{{ "Mod4", "Control" }, "Down"}}, function () awful.client.swap.global_bydirection("down")    end,
              {description = "Swap position with client on the down", group = "client"}),

    -- Resizing clients by increment : Mod4 + Mod1 + Shift + vim direction keys
    make_keybind({{{"Mod4", "Control", "Mod1"}, "h"},{{"Mod4", "Control", "Mod1"}, "Left"}}, function () awful.tag.incmwfact(-resizing_factor)    end),
    make_keybind({{{"Mod4", "Control", "Mod1"}, "l"},{{"Mod4", "Control", "Mod1"}, "Right"}},function () awful.tag.incmwfact(resizing_factor)    end),
    make_keybind({{{"Mod4", "Control", "Mod1"}, "k"},{{"Mod4", "Control", "Mod1"}, "Up"}}, function () awful.client.incwfact(-resizing_factor * 3)    end),
    make_keybind({{{"Mod4", "Control", "Mod1"}, "j"},{{"Mod4", "Control", "Mod1"}, "Down"}}, function () awful.client.incwfact(resizing_factor * 3)    end),

    -- Switching from and to maximized layout
    awful.key({ "Mod4" }, "m", function() 
        local current_layout = awful.layout.get(awful.screen.focused())
        if current_layout == awful.layout.suit.max then
            awful.layout.set(awful.layout.suit.tile.right)
        else
            awful.layout.set(awful.layout.suit.max)
        end
    end, {description = "Toggle between maximized and tiled layout", group = "client"}),

    --------------------
    -- Other
    --------------------


    -- Standard program
    awful.key({ "Mod4" }, "Return", function () awful.spawn(terminal) end,
              {description = "spawn terminal", group = "super"}),
    awful.key({ "Mod4", "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ "Mod4", "Shift"   }, "q",  function () awful.spawn.with_shell( '~/.dmenu/prompt "are you sure?" "killall awesome"' ) end,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ "Mod4", "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- ALSA volume control
    -- "Win+ [plus sign (numpad)]"
    awful.key({ "Mod4" }, "KP_Add", function()
        os.execute("amixer -q set 'Master' 5%+")
    end),

    -- TODO(lucypero): scroll wheel up for volume? how do u do that
    -- awful.key({ "Control" }, "+", volume_up),
    -- "Win + [minus sign (numpad)]"
    awful.key({ "Mod4" }, "KP_Subtract", function()
        os.execute("amixer -q set 'Master' 5%-")
    end)

)

clientkeys = my_table.join(


    -- Mod + T


    -- Mod4 + Shift + F: Toggle client floating state
    awful.key({"Mod4", "Shift"}, "f", function(c) c.floating = not c.floating end,
              {description = "toggle client floating state", group = "client"}),

    -- Mod4 + Shift + U: Togle client state maximized
    awful.key({"Mod4", "Shift"}, "u", function(c) c.maximized = not c.maximized end,
              {description = "toggle client maximized state", group = "client"}),

    awful.key({ "Mod4",           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ "Mod4"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "hotkeys"}),
    awful.key({ "Mod4", "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ "Mod4",           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ "Mod4",           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ "Mod4",           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,



        -- View tag only.
        awful.key({ "Mod4" }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        -- awful.key({ "Mod4", "Control" }, "#" .. i + 9,
        --           function ()
        --               local screen = awful.screen.focused()
        --               local tag = screen.tags[i]
        --               if tag then
        --                  awful.tag.viewtoggle(tag)
        --               end
        --           end,
        --           descr_toggle),
        -- Move client to tag.
        awful.key({ "Mod4", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ "Mod4", "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ "Mod4" }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ "Mod4" }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),
    -- Win4 + scroll wheel: adjust volume
    -- the scroll wheel event propagates to the clients but i can deal with that..
    awful.button({"Mod4"}, 4, function(c) os.execute("amixer -q set 'Master' 5%+") end,
        function(c) end),
    awful.button({"Mod4"}, 5, function(c) os.execute("amixer -q set 'Master' 5%-") end,
        function(c) end)

)

-- Set keys
root.keys(globalkeys)

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
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false,
                     callback = awful.client.setslave
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },

    -- Polybar
    { rule = {class = "Polybar"},
        properties = {border_width = 0, focusable = false, gap_width = 0} },

    -- Start programs at specific tags
    { rule = { class = "discord" },
        properties = { screen = 1, tag = awful.util.tagnames[3] } },
    { rule = { class = "Telegram" },
        properties = { screen = 1, tag = awful.util.tagnames[3] } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Blueberry",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Oblogout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "keepassxc",
          "KeePassXC",
          "veromix",
          "xtightvncviewer",
          "qbittorrent",
          "obs",
          "Pavucontrol",
          "Thunar",
          "kolourpaint",
          "Nitrogen"
      },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

}

-- all of this commented code was for the swallow feature

-- function is_terminal(c)
--     return (c.class and c.class:match("Alacritty")) and true or false
-- end

-- function copy_size(c, parent_client)
--     if not c or not parent_client then
--         return
--     end
--     if not c.valid or not parent_client.valid then
--         return
--     end
--     c.x=parent_client.x;
--     c.y=parent_client.y;
--     c.width=parent_client.width;
--     c.height=parent_client.height;
-- end
-- function check_resize_client(c)
--     if(c.child_resize) then
--         copy_size(c.child_resize, c)
--     end
-- end

-- client.connect_signal("property::size", check_resize_client)
-- client.connect_signal("property::position", check_resize_client)

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


    -- "Swallowing" feature.
    -- it's buggy so i am commenting it for now.
    -- if is_terminal(c) then
    --     return
    -- end
    -- local parent_client=awful.client.focus.history.get(c.screen, 1)
    -- if parent_client and is_terminal(parent_client) then
    --     parent_client.child_resize=c
    --     c.floating=true
    --     copy_size(c, parent_client)
    -- end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
--     -- Custom
--     if beautiful.titlebar_fun then
--         beautiful.titlebar_fun(c)
--         return
--     end

--     -- Default
--     -- buttons for the titlebar
--     local buttons = my_table.join(
--         awful.button({ }, 1, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.move(c)
--         end),
--         awful.button({ }, 3, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.resize(c)
--         end)
--     )

--     awful.titlebar(c, {size = 21}) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
-- end)

--[[
-- things that need to run at startup:
--]]

-- polybar
awful.spawn.with_shell("$HOME/.config/polybar/launch.sh")
-- turning on numpad
awful.spawn("numlockx on")
-- picom (compositor)
awful.spawn.with_shell("picom")
-- nitrogen (wallpaper manager)
awful.spawn.with_shell("sleep 1;nitrogen --restore")
-- Xresources (color and font settings)
awful.spawn.with_shell("xrdb $HOME/.config/.Xresources")
-- mouse sens
awful.spawn.with_shell("chsens 0.5")
--flashfocus
awful.spawn.with_shell("flashfocus")


-- Modyfing xmod keys and swapping escape with caps lock
--  It is very important to call setxkbmap BEFORE xmodmap, as setxkbmap RESETS all the xmod keys to their defaults.
awful.spawn.with_shell(string.format('setxkbmap -option "caps:swapescape";xmodmap %s/.config/.Xmodmap', os.getenv("HOME")))

-- awful.spawn.single_instance("imwheel")
