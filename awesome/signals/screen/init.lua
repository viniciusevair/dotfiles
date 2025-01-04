local awful = require 'awful'
local beautiful = require 'beautiful'

local gears = require 'gears'

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)

screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag.add("1", {
    layout             = awful.layout.suit.fair,
    master_fill_policy = "expand",
    screen             = s,
    selected           = true,
  })

  awful.tag.add("2", {
    layout             = awful.layout.suit.tile,
    master_fill_policy = "expand",
    screen = s,
  })

  awful.tag.add("3", {
    layout             = awful.layout.suit.tile,
    master_fill_policy = "expand",
    master_width_factor = 0.65,
    screen             = s,
  })

  awful.tag.add("4", {
    layout             = awful.layout.suit.tile,
    screen = s,
  })

  awful.tag.add("5", {
    layout             = awful.layout.suit.tile,
    screen = s,
  })
end)
