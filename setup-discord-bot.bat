@echo off
echo ========================================
echo DummyHook Discord Bot - Quick Setup
echo ========================================
echo.

cd discord-bot

echo [1/4] Checking if Node.js is installed...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js is not installed!
    echo Please download and install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)
echo ✓ Node.js found!
echo.

echo [2/4] Installing dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to install dependencies!
    pause
    exit /b 1
)
echo ✓ Dependencies installed!
echo.

echo [3/4] Checking configuration...
if not exist .env (
    echo WARNING: .env file not found!
    echo Creating .env from template...
    copy .env.example .env >nul
    echo.
    echo IMPORTANT: Edit discord-bot\.env and add your bot credentials!
    echo - DISCORD_BOT_TOKEN
    echo - CLIENT_ID
    echo - GUILD_ID
    echo.
    echo Press any key to open .env file...
    pause >nul
    notepad .env
)
echo.

echo [4/4] Setup complete!
echo.
echo Next steps:
echo 1. Make sure .env is configured with your bot credentials
echo 2. Run: npm run deploy    (to deploy slash commands)
echo 3. Run: npm start          (to start the bot)
echo.
echo ========================================
pause
