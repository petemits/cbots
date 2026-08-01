@echo off
chcp 65001 >nul
echo ==========================================
echo    LEAD GENERATION BOT - BUILD SCRIPT
echo ==========================================
echo.

echo 🔧 Checking requirements...
where g++ >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ C++ compiler not found.
    echo 📥 Please install TDM-GCC from:
    echo    https://jmeubank.github.io/tdm-gcc/
    pause
    exit /b 1
)

echo ✅ Compiler found.

echo.
echo 📦 Downloading cURL library...
powershell -Command "if(!(Test-Path 'curl')) { mkdir curl }"

echo.
echo 🔨 Compiling Lead Generation Bot...
echo ⏳ This will take about 30 seconds...

:: Compile with cURL and Windows sockets
g++ -std=c++17 lead_bot_server.cpp -o leadbot.exe -lcurl -lws2_32 -O2 -s -static

if exist leadbot.exe (
    echo.
    echo ✅ BUILD SUCCESSFUL!
    echo.
    echo 🚀 To run the bot:
    echo    leadbot.exe
    echo.
    echo 🌐 Then open browser to:
    echo    http://localhost:8080
    echo.
    echo 📁 Folders created:
    echo    • reports/ - Generated reports
    echo    • leads/ - Exported CSV files
    echo.
    pause
) else (
    echo.
    echo ❌ Compilation failed.
    echo.
    echo 🔧 Trying alternative compilation...
    g++ -std=c++11 lead_bot_server.cpp -o leadbot.exe -lcurl -lws2_32
    if exist leadbot.exe (
        echo ✅ SUCCESS with alternative!
        echo.
        echo 🚀 Run: leadbot.exe
        pause
    ) else (
        echo ❌ Still failed.
        echo 💡 Try installing cURL development files.
        pause
    )
)