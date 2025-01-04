local awful = require ('awful')
local wibox = require ('wibox')
local beautiful = require ('beautiful')
local naughty = require 'naughty'

local dpi = beautiful.xresources.apply_dpi
local helpers = require ('helpers')
local color = require ("themes.colors")

local img_path = os.getenv ("HOME") .. "/.config/awesome/assets/control_center/dark/"

local create_container = function (img, clr, text, onstatus, fn_on, fn_off)
  local btn = wibox.widget {
    helpers.margin (
    wibox.widget {
      helpers.imagebox (img_path .. img, 35, 35),
      widget = wibox.container.place
    },
    20, 20, 20, 20
    ),
    widget = wibox.container.background,
    bg = onstatus and clr or color.mid_dark,
    shape = helpers.rrect (50)
  }

  local txt = helpers.textbox (color.lightblue, "IosevkaTermNF bold 12", text)
  txt.halign = 'center'
  txt.foced_width = dpi (45)

  local container =
  wibox.widget {
    helpers.margin (btn, 0, 0, 0, 8),
    txt,
    layout = wibox.layout.fixed.vertical
  }

  container:connect_signal ("button::press", function ()
    onstatus = not onstatus
    if onstatus then
      btn.bg = clr
      if fn_on ~= nil then
        fn_on ()
      end
    else
      btn.bg = color.mid_dark
      if fn_off ~= nil then
        fn_off ()
      end
    end
  end)

  return helpers.margin (container, 15, 15, 10, 15)
end

local buttons = {
  wifi = create_container ("wifi.png", color.blue, "Wifi", true,
  function () awful.spawn ('nmcli radio wifi on') end,
  function () awful.spawn ('nmcli radio wifi off') end
  ),
  bluetooth = create_container ("bluetooth.png", color.blue, "Bluetooth", false, nil, nil),
  dnd = create_container ("dnd2.png", color.blue, "DND", false,
  function () naughty.suspended = true end,
  function () naughty.suspended = false end
  ),
  dark_mode = create_container ("dark.png", color.blue, "Dark mode", false, nil, nil),
  Silent = create_container ("silent.png", color.blue, "Silent", false,
  function () awful.spawn ('wpctl set-mute @DEFAULT_AUDIO_SINK@ 1') end,
  function () awful.spawn ('wpctl set-mute @DEFAULT_AUDIO_SINK@ 0') end
  ),
  night_mode = create_container ("dnd.png", color.blue, "Night", false,
  function () awful.spawn ('redshift -P -O 3500') end,
  function () awful.spawn ('redshift -x') end
  ),
  settings = create_container ("settings.png", color.blue, "Settings", false, nil, nil),
}

local main = wibox.widget {
  {
    {
      buttons.wifi,
      buttons.Silent,
      buttons.dnd,
      buttons.night_mode,
      layout = wibox.layout.fixed.horizontal
    },
    widget = wibox.container.place
  },
  widget = wibox.container.margin,
  forced_width = dpi (450)
}

return main
