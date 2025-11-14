# 🚀 GitHub Setup Guide for DummyHook

This guide will help you set up DummyHook on GitHub so users can load it via loadstring.

---

## 📋 Prerequisites

- GitHub account (create one at https://github.com)
- Git installed (optional, can use GitHub web interface)
- All DummyHook files ready

---

## 🌐 Method 1: GitHub Web Interface (Easiest)

### Step 1: Create Repository

1. Go to https://github.com
2. Click the **"+"** icon (top right) → **"New repository"**
3. Fill in details:
   - **Repository name:** `DummyHook` (or your choice)
   - **Description:** "Premium Roblox script with Aimbot, ESP, and more"
   - **Visibility:** ✅ **Public** (must be public for raw URLs)
   - **Initialize:** ❌ Don't add README (we have our own)
4. Click **"Create repository"**

### Step 2: Upload Files

1. Click **"uploading an existing file"** link
2. Drag and drop all files:
   - Main.lua
   - Standalone.lua
   - Loader.lua
   - README.md
   - QUICKSTART.md
   - CHANGELOG.md
   - SETUP_GITHUB.md

3. Then create folders:
   - Click **"Create new file"**
   - Type: `UI/Library.lua`
   - Paste Library.lua content
   - Click **"Commit new file"**

4. Repeat for Features folder:
   - `Features/Aimbot.lua`
   - `Features/ESP.lua`
   - `Features/Crosshair.lua`
   - `Features/Misc.lua`

### Step 3: Get Raw URLs

1. Navigate to `Main.lua` in your repo
2. Click **"Raw"** button
3. Copy the URL (example):
   ```
   https://raw.githubusercontent.com/YourUsername/DummyHook/main/Main.lua
   ```

4. Repeat for all module files:
   - UI/Library.lua
   - Features/Aimbot.lua
   - Features/ESP.lua
   - Features/Crosshair.lua
   - Features/Misc.lua

### Step 4: Update Main.lua

1. In your repo, click `Main.lua`
2. Click the **pencil icon** (Edit)
3. Find this section (around line 230):
   ```lua
   local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/DummyHook/main/UI/Library.lua"))()
   ```

4. Replace **"YourUsername"** with your actual GitHub username

5. Do the same for all 4 module loads:
   - UI/Library.lua
   - Features/ESP.lua
   - Features/Aimbot.lua
   - Features/Crosshair.lua
   - Features/Misc.lua

6. Click **"Commit changes"**

### Step 5: Test

1. Copy your Main.lua raw URL
2. In Roblox executor, run:
   ```lua
   loadstring(game:HttpGet("YOUR_RAW_URL"))()
   ```

3. Enter key: `DUMMYHOOK-PREMIUM-2025`
4. Verify features load correctly

---

## 💻 Method 2: Git Command Line (Advanced)

### Step 1: Initialize Repository

```bash
cd /path/to/DummyHook
git init
git add .
git commit -m "Initial commit - DummyHook v1.0.0"
```

### Step 2: Connect to GitHub

```bash
git remote add origin https://github.com/YourUsername/DummyHook.git
git branch -M main
git push -u origin main
```

### Step 3: Update URLs

1. Edit `Main.lua` locally
2. Replace `YourUsername` with your GitHub username
3. Save and commit:
   ```bash
   git add Main.lua
   git commit -m "Updated GitHub URLs"
   git push
   ```

---

## 🔑 Customize Your Key System

### Option 1: Simple Custom Key

In `Main.lua`, edit:
```lua
local KeySystem = {
    Enabled = true,
    Key = "YOUR-CUSTOM-KEY-2025",  -- Change this
    KeyURL = "https://pastebin.com/your-key",
    Discord = "discord.gg/yourserver"
}
```

### Option 2: Disable Key System

```lua
local KeySystem = {
    Enabled = false,  -- Set to false
    -- ... rest doesn't matter
}
```

### Option 3: Advanced Key System

Create a key server with multiple keys:
```lua
-- Example: Load keys from external source
local validKeys = game:HttpGet("https://your-site.com/keys.txt"):split("\n")

-- Then check if entered key is in the list
for _, key in pairs(validKeys) do
    if enteredKey == key then
        -- Valid!
    end
end
```

---

## 📤 Distribution

### Share Your Script

Once uploaded, share this with users:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/DummyHook/main/Main.lua"))()
```

### Create a Short Link (Optional)

Use services like:
- bit.ly
- tinyurl.com
- is.gd

Example:
```lua
loadstring(game:HttpGet("https://bit.ly/dummyhook"))()
```

---

## 🔄 Updates

### To Update Your Script

#### Method 1: Web Interface
1. Navigate to the file
2. Click pencil icon
3. Make changes
4. Commit changes
5. Users auto-get updates on next load!

#### Method 2: Git
```bash
git add .
git commit -m "Update description"
git push
```

### Version Tracking

Update version in:
1. `Main.lua` (line 2)
2. `README.md`
3. `CHANGELOG.md`

---

## 🛡️ Security Tips

### Protect Your Repository

1. **Never commit:**
   - Personal information
   - Real Discord tokens
   - Actual key databases
   - Sensitive data

2. **Use .gitignore:**
   Create `.gitignore` file:
   ```
   config.local.lua
   keys.txt
   *.log
   ```

3. **Keep keys separate:**
   Host keys on a different platform

### Anti-Leak Protection

For premium versions:
```lua
-- Add HWID check
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local allowedHWIDs = {"hwid1", "hwid2"}

if not table.find(allowedHWIDs, hwid) then
    return
end
```

---

## 📊 Repository Best Practices

### README.md Should Include:
- ✅ Feature list
- ✅ Installation instructions
- ✅ Screenshots/GIFs
- ✅ Contact information
- ✅ Disclaimer

### Good Commit Messages:
- ✅ "Fix aimbot FOV calculation"
- ✅ "Add rainbow mode to crosshair"
- ✅ "Update ESP colors"
- ❌ "update"
- ❌ "fix"
- ❌ "changes"

### Use Releases:
1. Go to **Releases** tab
2. Click **"Create a new release"**
3. Tag version: `v1.0.0`
4. Title: "DummyHook v1.0.0 - Initial Release"
5. Description: Copy from CHANGELOG.md
6. Attach files if needed

---

## 🎯 Post-Setup Checklist

After setup, verify:

- [ ] Repository is public
- [ ] All files uploaded correctly
- [ ] Folder structure maintained (UI/, Features/)
- [ ] URLs updated in Main.lua
- [ ] Raw URLs work (test in browser)
- [ ] Script loads in executor
- [ ] Key system works
- [ ] All features functional
- [ ] README.md displays correctly
- [ ] License added (optional)

---

## 🆘 Troubleshooting

### "Raw URL returns 404"
- ✅ Make sure repository is **public**
- ✅ Check file path is correct
- ✅ Wait a few seconds after upload

### "Failed to load module"
- ✅ Verify all module URLs are correct
- ✅ Check file names match exactly
- ✅ Ensure no typos in folder names

### "Invalid syntax" errors
- ✅ Don't edit files in GitHub's web editor (formatting issues)
- ✅ Use proper text editor locally
- ✅ Check for BOM characters

### Script loads but features don't work
- ✅ Check executor console for errors
- ✅ Verify executor supports Drawing API
- ✅ Test in a simple game first
- ✅ Check if game has anti-cheat

---

## 📝 Example Repository Structure

Your GitHub repo should look like:
```
YourUsername/DummyHook/
├── .gitignore
├── LICENSE (optional)
├── README.md
├── QUICKSTART.md
├── CHANGELOG.md
├── SETUP_GITHUB.md
├── Main.lua
├── Standalone.lua
├── Loader.lua
├── UI/
│   └── Library.lua
└── Features/
    ├── Aimbot.lua
    ├── ESP.lua
    ├── Crosshair.lua
    └── Misc.lua
```

---

## 🌟 Advanced: GitHub Pages (Optional)

Host a website for your script:

1. Create `index.html`
2. Enable GitHub Pages in Settings
3. Choose theme or use custom HTML
4. Add download buttons, instructions, etc.

---

## ✅ You're Done!

Your DummyHook script is now:
- ✅ Hosted on GitHub
- ✅ Accessible via loadstring
- ✅ Auto-updates for users
- ✅ Shareable with a simple link
- ✅ Version controlled
- ✅ Professional setup

**Share your loadstring and enjoy! 🎮**

---

## 📞 Need Help?

- GitHub Docs: https://docs.github.com
- Git Tutorial: https://git-scm.com/docs
- Markdown Guide: https://guides.github.com/features/mastering-markdown/

**Good luck with your script! 🚀**
