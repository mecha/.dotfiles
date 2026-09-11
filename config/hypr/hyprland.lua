--- MONITORS -------------------------------------------------------------------

hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1,
	bitdepth = 10,
})

--- ENVIRONMENT ----------------------------------------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("BEMOJI_PICKER_CMD", "fuzzel -d")

hl.env("GDK_SCALE", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

--- CONFIG ---------------------------------------------------------------------

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},

	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgb(95d5b2)", "rgb(59d977)" },
				angle = 30,
			},
			inactive_border = "rgba(080c0cff)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 6,
		rounding_power = 3,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 5,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
		force_split = 2,
		smart_resizing = false,
	},

	master = {
		new_status = "slave",
		orientation = "left",
	},

	misc = {
		focus_on_activate = true,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		background_color = "rgb(2c3333)",
		middle_click_paste = false,
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "compose:ralt",
		kb_rules = "",
		repeat_delay = 250,
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = true,
		},
	},

	gestures = {
		workspace_swipe_cancel_ratio = 0.25,
		workspace_swipe_min_speed_to_force = 10,
	},
})

--- ANIMATIONS -----------------------------------------------------------------

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easeOutBack", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.5, bezier = "quick" })
hl.animation({ leaf = "windows", enabled = true, speed = 1.79, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.8, bezier = "linear", style = "slide" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.03, bezier = "quick" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 0.2, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 1.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.35, bezier = "quick", style = "slide" })

--- AUTOSTART ------------------------------------------------------------------

hl.on("hyprland.start", function()
	-- Make the variables required by xdg-desktop-portal-hyprland available.
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("nm-applet")
	hl.exec_cmd("swaync")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("udiskie --smart-tray --appindicator --menu flat")
	hl.exec_cmd("quickshell --daemonize")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("localsend --hidden")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")

	hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Jasper-Green"')
	hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
end)

--- INPUT ----------------------------------------------------------------------

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

--- KEY BINDINGS ---------------------------------------------------------------

local terminal = "ghostty"
local menu = "fuzzel"
local modKey = "SUPER"

hl.bind(modKey .. " + ALT + Q", hl.dsp.exit())

-- Window management
hl.bind(modKey .. " + Q", hl.dsp.window.close())
hl.bind(modKey .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(modKey .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(modKey .. " + P", hl.dsp.window.pin())
hl.bind(modKey .. " + Escape", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- App shortcuts
hl.bind(modKey .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(modKey .. " + E", hl.dsp.exec_cmd("nautilus -w /files"))
hl.bind(modKey .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(modKey .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(modKey .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(modKey .. " + M", hl.dsp.exec_cmd("quickshell ipc call drawer toggle"))
hl.bind(modKey .. " + period", hl.dsp.exec_cmd("bemoji -n -t -P0 -f $XDG_DATA_HOME/bemoji/emojis.txt"))
hl.bind(modKey .. " + comma", hl.dsp.exec_cmd("bemoji -n -t -p -P0 -f $XDG_DATA_HOME/bemoji/nerdfont.txt"))
hl.bind(modKey .. " + semicolon", hl.dsp.exec_cmd("bemoji -n -t -p -P0 -f $XDG_DATA_HOME/bemoji/math.txt"))

-- Focus and window movement
hl.bind(modKey .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(modKey .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(modKey .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(modKey .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(modKey .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(modKey .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(modKey .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(modKey .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))

-- Switch workspaces and move the active window between them.
for workspace = 1, 10 do
	local key = workspace % 10
	hl.bind(modKey .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
	hl.bind(modKey .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

-- Hidden workspace
hl.bind(modKey .. " + X", hl.dsp.workspace.toggle_special("overlay"))
hl.bind(modKey .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:overlay" }))

-- Move/resize with the mouse
hl.bind(modKey .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(modKey .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize with the keyboard
hl.bind(modKey .. " + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(modKey .. " + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(modKey .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(modKey .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Screenshots
hl.bind(modKey .. " + S", hl.dsp.exec_cmd("hyprshot -zm region --clipboard-only"))
hl.bind(modKey .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -zm output -m active --clipboard-only"))
hl.bind(modKey .. " + CTRL + S", hl.dsp.exec_cmd("hyprshot -zm window --clipboard-only"))
hl.bind("Print", hl.dsp.exec_cmd("grim - | wl-copy"))

-- Voice dictation
hl.bind("XF86Tools", hl.dsp.exec_cmd("hyprvoice toggle"))

-- Volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(modKey .. " + mouse_up", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind(modKey .. " + mouse_down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Session controls
hl.bind(modKey .. " + SHIFT + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

-- Shell UI
hl.bind(modKey .. " + B", hl.dsp.exec_cmd("quickshell ipc call bar toggle"))
hl.bind(modKey .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(modKey .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client --reload-config"))

-- Global app hotkeys
local obsWindow = "class:^(com\\.obsproject\\.Studio)$"
for _, key in ipairs({ "F1", "F5", "F6", "F7" }) do
	hl.bind(modKey .. " + " .. key, hl.dsp.pass({ window = obsWindow }))
end

--- WINDOW RULES ---------------------------------------------------------------

hl.window_rule({
	name = "ignore maximize requests from apps",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "zen/firefox picture-in-picture",
	match = {
		title = "Picture-in-Picture",
		class = "(zen|firefox)",
	},
	float = true,
	pin = true,
	size = { 800, 450 },
	content = "video",
})

hl.window_rule({
	name = "floating thunderbird calendar reminders",
	match = { initial_title = "Calendar Reminders" },
	float = true,
	center = true,
	size = { "monitor_w*0.5", "monitor_h*0.5" },
})

hl.window_rule({
	name = "floating android emulator",
	match = { class = "Emulator" },
	float = true,
})

hl.window_rule({
	name = "fix for jetbrains IDE tooltips focus",
	match = {
		class = "^(jetbrains-.*)$",
		title = "^(win.*)$",
	},
	float = true,
	no_initial_focus = true,
})

hl.window_rule({
	name = "blueman systray floating position & size",
	match = { class = "blueman-manager" },
	float = true,
	size = { 600, "monitor_h*0.7" },
	move = { "monitor_w-610", 40 },
})

hl.window_rule({
	name = "volume control floating position & size",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true,
	size = { 600, "monitor_h*0.7" },
	move = { "monitor_w-610", 40 },
})

hl.window_rule({
	name = "gimp color picker fix",
	match = { initial_class = "^gimp$" },
	focus_on_activate = false,
})

hl.window_rule({
	name = "godot no floating",
	match = { initial_title = "Godot" },
	float = false,
	no_follow_mouse = true,
})
