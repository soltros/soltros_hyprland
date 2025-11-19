# Soltros Hyprland Configuration

Official Hyprland configuration for [Soltros OS](https://github.com/soltros/Soltros-OS) with a complete Wayland desktop environment featuring Catppuccin Mocha theming.

## Overview

This repository contains a fully configured Hyprland desktop environment with:
- Custom Waybar configuration with tray toggle functionality
- Hyprland window manager with optimized animations and blur effects
- Dunst notification system
- Wofi application launcher
- Hyprlock screen locker
- Hyprpaper wallpaper manager
- Auto-launch applications assigned to dedicated workspaces

## Color Scheme

All components use the **Catppuccin Mocha** color palette:
- Base: `#1e1e2e`
- Mantle: `#303446`
- Surface: `#313244`
- Text: `#cdd6f4`
- Blue: `#89b4fa`
- Sky: `#89dceb`
- Pink: `#f38ba8`
- Peach: `#fab387`
- Yellow: `#f9e2af`
- Green: `#a6e3a1`
- Mauve: `#cba6f7`

## Directory Structure

```
.
├── hypr/
│   ├── hyprland.conf        # Main Hyprland configuration
│   ├── hyprlock.conf        # Screen lock configuration
│   ├── hyprpaper.conf       # Wallpaper configuration
│   └── scripts/
│       └── toggle_floating_waybar.sh
├── waybar/
│   ├── config.jsonc         # Active Waybar config (dynamically updated)
│   ├── config-with-tray.jsonc   # Base config with system tray
│   ├── style.css            # Waybar styling
│   └── scripts/
│       ├── toggle-module.sh     # Toggle tray visibility
│       ├── module-status.sh     # Display tray toggle status
│       ├── hide-module.sh       # Hide/show modules
│       ├── btc-price.sh         # Bitcoin price widget
│       ├── gpu-temp.sh          # GPU temperature monitor
│       ├── public-ip.sh         # Public IP display
│       └── weather.sh           # Weather information
├── dunst/
│   └── dunstrc              # Notification configuration
└── wofi/
    └── style.css            # Application launcher styling
```

## Components

### Hyprland (Window Manager)

**Configuration File:** [hypr/hyprland.conf](hypr/hyprland.conf)

#### Key Features:
- **Gaps:** 5px inner, 20px outer
- **Border:** 2px width with blue active border (`#89b4fa`)
- **Opacity:** Active windows at 100%, inactive at 90%
- **Layout:** Dwindle with pseudotiling support
- **Blur:** 8px size, 2 passes, optimized with custom vibrancy/noise settings
- **Animations:** Smooth bezier curves (easeOutQuint, easeInOutCubic)

#### Auto-start Applications:
- Waybar (status bar)
- Dunst (notifications)
- Hyprpaper (wallpaper)
- Hypridle (idle management)
- Blueman-applet (Bluetooth)
- Playerctld (media player daemon)
- Clipboard manager (wl-paste + cliphist)

#### Workspace Assignments:
| Workspace | Application |
|-----------|-------------|
| 2 | Steam |
| 3 | Discord |
| 4 | Telegram |
| 5 | Feishin (music player) |
| 6 | Heroic Games Launcher |
| 7 | EasyEffects (audio effects) |
| 8 | Cinny (Matrix client) |

#### Key Bindings:

**Window Management:**
- `Super + Return` - Launch terminal (Alacritty)
- `Super + C/Q` - Close active window
- `Super + M` - Exit Hyprland
- `Super + L` - Lock screen (Hyprlock)
- `Super + E` - File manager (Dolphin)
- `Super + F` - Browser (Waterfox)
- `Super + O` - Obsidian
- `Super + Space` - Application launcher (Rofi)
- `Super + R` - Wofi launcher (drun mode)
- `Super + Alt + R` - Wofi file browser
- `Super + Ctrl + R` - Wofi keybindings
- `Super + P` - Toggle pseudotiling
- `Super + J` - Toggle split direction
- `Super + V` - Toggle floating with Waybar auto-hide

**Waybar Control:**
- `Super + Shift + W` - Restart Waybar

**Display Power:**
- `Super + Shift + L` - Screen off (DPMS off)
- `Super + Alt + L` - Screen on (DPMS on)

**Focus Movement:**
- `Super + Arrow Keys` - Move focus between windows

**Workspace Switching:**
- `Super + [0-9]` - Switch to workspace 1-10
- `Super + Shift + [0-9]` - Move window to workspace 1-10
- `Super + Mouse Scroll` - Cycle through workspaces

**Special Workspace (Scratchpad):**
- `Super + Alt + S` - Toggle special workspace
- `Super + Shift + S` - Move window to special workspace

**Screenshots:**
- `Print` - Area screenshot to clipboard
- `Shift + Print` - Area screenshot to file

**Media & System:**
- `XF86AudioRaiseVolume` - Volume up 5%
- `XF86AudioLowerVolume` - Volume down 5%
- `XF86AudioMute` - Toggle mute
- `XF86MonBrightnessUp/Down` - Brightness control
- `XF86AudioPlay/Next/Prev` - Media controls

### Waybar (Status Bar)

**Configuration Files:**
- [waybar/config.jsonc](waybar/config.jsonc) (active, dynamically updated)
- [waybar/config-with-tray.jsonc](waybar/config-with-tray.jsonc) (base template)
- [waybar/style.css](waybar/style.css)

#### Layout:
- **Left:** Workspaces, Window title
- **Center:** Clock with calendar
- **Right:** Tray toggle, System tray, Media player (MPRIS), Idle inhibitor, Volume, Battery, Power menu

#### Features:
- **Dynamic Tray Toggle:** Click the chevron icon to show/hide system tray
  - `❮` = Tray visible (click to hide)
  - `❯` = Tray hidden (click to show)
- **Workspace Indicators:**
  - Normal: Gray background (`rgba(49, 50, 68, 0.8)`)
  - Active: Blue background (`rgba(137, 180, 250, 0.8)`)
  - Urgent: Pink background with pulsing animation (`rgba(243, 139, 168, 0.9)`)
  - Hover: Cyan background (`rgba(116, 199, 236, 0.8)`)
- **Blur Effect:** Layer rule applies blur to Waybar background
- **Transparency:** 75% opacity for background, 10% alpha ignored for blur
- **Media Display:** Shows currently playing media with artist and title (max 40 chars)
- **Battery States:** Warning at 30%, Critical at 15%
- **Clock Format:** `Wed Nov 19  09:30 AM` with yearly calendar tooltip

#### Custom Widgets (Available in scripts):
All custom widgets return JSON format and are ready to be added to config:
- **Bitcoin Price:** CoinGecko API, updates on interval
- **GPU Temperature:** AMD GPU edge temperature via lm_sensors
- **Public IP:** Masked display (xxx.xxx.xxx.xxx) with full IP in tooltip
- **Weather:** wttr.in integration, defaults to Toronto (set `$WEATHER_LOCATION` to customize)

#### Scripts:
- [toggle-module.sh](waybar/scripts/toggle-module.sh) - Swaps between configs with/without tray
- [module-status.sh](waybar/scripts/module-status.sh) - Returns current tray visibility status
- [hide-module.sh](waybar/scripts/hide-module.sh) - Generic module visibility toggle

### Hyprlock (Screen Lock)

**Configuration File:** [hypr/hyprlock.conf](hypr/hyprlock.conf)

#### Features:
- **Grace Period:** 5 seconds before lock activates
- **Background:** Wallpaper with 3-pass blur (size 8)
- **Input Field:** 300x50px, centered, Catppuccin themed
- **Clock Display:** Large bold time (95pt) with date (22pt)
- **Font:** JetBrainsMono Nerd Font
- **Colors:** Blue outline (`#89b4fa`), dark background (`#1e1e2e`)

### Hyprpaper (Wallpaper)

**Configuration File:** [hypr/hyprpaper.conf](hypr/hyprpaper.conf)

- **Wallpaper Path:** `~/wallpapers/default.jpg`
- **Splash Screen:** Disabled
- **IPC:** Disabled

### Dunst (Notifications)

**Configuration File:** [dunst/dunstrc](dunst/dunstrc)

#### Settings:
- **Position:** Top-right corner (offset 10x50)
- **Size:** 300x300px
- **Notification Limit:** 3 simultaneous
- **Font:** JetBrainsMono Nerd Font 10pt
- **Icon Size:** 32-128px
- **Corner Radius:** 10px
- **Frame:** 2px blue border (`#89b4fa`)
- **Transparency:** 10% transparent background
- **History:** 20 notifications
- **Browser:** Waterfox for notification links
- **Menu Integration:** Rofi for actions

#### Urgency Levels:
- **Low/Normal:** Dark background (`#1e1e2e`), light text (`#cdd6f4`), 10s timeout
- **Critical:** Dark background, pink text (`#f38ba8`), pink frame, no timeout

#### Mouse Actions:
- **Left Click:** Close current notification
- **Middle Click:** Execute action and close
- **Right Click:** Close all notifications

### Wofi (Application Launcher)

**Configuration File:** [wofi/style.css](wofi/style.css)

#### Features:
- **Font:** Hack monospace
- **Theme:** Catppuccin Mocha
- **Border Radius:** 20px outer, 10px input
- **Border:** 1px gray (`#626880`)
- **Input Focus:** Orange glow effect (`#ef9f76`)
- **Selection:** Gray highlight (`#626880`)
- **Alternating Rows:** Slight background variation (`#3C4053`)

## Installation

### Prerequisites

Soltros OS ships with these dependencies pre-installed. If you need to layer additional packages on the immutable base system:

```bash
rpm-ostree install <package-name>
rpm-ostree apply-live  # Apply without reboot (optional)
```

Core dependencies included in Soltros OS:
- hyprland, waybar, dunst, wofi, hyprlock, hyprpaper
- alacritty, rofi, wlogout, grim, slurp, wl-clipboard, cliphist
- pavucontrol, blueman, brightnessctl, playerctl, dolphin
- lm-sensors, jq, curl

### Deployment

1. Clone this repository:
```bash
git clone <repository-url> ~/Documents/development/soltros_hyprland
cd ~/Documents/development/soltros_hyprland
```

2. Create symlinks to config directories:
```bash
ln -sf ~/Documents/development/soltros_hyprland/hypr ~/.config/hypr
ln -sf ~/Documents/development/soltros_hyprland/waybar ~/.config/waybar
ln -sf ~/Documents/development/soltros_hyprland/dunst ~/.config/dunst
ln -sf ~/Documents/development/soltros_hyprland/wofi ~/.config/wofi
```

3. Make scripts executable:
```bash
chmod +x hypr/scripts/*.sh
chmod +x waybar/scripts/*.sh
```

4. Create required directories:
```bash
mkdir -p ~/wallpapers
mkdir -p ~/.cache/waybar
mkdir -p ~/Pictures
```

5. Set up wallpaper:
```bash
cp your-wallpaper.jpg ~/wallpapers/default.jpg
```

6. Log out and select Hyprland from your display manager

## Customization

### Changing Wallpaper

Edit both [hypr/hyprpaper.conf](hypr/hyprpaper.conf) and [hypr/hyprlock.conf](hypr/hyprlock.conf):
```conf
# hyprpaper.conf
preload = ~/wallpapers/your-image.jpg
wallpaper = ,~/wallpapers/your-image.jpg

# hyprlock.conf
background {
    path = ~/wallpapers/your-image.jpg
}
```

### Modifying Workspace Assignments

Edit [hypr/hyprland.conf](hypr/hyprland.conf):
```conf
windowrulev2 = workspace 2, class:^(your-app)$
```

Find application class with:
```bash
hyprctl clients
```

### Adjusting Waybar Modules

1. Edit [waybar/config-with-tray.jsonc](waybar/config-with-tray.jsonc) (base template)
2. Add modules to `modules-left`, `modules-center`, or `modules-right`
3. Toggle tray to regenerate active config, or manually restart Waybar

### Enabling Custom Waybar Widgets

Add to `modules-right` in [waybar/config-with-tray.jsonc](waybar/config-with-tray.jsonc):
```jsonc
"custom/btc": {
    "exec": "~/.config/waybar/scripts/btc-price.sh",
    "return-type": "json",
    "interval": 300
},
"custom/gpu": {
    "exec": "~/.config/waybar/scripts/gpu-temp.sh",
    "return-type": "json",
    "interval": 5
},
"custom/weather": {
    "exec": "~/.config/waybar/scripts/weather.sh",
    "return-type": "json",
    "interval": 1800
},
"custom/public_ip": {
    "exec": "~/.config/waybar/scripts/public-ip.sh",
    "return-type": "json",
    "interval": 300
}
```

### Changing Weather Location

Set environment variable before launching Waybar:
```bash
export WEATHER_LOCATION="New York"
```

Or add to [hypr/hyprland.conf](hypr/hyprland.conf):
```conf
env = WEATHER_LOCATION,New York
```

### Key Binding Modifications

Edit [hypr/hyprland.conf](hypr/hyprland.conf) keybind section:
```conf
bind = MODIFIER, KEY, action, parameters
```

Modifiers: `SUPER`, `SHIFT`, `ALT`, `CTRL`

Reload config: `Super + Shift + W` (for Waybar) or `hyprctl reload` (for Hyprland)

## Troubleshooting

### Waybar Not Showing
```bash
# Check if running
pgrep waybar

# Restart with keybind
Super + Shift + W

# Or manually
pkill waybar && waybar &
```

### Tray Toggle Not Working
```bash
# Verify state files
ls ~/.cache/waybar/

# Reset tray state
rm ~/.cache/waybar/tray_hidden
pkill -SIGUSR2 waybar
```

### Wallpaper Not Loading
```bash
# Verify file exists
ls -lh ~/wallpapers/default.jpg

# Restart hyprpaper
pkill hyprpaper && hyprpaper &
```

### Applications Not Auto-launching in Workspaces
```bash
# Check window class
hyprctl clients | grep -i "class"

# Verify windowrulev2 matches the class exactly
```

### GPU Temperature Not Showing
```bash
# Install lm_sensors
sudo dnf install lm-sensors

# Detect sensors
sudo sensors-detect

# Test reading
sensors | grep -i edge
```

### Notifications Not Appearing
```bash
# Check dunst is running
pgrep dunst

# Restart dunst
pkill dunst && dunst &

# Test notification
notify-send "Test" "This is a test notification"
```

## Credits

- **Hyprland:** [hyprwm/Hyprland](https://github.com/hyprwm/Hyprland)
- **Waybar:** [Alexays/Waybar](https://github.com/Alexays/Waybar)
- **Catppuccin Theme:** [catppuccin/catppuccin](https://github.com/catppuccin/catppuccin)
- **JetBrainsMono Nerd Font:** [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

## License

This configuration is released under the MIT License. See [LICENSE](LICENSE) file for details.

## About Soltros OS

[Soltros OS](https://github.com/soltros/Soltros-OS) is an immutable Linux desktop and server operating system built on Fedora CoreOS, designed for gaming and development workloads. Updates are delivered weekly as atomic images with seamless rollback capabilities. The system tracks Fedora's release cycle without disruptive major version upgrades, offering both LTS (stable) and Unstable (alpha/beta) release tracks.

## Author

Maintained by Derrik for [Soltros OS](https://github.com/soltros/Soltros-OS).
