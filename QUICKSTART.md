# 🚀 DummyHook Quick Start Guide

> **✓ ALL BUGS FIXED - READY TO USE!**
> - ✓ Fixed all AddDropdown function calls
> - ✓ Proper module loading with fallback support  
> - ✓ Working key system with demo keys
> - ✓ Discord bot integration for key management
> - ✓ All tabs load properly (Rage, Visuals, Misc, Exploits, Sniper Duels, Config)

## 📋 What You Have

Your DummyHook project includes:

```
DummyHook/
├── Main.lua              # Main script with key system
├── Standalone.lua        # Simple standalone demo version
├── Loader.lua            # Smart loader (GitHub + local fallback)
├── UI/
│   └── Library.lua       # Premium UI library (Skeet/Aimware style)
├── Features/
│   ├── Aimbot.lua        # Advanced aimbot
│   ├── ESP.lua           # CS:GO style ESP
│   ├── Crosshair.lua     # Customizable crosshair
│   └── Misc.lua          # Utility features
├── README.md             # Full documentation
└── QUICKSTART.md         # This file
```

---

## 🎯 How to Use

### Option 1: Quick Demo (Standalone)
**For immediate testing:**

1. Copy `Standalone.lua`
2. Execute in your Roblox executor
3. Enter key: `DUMMYHOOK-PREMIUM-2025`
4. See the demo (limited functionality)

### Option 2: Full Version (Recommended)
**For complete features:**

#### Step 1: Upload to GitHub
1. Create a new GitHub repository
2. Upload all files maintaining the folder structure
3. Make the repository public

#### Step 2: Update URLs
In `Main.lua`, replace `YourUsername` with your GitHub username:
```
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/UI/Library.lua"))()
```

Do this for all 4 module loads in `Main.lua`.

#### Step 3: Get the Raw URL
1. Go to your GitHub repo
2. Click on `Main.lua`
3. Click "Raw" button
4. Copy the URL (should look like: `https://raw.githubusercontent.com/limitetn/DummyHook/main/Main.lua`)

#### Step 4: Execute
In your Roblox executor:
```lua
loadstring(game:HttpGet("YOUR_RAW_URL_HERE"))()
```

---

## 🔑 Key System

**Default Key:** `DUMMYHOOK-PREMIUM-2025`

### To Customize:
Edit in `Main.lua` (line 16-20):
```lua
local KeySystem = {
    Enabled = true,  -- Set false to disable
    Key = "YOUR-CUSTOM-KEY-HERE",
    KeyURL = "https://your-key-site.com",
    Discord = "discord.gg/yourserver"
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/limitetn/DummyHook/main/UI/Library.lua"))()

## 🎮 Features Overview

### 🎯 Aimbot
- **Activate:** Hold Right Mouse Button
- **Keybind:** Configurable in settings
- **FOV:** Adjustable circle indicator
- **Smoothing:** 0-100 for natural aim

### 👁️ ESP (Wallhack)
- **Boxes:** Player outlines
- **Health:** Color-coded bars
- **Names:** Player names
- **Distance:** Range indicator
- **Tracers:** Lines to players
- **Chams:** Full body highlights

### ✚ Crosshair
- **Customizable:** Size, color, thickness
- **Rainbow Mode:** Animated colors
- **Center Dot:** Optional
- **Gap:** Adjustable spacing

### 🛠️ Misc
- **Speed:** 16-200 walk speed
- **Jump:** 50-200 jump power
- **Fly:** Free movement
- **NoClip:** Walk through walls
- **Inf Jump:** Jump infinitely

---

## ⌨️ Controls

| Key | Action |
|-----|--------|
| `Right Shift` | Toggle GUI |
| `Right Mouse Button` | Activate Aimbot (when enabled) |
| `Space` (Fly mode) | Ascend |
| `Left Ctrl` (Fly mode) | Descend |

---

## 🎨 UI Navigation

1. **Tabs:** Click to switch between sections
2. **Toggles:** Click switch on right side
3. **Sliders:** Click and drag
4. **Dropdowns:** Click to expand
5. **Colors:** Click color box
6. **Drag:** Click and drag header to move

---

## ⚙️ Configuration

### Save Settings
1. Go to **Config** tab
2. Click **"Save Config"**
3. Settings saved as "default"

### Load Settings
1. Go to **Config** tab
2. Click **"Load Config"**
3. Previous settings restored

---

## 🐛 Troubleshooting

### Script Won't Load
- ✅ Check executor compatibility
- ✅ Verify GitHub URLs are correct
- ✅ Ensure repository is public
- ✅ Try the Standalone version first

### Key System Issues
- ✅ Use exact key: `DUMMYHOOK-PREMIUM-2025`
- ✅ Check caps lock
- ✅ Disable key system for testing (set `Enabled = false`)

### Features Not Working
- ✅ Some games have anti-cheat
- ✅ Check if executor supports Drawing library
- ✅ Try in a simple game first
- ✅ Verify all modules loaded correctly

### GUI Won't Show
- ✅ Press `Right Shift` key
- ✅ Check if CoreGui is accessible
- ✅ Try changing keybind in code
- ✅ Look for error messages in console

---

## 📊 Compatibility

### ✅ Tested Executors
- Synapse X
- Script-Ware
- Krnl
- Fluxus
- Electron

### ✅ Required Features
- Drawing API
- HttpGet
- loadstring
- CoreGui access
- Mouse input

### ⚠️ Known Limitations
- Some games block ESP
- Anti-cheats may detect aimbot
- Roblox updates may break features
- Drawing API required for visuals

---

## 🔄 Updates

To update the script:
1. Pull latest changes from GitHub
2. Update your repository
3. Users auto-get updates (if using web loader)

---

## 📞 Support

### Need Help?
1. Read the full README.md
2. Check Issues on GitHub
3. Join Discord: `discord.gg/dummyhook`
4. Submit bug reports with details

### Reporting Bugs
Include:
- Executor name & version
- Game name
- Error messages
- Steps to reproduce

---

## 🤖 Discord Bot for Key Management

**NEW:** Generate and manage keys directly from Discord!

### Quick Setup:

1. **Navigate to discord-bot folder:**
   ```bash
   cd discord-bot
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Configure the bot:**
   - Copy `.env.example` to `.env`
   - Add your Discord bot token and server ID
   - See `discord-bot/README.md` for detailed setup

4. **Deploy commands:**
   ```bash
   npm run deploy
   ```

5. **Start the bot:**
   ```bash
   npm start
   ```

### Available Commands:
- `/genkey` - Generate new keys with custom levels
- `/deletekey` - Remove keys from database
- `/listkeys` - View all active keys
- `/checkkey` - Validate a specific key

For detailed Discord bot setup, see `discord-bot/README.md`

---

## ⚖️ Important Notes

- ✋ **Use responsibly**
- 🚫 **Don't harass players**
- ⚠️ **Risk of ban**
- 📚 **Educational purposes**
- 🤝 **Respect game rules**

---

## 🌟 Next Steps

1. ✅ Test the Standalone version
2. ✅ Upload to GitHub for full features
3. ✅ Customize the key system
4. ✅ Share with your community
5. ✅ Report bugs and suggest features

---

**Enjoy DummyHook! 🎮**

*Made with ❤️ inspired by AirHub-V2, Aimware, and Skeet*
