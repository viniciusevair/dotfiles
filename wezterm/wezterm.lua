local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font 'IosevkaTerm Nerd Font'
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_background_opacity = 1
config.font_size = 17.0
config.cell_width = 0.90
config.window_padding = {
    left   = 25,
    right  = 25,
    top    = 25,
    bottom = 25,
}

config.colors = {
    -- The default text color
    foreground = '#d6dee0',
    -- The default background color
    background = '#1c150f',

    cursor_border = '#f0dfaf',

    -- the foreground color of selected text
    selection_fg = 'none',
    -- the background color of selected text
    selection_bg = 'rgb(161 173 108 35%)',

    -- The color of the split lines between panes
    split = '#f0dfaf',

    ansi = {
        "#2a2f30",
        "#ab4343",
        "#5fbd55",
        "#b8a156",
        "#667bad",
        "#9f6cc7",
        "#3f8f97",
        "#d0cfcc",
    },
    brights = {
        "#606f72",
        "#cf7474",
        "#87db7d",
        "#dbe967",
        "#7893d6",
        "#c799eb",
        "#82d7e0",
        "#ffffff",
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = '#af8700' },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = 'orange',

    -- Colors for copy_mode and quick_select
    -- available since: 20220807-113146-c2fee766
    -- In copy_mode, the color of the active text is:
    -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
    -- 2. selection_* otherwise
    copy_mode_active_highlight_bg = { Color = '#000000' },
    -- use `AnsiColor` to specify one of the ansi color palette values
    -- (index 0-15) using one of the names "Black", "Maroon", "Green",
    --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
    -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

    quick_select_label_bg = { Color = 'peru' },
    quick_select_label_fg = { Color = '#ffffff' },
    quick_select_match_bg = { AnsiColor = 'Navy' },
    quick_select_match_fg = { Color = '#ffffff' },
}

config.force_reverse_video_cursor = true

return config
