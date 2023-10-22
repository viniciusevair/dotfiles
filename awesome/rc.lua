-- vim:foldmethod=marker

-- {{{ Libraries call
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- }}}

-- {{{ Notification handling
-- Naughty reshape
naughty.config.defaults['icon_size'] = 100
naughty.config.defaults.shape = gears.shape.octogon
naughty.config.defaults['border_width'] = 2
naughty.config.defaults['border_color'] = "#52472F"
naughty.config.presets.critical.bg = beautiful.fg_urgent
naughty.config.presets.critical.fg = "#CC9393"
--naughty.config.presets.low.fg = "COR PRO TEXTO LOW"
--naughty.config.presets.normal.fg = "COR PRO TEXTO NORMAL"
-- }}}

-- {{{ Error handling
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
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/zaurak/.config/awesome/themes/zau/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key between Control and Alt.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = awful.widget.textclock("%A, %B %d, %Hh%M'",60)
-- Create a calendar widget
local cw = calendar_widget({
    theme = 'naughty',
    placement = 'top_right',
    start_sunday = true,
    radius = 15,
})
mytextclock:connect_signal("button::press",
function(_, _, _, button)
    if button == 1 then cw.toggle() end
end)

-- Create a wibox for each screen and add it
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

local tasklist_buttons = gears.table.join(
awful.button({ }, 1, function (c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal(
        "request::activate",
        "tasklist",
        {raise = true}
        )
    end
end),
awful.button({ }, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
end),
awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
end),
awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Tag Layout
    beautiful.master_width_factor = 0.6

    awful.tag.add("home", {
        layout             = awful.layout.suit.floating,
        master_fill_policy = "expand",
        screen             = s,
        selected           = true,
    })

    awful.tag.add("work", {
        layout             = awful.layout.suit.tile.left,
        master_fill_policy = "expand",
        screen = s,
    })

    awful.tag.add("browse", {
        layout             = awful.layout.suit.tile.left,
        master_fill_policy = "expand",
        master_width_factor = 0.55,
        screen             = s,
    })

    awful.tag.add("music", {
        layout             = awful.layout.suit.magnifier,
        master_fill_policy = "expand",
        master_width_factor = 0.8,
        screen = s,
    })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Separator shape
    diamond_spacing = {
        color = beautiful.fg_focus,
        shape = function(cr, width, height)
            gears.shape.hexagon(cr, width, height)
        end,
        widget = wibox.widget.separator,
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = function(cr, width, height)
                gears.shape.hexagon(cr, width, height)
            end
        },
        layout = {
            spacing = 13,
            spacing_widget = diamond_spacing,
            layout = wibox.layout.fixed.horizontal
        },

        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
        buttons = taglist_buttons
    }

    -- Wibar widgets config
    s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 4, 14, 3, 3)
    mytextclock = wibox.container.margin(mytextclock, 5, 5)
    s.mylogout = wibox.container.margin(logout_menu_widget(), 4, 4)
    s.myvolume = wibox.container.margin(volume_widget({
        widget_type = 'arc',
        main_color = beautiful.fg_focus,
        thickness = 2
    }), 6, 6)
    s.spotify = wibox.container.margin(spotify_widget({
        font = 'Iosevka',
        play_icon = '/usr/share/icons/Arc/actions/24/player_pause.png',
        pause_icon = '/usr/share/icons/Arc/actions/24/player_play.png',
        dim_when_paused = true,
        dim_opacity = 0.6,
        show_tooltip = false,
        max_length = -1
    }), 5, 5)

    -- Separator
    local separator = wibox.widget.textbox(" ")

    -- Create the wibox
    s.mywibar = awful.wibar({
        screen = s,
        border_width = 2,
        border_color = beautiful.border_normal,
        width = 1904,
        height = 20,
        shape = function(cr, width, height)
            gears.shape.hexagon(cr, width, height)
        end,
        bg = beautiful.bg_normal .. "90"
    })

    s.mywibar.y = 5
    s.mywibar.x = 5
    s.mywibar:struts { left = 0, right = 0, top = 30, bottom = 0 }

    -- Add widgets to the wibox
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
        spacing = 13,
        spacing_widget = diamond_spacing,
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
        separator
    },
    -- Middle widget
    nil,
    { -- Right widgets
    spacing = 13,
    spacing_widget = diamond_spacing,
    layout = wibox.layout.fixed.horizontal,
    separator,
    s.mypromptbox,
    s.spotify,
    s.myvolume,
    mytextclock,
    s.mylogout,
    s.mylayoutbox,
},
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
awful.key({ modkey }, "s",      hotkeys_popup.show_help,
{description="show help", group="awesome"}),
awful.key({ modkey }, "Left",   awful.tag.viewprev,
{description = "view previous", group = "tag"}),
awful.key({ modkey }, "Right",  awful.tag.viewnext,
{description = "view next", group = "tag"}),
awful.key({ modkey }, "Escape", awful.tag.history.restore,
{description = "go back", group = "tag"}), --????

-- Screenshot
awful.key({ "Control", "Shift", modkey }, "s",
function() awful.spawn("flameshot full -p /home/zaurak/Pictures/Screenshots/") end, 
{description = "Fullshot to File", group = "Screenshots"}),
awful.key({ "Control", modkey }, "s",
function() awful.spawn("flameshot gui -p /home/zaurak/Pictures/Screenshots/") end,
{description = "Screenshot Select to File", group = "Screenshots"}),
awful.key({ "Shift", modkey }, "s",
function() awful.spawn("flameshot gui -c") end,
{description = "Screenshot Select to Clipboard", group = "Screenshots"}),

-- Clients
awful.key({ modkey }, "j",
function () awful.client.focus.byidx( 1) end,
{description = "focus next by index", group = "client"}),
awful.key({ modkey }, "k",
function () awful.client.focus.byidx(-1) end,
{description = "focus previous by index", group = "client"}),
awful.key({ modkey, "Control" }, "j",
function () awful.screen.focus_relative( 1) end,
{description = "focus the next screen", group = "screen"}),
awful.key({ modkey, "Control" }, "k",
function () awful.screen.focus_relative(-1) end,
{description = "focus the previous screen", group = "screen"}),
awful.key({ modkey }, "u",
awful.client.urgent.jumpto,
{description = "jump to urgent client", group = "client"}),
awful.key({ modkey }, "Tab",
function ()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end,
{description = "go back", group = "client"}),

-- Client resizing
awful.key({ modkey, "Shift" }, "Right",     function () awful.tag.incmwfact( 0.01)    end),
awful.key({ modkey, "Shift" }, "Left",     function () awful.tag.incmwfact(-0.01)    end),
awful.key({ modkey, "Shift" }, "Down",     function () awful.client.incwfact( 0.01)    end),
awful.key({ modkey, "Shift" }, "Up",     function () awful.client.incwfact(-0.01)    end),

-- Layout manipulation
awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(  1)    end,
{description = "swap with next client by index", group = "client"}),
awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx( -1)    end,
{description = "swap with previous client by index", group = "client"}),

