local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.color_scheme = 'Dracula'
config.font = wezterm.font('MonoLisa Nerd Font Mono')
config.font_size = 15.0
config.initial_rows = 80
config.initial_cols = 200
config.enable_tab_bar = false
config.adjust_window_size_when_changing_font_size = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.quit_when_all_windows_are_closed = false

return config
