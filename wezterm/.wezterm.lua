-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.audible_bell = "Disabled"

wezterm.font("MesloLGS NF")
config.font_size = 12.0

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true

-- For example, changing the color scheme:
config.color_scheme = "rose-pine"

config.colors = {
	tab_bar = {
		active_tab = { bg_color = "#1e1e2e", fg_color = "#cccac2" },
		inactive_tab = { bg_color = "#11111b", fg_color = "#bfbdb6" },
	},
}

config.window_frame = {
	font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	active_titlebar_bg = "#11111b",
	inactive_titlebar_bg = "#313244",
}

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.default_prog = { "ubuntu2404.exe" }

config.launch_menu = {
	{
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	},
	{
		label = "WSL",
		args = { "ubuntu2404.exe" },
	},
}

-- and finally, return the configuration to wezterm
return config
