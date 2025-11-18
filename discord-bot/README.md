# DummyHook Discord Bot - Key Management System

This Discord bot allows you to generate, manage, and validate DummyHook keys directly from your Discord server.

## Features

- 🔑 Generate keys with custom levels (Basic, Premium, Elite)
- ⏱️ Set expiration dates for keys
- 🔒 HWID locking support
- 📋 List all keys in the database
- ✅ Validate keys
- 🗑️ Delete keys
- 📨 Send keys directly to users via DM

## Setup Instructions

### 1. Create a Discord Bot

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Click "New Application" and give it a name (e.g., "DummyHook Key Bot")
3. Go to the "Bot" section and click "Add Bot"
4. Enable these Privileged Gateway Intents:
   - Server Members Intent
   - Message Content Intent
5. Click "Reset Token" and copy your bot token (save it for later)
6. Copy your Application ID from the "General Information" section

### 2. Invite the Bot to Your Server

1. Go to OAuth2 → URL Generator
2. Select these scopes:
   - `bot`
   - `applications.commands`
3. Select these bot permissions:
   - Send Messages
   - Embed Links
   - Read Message History
4. Copy the generated URL and open it in your browser
5. Select your server and authorize the bot

### 3. Get Your Server ID

1. Enable Developer Mode in Discord (Settings → Advanced → Developer Mode)
2. Right-click your server icon and click "Copy Server ID"

### 4. Configure the Bot

1. Navigate to the `discord-bot` folder:
   ```bash
   cd discord-bot
   ```

2. Copy `.env.example` to `.env`:
   ```bash
   copy .env.example .env
   ```

3. Edit `.env` and add your credentials:
   ```
   DISCORD_BOT_TOKEN=your_bot_token_here
   CLIENT_ID=your_application_id_here
   GUILD_ID=your_server_id_here
   ```

### 5. Install Dependencies

```bash
npm install
```

### 6. Deploy Slash Commands

```bash
npm run deploy
```

### 7. Start the Bot

```bash
npm start
```

Or for development with auto-restart:
```bash
npm run dev
```

## Commands

### `/genkey`
Generate a new DummyHook key.

**Options:**
- `level` (required): Key access level (Basic, Premium, Elite)
- `duration` (optional): Key duration in days (default: 30)
- `hwid` (optional): Hardware ID lock (default: ANY)
- `user` (optional): User to send the key to via DM

**Example:**
```
/genkey level:Premium duration:90 user:@Username
```

### `/deletekey`
Delete a key from the database.

**Options:**
- `key` (required): The key to delete

**Example:**
```
/deletekey key:DUMMYHOOK-PREM-ABC123-2025
```

### `/listkeys`
List all keys in the database (shows first 10).

**Example:**
```
/listkeys
```

### `/checkkey`
Check if a key is valid and view its details.

**Options:**
- `key` (required): The key to check

**Example:**
```
/checkkey key:DUMMYHOOK-PREM-ABC123-2025
```

## Permissions

By default, only users with the "DummyHook Admin" role or Administrator permissions can use key management commands. The `/checkkey` command is available to all users.

To change the required role, edit `bot.js` and modify the `ADMIN_ROLE` in the CONFIG object.

## Key Storage

Keys are stored in `../Keys/keylist.json` and are automatically synced with the main DummyHook script.

## Troubleshooting

### Bot is offline
- Check that your bot token is correct in `.env`
- Make sure the bot is invited to your server
- Check the console for error messages

### Commands not appearing
- Run `npm run deploy` to register slash commands
- Make sure the bot has the `applications.commands` scope
- Try kicking and re-inviting the bot

### Permission errors
- Ensure users have the "DummyHook Admin" role
- Check that the bot has proper permissions in the server

### Keys not saving
- Ensure the bot has write permissions to the Keys folder
- Check that the path in `bot.js` CONFIG.KEYS_FILE is correct

## Support

For support, join our Discord server or open an issue on GitHub.
