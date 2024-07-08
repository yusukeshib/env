local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.color_scheme = 'Dracula'
-- config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 14.0
config.initial_rows = 68
config.initial_cols = 210
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

return config
