local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')
local gears = require('gears')

local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')
local color = require("themes.colors")

local brightness_slider = wibox.widget({
	widget = wibox.widget.slider,
	bar_shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 25)
	end,

	bar_height = dpi(8),
	bar_color = color.mid_dark,
	bar_active_color = color.blue,
	handle_shape = gears.shape.circle,
	handle_color = color.lightblue,
	handle_width = dpi(25),
	handle_border_width = 3,
	handle_border_color = color.bg_dim,
	minimum = 5,
	maximum = 100,
	value = 100,
})

awesome.connect_signal("slider::brightness", function()
    awful.spawn.easy_async_with_shell(
        "brightnessctl",  -- Get the raw output from brightnessctl
        function(stdout)
            -- Parse the brightness value and set the slider
            local brightness = tonumber(stdout:match("([%d%.]+)%%"))
            if brightness then
                brightness_slider.value = brightness
            end
        end
    )
end)

awesome.emit_signal("slider::brightness")

--FUnctionality of Brightness Slider
brightness_slider:connect_signal("property::value", function(slider)
	local brightness_level = math.floor(slider.value / 100 * 100)
	awful.spawn.easy_async("brightnessctl set " .. brightness_level .. "%", function()
	end)
end)


local icon = helpers.margin(
	helpers.textbox(color.orange, "Ubuntu Nerd Font bold 30", '󰃠'),
	0, 15, 5, 5
)

local final_sider = helpers.margin(
	wibox.widget {
		{
			icon,
			brightness_slider,
			layout = wibox.layout.fixed.horizontal
		},
		widget = wibox.container.margin,
		-- margins = dpi(10),
		forced_height = dpi(60),
		forced_width = dpi(400),
	},
	30, 30, 10, 5)

final_sider.forced_width = dpi(450)

return final_sider
