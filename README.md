# 🎯 DummyHook - Premium Roblox Script

**Version:** 1.0.0  
**Inspired by:** AirHub-V2, Aimware, Skeet

A premium universal Roblox script featuring an advanced Aimbot, ESP, Crosshair, and various utility features with a sleek Aimware/Skeet-inspired UI.

---

## ✨ Features

### 🎯 Rage Features
- **Advanced Aimbot**
  - Customizable FOV (Field of View)
  - Adjustable smoothness/smoothing
  - Target part selection (Head, Torso, HumanoidRootPart)
  - Visibility check
  - Team check
  - FOV circle indicator
  - Movement prediction
  - Trigger bot support

### 👁️ Visual Features
- **ESP (Wallhack)**
  - Player boxes with outlines
  - Name tags
  - Distance indicators
  - Health bars with dynamic colors
  - Tracers
  - Chams (Highlights)
  - Team check
  - Customizable colors

- **Crosshair**
  - Customizable size and thickness
  - Color picker
  - Rainbow mode
  - Center dot option
  - Outline support

### 🛠️ Misc Features
- Adjustable walk speed
- Adjustable jump power
- No Clip (walk through walls)
- Fly mode
- Infinite jump
- FOV changer
- Full bright
- No fog
- Anti-AFK

### 🔐 Key System
- Secure authentication
- Discord integration
- Easy key distribution
- Copy to clipboard functionality

---

## 🚀 Installation

### Method 1: Direct Load (Recommended)
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua"))()
```

### Method 2: Manual Load
1. Download all files from this repository
2. Execute `Main.lua` in your executor

---

## 🎮 Usage

### Key System
1. When you first load the script, a key authentication window will appear
2. Click **"GET KEY"** to copy the key link to your clipboard
3. Visit the link to obtain your key
4. Enter the key in the input box
5. Click **"SUBMIT KEY"** to authenticate

**Default Key (for testing):** `DUMMYHOOK-PREMIUM-2025`

### Opening the GUI
- **Default Keybind:** `Right Shift`
- Press the keybind to toggle the GUI visibility
- You can change the keybind in the Settings tab

### Tabs Overview

#### 🎯 Rage Tab
Configure aimbot settings:
- Enable/Disable aimbot
- Adjust FOV range
- Set smoothness
- Choose target part
- Toggle visibility check
- Enable team check

**Tip:** Hold `Right Mouse Button` to activate aimbot

#### 👁️ Visuals Tab
Configure ESP and crosshair:
- Enable/Disable ESP
- Toggle individual ESP features
- Customize colors
- Enable crosshair
- Adjust crosshair settings

#### 🛠️ Misc Tab
Movement and utility features:
- Adjust walk speed (16-200)
- Adjust jump power (50-200)
- Enable movement cheats
- Toggle utility features

#### ⚙️ Config Tab
- Save your settings
- Load saved configurations
- Unload the script

---

## 🎨 UI Features

### Aimware/Skeet Inspired Design
- Dark theme with accent colors
- Animated rainbow gradient header
- Smooth animations and transitions
- Draggable window
- Organized tab system
- Premium feel

### Controls
- **Toggle Elements:** Click the switch on the right
- **Sliders:** Click and drag to adjust values
- **Dropdowns:** Click to open, select an option
- **Color Pickers:** Click the color box to change
- **Drag Window:** Click and drag the header

---

## 🔧 Configuration

### Key System Configuration
Edit `Main.lua` to customize:
```
local KeySystem = {
    Enabled = true,  // Set to false to disable key system
    Key = "DUMMYHOOK-PREMIUM-2025",  // Your custom key
    KeyURL = "https://dummyhook.io/getkey",  // Your key distribution link
    Discord = "discord.gg/dummyhook"  // Your Discord server
}
```

### Default Settings
All features are configurable via the GUI. Settings are preserved across sessions when using the Config save/load feature.

---

## 📂 Project Structure
```
DummyHook/
├── Main.lua              # Main loader with key system
├── UI/
│   └── Library.lua       # UI library (Skeet/Aimware style)
├── Features/
│   ├── Aimbot.lua        # Aimbot module
│   ├── ESP.lua           # ESP/Wallhack module
│   ├── Crosshair.lua     # Crosshair module
│   └── Misc.lua          # Miscellaneous features
└── README.md             # Documentation
```

---

## ⚠️ Disclaimer

This script is for **educational purposes only**. 

- Use at your own risk
- The developers are not responsible for any bans or consequences
- Respect game rules and other players
- Do not use this to harass or ruin others' gameplay

---

## 🤝 Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📧 Support

- **Discord:** discord.gg/dummyhook
- **Issues:** Use the GitHub Issues tab
- **Updates:** Watch the repository for updates

---

## 📝 Changelog

### Version 1.0.0 (Initial Release)
- ✅ Advanced aimbot with FOV, smoothing, and prediction
- ✅ CS:GO style ESP with boxes, health, names, distance
- ✅ Customizable crosshair
- ✅ Movement features (speed, fly, noclip)
- ✅ Utility features (fullbright, anti-afk)
- ✅ Key system authentication
- ✅ Aimware/Skeet inspired UI
- ✅ Config save/load system

---

## 🌟 Credits

- **Inspired by:** Exunys (AirHub-V2)
- **UI Design:** Aimware & Skeet
- **Developer:** DummyHook Team

---

## 📜 License

This project is open source and available under the MIT License.

---

**Enjoy DummyHook! 🎮**