-- Standard program
awful.key({ modkey }, "Return",
function () awful.spawn(terminal) end,
{description = "open a terminal", group = "launcher"}),
awful.key({ modkey, "Control" }, "r", awesome.restart,
{description = "reload awesome", group = "awesome"}),
awful.key({ modkey, "Shift" }, "q", awesome.quit,
{description = "quit awesome", group = "awesome"}),

awful.key({ modkey }, "l",     function () awful.tag.incmwfact( 0.05)          end,
{description = "increase master width factor", group = "layout"}),
awful.key({ modkey }, "h",     function () awful.tag.incmwfact(-0.05)          end,
{description = "decrease master width factor", group = "layout"}),
awful.key({ modkey, "Shift" }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
{description = "increase the number of master clients", group = "layout"}),
awful.key({ modkey, "Shift" }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
{description = "decrease the number of master clients", group = "layout"}),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
{description = "increase the number of columns", group = "layout"}),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
{description = "decrease the number of columns", group = "layout"}),

awful.key({ modkey }, "space", function () awful.layout.inc( 1)                end,
{description = "select next", group = "layout"}),
awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1)                end,
{description = "select previous", group = "layout"}),

awful.key({ modkey, "Control" }, "n",
function ()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:emit_signal(
        "request::activate", "key.unminimize", {raise = true}
        )
    end
end,
{description = "restore minimized", group = "client"}),

