local wibox = require('wibox')
local beautiful = require('beautiful')

local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')
local color = require("themes.colors")
local user = require("user")

local img = helpers.margin(helpers.imagebox(user.user_img, 60, 60), 0, 15, 0, 0)

local name = wibox.widget {
	{
		helpers.margin(
			helpers.textbox(color.lightblue, "IosevkaTermNF bold 15", user.name),
			0, 0, 4, 0
		),
		helpers.margin(
			helpers.textbox(color.mid_light, "IosevkaTermNF bold 13", user.host),
			0, 0, 0, 4
		),
		layout = wibox.layout.fixed.vertical
	},
	widget = wibox.container.place
}

local create_button = function(fg, icon)
	local btn = helpers.margin(
		wibox.widget {
			helpers.textbox(fg, "Ubuntu Nerd Font 18", icon),
			widget = wibox.container.place
		},
		8, 8, 8, 8
	)

	btn.forced_height = dpi(50)
	btn.forced_width = dpi(50)

	local button = wibox.widget {
		{
			btn,
			widget = wibox.container.background,
			bg = color.bg_dark,
			border_width = 3,
			border_color = color.bg_dim,
			shape = helpers.rrect(40, 40)
		},
		widget = wibox.container.place,
		valign = 'center'
	}

	return helpers.margin(button, 5, 0, 0, 0)
end

local power = create_button(color.red, '')
local bell = create_button(color.orange, '󰂚')

helpers.add_hover_effect(power, color.bg_dark .. 'bd', color.bg_normal, color.bg_dark)

power:connect_signal("button::release", function()
	awesome.emit_signal("widget::powermenu")
end)

local main = wibox.widget {
	{
		{
			{
				img,
				name,
				spacing = dpi(5),
				layout = wibox.layout.fixed.horizontal
			},
			nil,
			{
				{
					{
						power,
						layout = wibox.layout.fixed.horizontal
					},
					layout = wibox.layout.fixed.vertical,
				},
				widget = wibox.container.place
			},
			layout = wibox.layout.align.horizontal
		},
		widget = wibox.container.margin,
		margins = dpi(15),
	},
	widget = wibox.container.background,
	bg = color.bg_normal,
	shape = helpers.rrect(0)
}

return helpers.margin(main, 10, 10, 10, 10)
