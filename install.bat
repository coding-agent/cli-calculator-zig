
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" && (

cd %~dp0

zig build

if %errorlevel% neq 0 (
    echo "Build failed. Exiting."
    exit /b %errorlevel%
)

mkdir C:\zig-cli-calculator

move zig-out\bin\zcl.exe C:\zig-cli-calculator\

setx PATH "%PATH%;%DEST_FOLDER%" /M
pause

) || (
powershell -Command "Start-Process '%0' -Verb RunAs"
)