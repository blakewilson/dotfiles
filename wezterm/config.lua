-- Import the wezterm module
local wezterm = require("wezterm")

-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- (This is where our config will go)
-- Choose your favourite font, make sure it's installed on your machine
config.font = wezterm.font({ family = "MonoLisa" })
-- And a font size that won't have you squinting
config.font_size = 13

-- Pick a colour scheme. WezTerm ships with more than 1,000!
-- Find them here: https://wezfurlong.org/wezterm/colorschemes/index.html
-- config.color_scheme = "Tokyo Night"

-- Slightly transparent and blurred background
config.window_background_opacity = 1
config.macos_window_background_blur = 30

-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = "RESIZE"

config.color_scheme = "GruvboxDarkHard"

-- Sets the font for the window frame (tab bar)
config.window_frame = {
  font = wezterm.font({ family = "MonoLisa", weight = "Bold" }),
  font_size = 12,
}

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
