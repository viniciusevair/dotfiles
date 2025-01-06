local beautiful = require ("beautiful")
local colors = require ("themes.colors")
local helpers = require ("helpers")
local wibox = require ("wibox")
local dpi = beautiful.xresources.apply_dpi

-- Function to create a progress bar with label
local function create_progress_widget (name, color)
	-- Create the progress bar
	local progress_bar = wibox.widget ({
		max_value = 100,
		value = 0,
		widget = wibox.widget.progressbar,
		forced_width = 250,
		forced_height = 20,
		border_color = colors.magenta,
		border_width = dpi (2),
		background_color = colors.bg_light,
		color = color,
	})

	-- Label widget
	local label = helpers.textbox (colors.magenta, "IosevkaTermNF bold 16", name)
	label.forced_width = dpi (50)

	-- Final layout for the progress bar and label
	local final = wibox.widget ({
		helpers.margin (label, 15, 6, 0, 0),
		helpers.margin (progress_bar, 6, 15, 0, 0),
		layout = wibox.layout.align.horizontal,
	})

	return helpers.margin (final, 3, 3, 15, 15), progress_bar
end

-- Create all progress bars and their labels
local cpu_widget, cpu_controller = create_progress_widget ("CPU", colors.orange)
local ram_widget, ram_controller = create_progress_widget ("RAM", colors.green)
local disk_widget, disk_controller =
	create_progress_widget ("DISK", colors.purple)

local sys = wibox.widget ({
	{
		{
			cpu_widget,
			ram_widget,
			disk_widget,
			layout = wibox.layout.fixed.vertical,
		},
		widget = wibox.container.margin,
		margins = dpi (10),
	},
	widget = wibox.container.background,
	bg = colors.bg_normal,
	shape = helpers.rrect (0),
})

return helpers.margin (sys, 10, 10, 10, 10)
