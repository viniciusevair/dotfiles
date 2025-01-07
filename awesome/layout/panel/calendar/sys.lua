local beautiful = require ("beautiful")
local colors = require ("themes.colors")
local helpers = require ("helpers")
local wibox = require ("wibox")
local awful = require ("awful")
local gears = require ("gears")
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

local cpu_widget, cpu_controller = create_progress_widget("CPU", colors.orange)
local ram_widget, ram_controller = create_progress_widget("RAM", colors.green)
local disk_widget, disk_controller = create_progress_widget("DISK", colors.purple)

local cpu_widget, cpu_controller = create_progress_widget("CPU", colors.orange)
local ram_widget, ram_controller = create_progress_widget("RAM", colors.green)
local disk_widget, disk_controller = create_progress_widget("DISK", colors.purple)

local function update_controller()
  awful.spawn.easy_async_with_shell(
    "echo \"$(top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8}') $(free | grep Mem | awk '{printf \"%.2f\", $3/$2 * 100.0}') $(df -h / | awk 'NR==2 {print $5}' | tr -d '%')\"",
    function(stdout)
      -- Split the stdout into CPU, RAM, and Disk values
      local cpu_usage, ram_usage, disk_usage = stdout:match("([%d%.]+) ([%d%.]+) ([%d]+)")

      -- Update each controller
      if cpu_usage then
        cpu_controller:set_value (tonumber(cpu_usage))
      end
      if ram_usage then
        ram_controller:set_value (tonumber(ram_usage))
      end
      if disk_usage then
        disk_controller:set_value (tonumber(disk_usage))
      end
    end
  )
end

-- Timer to periodically update widgets
gears.timer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    update_controller()
  end
}

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
