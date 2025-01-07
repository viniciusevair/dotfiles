local awful        = require 'awful'
local gears        = require 'gears'
local wibox        = require('wibox')
local beautiful    = require('beautiful')

local dpi          = beautiful.xresources.apply_dpi
local helpers      = require('helpers')
local color        = require("themes.colors")

local user         = require('user')
local iconpath     = os.getenv("HOME") .. '/.config/awesome/assets/weather_icons/'

local api_key      = "e3578ff20a78750dbfc8f2e9ece0c0d1"
local city         = "Curitiba"
local country_code = "BR"
local weather_api  = "https://api.openweathermap.org/data/2.5/weather?q=" ..
                     city .. "," .. country_code .. "&appid=" .. api_key ..
                     "&units=metric"

--------------------------
--Base_widgets------------
--------------------------
local icon_location  = "  "
local text_location  = helpers.textbox(color.lightblue, "IosevkaTermNF bold 20",
                       "Curitiba, BR")
local text_weather   = helpers.textbox(color.lightblue, "IosevkaTermNF bold 12", "Loading...")
local text_temp      = helpers.textbox(color.fg_normal, "IosevkaTermNF bold 30", " " .. '°C')

local icon_humid     = helpers.textbox(color.blue, "IosevkaTermNF bold 17", "󱪅 ")
local icon_wind      = helpers.textbox(color.blue, "IosevkaTermNF bold 17", " ")
local icon_feelslike = helpers.textbox(color.blue, "IosevkaTermNF bold 17", "󱤋  ")

local text_humid     = helpers.textbox(color.fg_normal, "IosevkaTermNF 14", "N/A")
local text_wind      = helpers.textbox(color.fg_normal, "IosevkaTermNF 14", "N/A")
local text_feelslike = helpers.textbox(color.fg_normal, "IosevkaTermNF 14", "N/A")

local weath_image    = helpers.imagebox(iconpath .. 'weather-error.svg', 70, 70)

local function update_weather()
  awful.spawn.easy_async_with_shell(
    "curl -s '" .. weather_api .. "'",
    function(stdout)
      -- Parse JSON response
      local json = require("dkjson") -- Requires LuaJSON module
      local weather_data, pos, err = json.decode(stdout, 1, nil)

      if err then
        text_weather:set_text("Error fetching weather")
        return
      end

      -- Update widget with data
      local city_name = weather_data.name
      local country = weather_data.sys.country
      local weather_main = weather_data.weather[1].description
      local temp = math.floor(weather_data.main.temp)
      local feels_like = math.floor(weather_data.main.feels_like)
      local humidity = weather_data.main.humidity
      local wind_speed = weather_data.wind.speed

      -- Update the widget components
      text_location:set_text(icon_location .. city_name .. ", " .. country)
      text_weather:set_text(weather_main)
      text_temp:set_text(temp .. "°C")
      text_humid:set_text(humidity .. "%")
      text_feelslike:set_text(feels_like .. "°C")
      text_wind:set_text(wind_speed .. " m/s")
    end
  )
end

gears.timer {
  timeout = 30,
  call_now = true,
  autostart = true,
  callback = update_weather
}

--Bottom containers
local container      = function(wgt1, wgt2, width)
	return wibox.widget {
		{
			{
				{
					wgt1,
					nil,
					wgt2,
					layout = wibox.layout.align.horizontal
				},
				widget       = wibox.container.margin,
				forced_width = dpi(width),
				left         = dpi(10),
				right        = dpi(10),
				top          = dpi(5),
				bottom       = dpi(5)
			},
			widget = wibox.container.background,
			bg = color.bg_light,
			shape = helpers.rrect(0)
		},
		widget = wibox.container.margin,
		margins = dpi(0) }
end

local wgt = wibox.widget {
	{
		{
			{
				helpers.margin({
            text_location,
						nil,
						text_weather,
						layout = wibox.layout.align.horizontal
					},
					5, 5, 10, 10),
				helpers.margin({
						text_temp,
						nil,
						weath_image,
						layout = wibox.layout.align.horizontal
					},
					10, 5, 5, 10),
				helpers.margin({
						{
							helpers.margin(container(icon_humid, text_humid, 115), 5, 12, 0, 0),
							helpers.margin(container(icon_feelslike, text_feelslike, 115), 12, 12, 0, 0),
							helpers.margin(container(icon_wind, text_wind, 120), 12, 5, 0, 0),
							layout = wibox.layout.align.horizontal
						},
						widget = wibox.container.place
					},
					0, 0, 0, 10),
				layout = wibox.layout.fixed.vertical
			},
			widget = wibox.container.margin,
			margins = dpi(20)
		},
		widget = wibox.container.background,
		bg = color.bg_normal,
		shape = helpers.rrect(0)
	},
	widget = wibox.container.margin,
	margins = dpi(10),
	forced_width = dpi(450)
}

return wgt