-- Prompt
awful.key({ modkey }, "r",
function () awful.screen.focused().mypromptbox:run() end,
{description = "run prompt", group = "launcher"}),
awful.key({ modkey }, "x",
function ()
    awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
    }
end,
{description = "lua execute prompt", group = "awesome"}),

-- Menubar
awful.key({ modkey, "Control" }, "p", function() menubar.show() end,
{description = "show the menubar", group = "launcher"}),


-- Sound
awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end),
awful.key({ modkey }, "p", function () awful.util.spawn("playerctl play-pause") end),
awful.key({ }, "XF86AudioNext", function () awful.util.spawn("playerctl next") end),
awful.key({ modkey, "Shift" }, "n", function () awful.util.spawn("playerctl next") end),
awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end),
awful.key({ modkey, "Shift" }, "p", function () awful.util.spawn("playerctl previous") end),
awful.key({ }, "XF86AudioRaiseVolume", function() awful.util.spawn("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+") end),
awful.key({ modkey }, "[", function() awful.util.spawn("wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ 5%+") end),
awful.key({ }, "XF86AudioLowerVolume", function() awful.util.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end),
awful.key({ modkey }, "]", function() awful.util.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end),
awful.key({ }, "XF86AudioMute", function() awful.util.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end),
awful.key({ modkey, "Shift" }, "m", function() awful.util.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end)
)

clientkeys = gears.table.join(
awful.key({ modkey }, "f",
function (c)
    c.fullscreen = not c.fullscreen
    c:raise()
end,
{description = "toggle fullscreen", group = "client"}),
awful.key({ modkey }, "q",      function (c) c:kill()                         end,
{description = "close", group = "client"}),
awful.key({ modkey, "Control" }, "q",      function (c) c:kill()                         end,
{description = "close", group = "client"}),
awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
{description = "toggle floating", group = "client"}),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
{description = "move to master", group = "client"}),
awful.key({ modkey }, "o", function (c) c:move_to_screen()               end,
{description = "move to screen", group = "client"}),
awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop            end,
{description = "toggle keep on top", group = "client"}),
awful.key({ modkey }, "n",
function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end ,
{description = "minimize", group = "client"}),
awful.key({ modkey }, "m",
function (c)
    c.maximized = not c.maximized
    c:raise()
end ,
{description = "(un)maximize", group = "client"}),
awful.key({ modkey, "Control" }, "m",
function (c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end ,
{description = "(un)maximize vertically", group = "client"}),
awful.key({ modkey, "Shift"   }, "m",
function (c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end ,
{description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
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
awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
end),
awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
end),
awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
    properties = {
        border_width = beautiful.border_width,
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
        "pinentry",
    },
    class = {
        "Arandr",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester",  -- xev.
        },
        role = {
            "AlarmWindow",  -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
    }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = { type = { "normal", "dialog" } }, 
    properties = { titlebars_enabled = false }
},

-- Set specific rules for some clients
{ rule = { class = "firefox" },
properties = { tag = "browse" } },
{ rule = { class = "[Ss]potify" },
properties = { tag = "music" } },
{ rule = { class = "Blueman-manager" },
properties = { tag = "music" } },
{ rule = { class = "[Pp]avucontrol" },
properties = { tag = "music" } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end
    c.shape = function(cr,w,h)
        gears.shape.octogon(cr,w,h,15)
    end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
    awful.button({ }, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end)
    )

    awful.titlebar(c) : setup {
        { -- Left
        wibox.widget.textbox("  "),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
    { -- Title
    align  = "left",
    widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
        },
        { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
    },

    layout = wibox.layout.align.horizontal
}
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
    --     c:emit_signal("request::activate", "mouse_enter", {raise = false})
    -- end)

    client.connect_signal("focus", function(c) 
        c.border_color = beautiful.border_focus
    end)
    client.connect_signal("unfocus", function(c)
        c.border_color = beautiful.border_normal
    end)
    -- }}}

    -- {{{ Auto-run
    local function run_once(cmd_arr)
        for _, cmd in ipairs(cmd_arr) do
            findme = cmd
            firstspace = cmd:find(" ")
            if firstspace then
                findme = cmd:sub(0, firstspace-1)
            end
            awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, 
            cmd))
        end
    end
    run_once({"picom -b", "pavucontrol", "blueman-manager"})
    -- }}}
