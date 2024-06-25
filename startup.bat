@echo off
:: Disable command echoing for cleaner output

:: Set variables for startup folder and AHK script path
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "ahk_script=%~dp0PinBeWidgets.ahk"

:: Copy AHK script to startup folder
copy "%ahk_script%" "%startup_folder%"

:: Check if the copy operation was successful
if %errorlevel% equ 0 (
    echo PinBeWidgets.ahk has been successfully added to startup
) else (
    echo Failed to add PinBeWidgets.ahk to startup, please check permissions
)

:: Pause to keep the window open
pause
