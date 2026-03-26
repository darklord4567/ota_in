@echo off
setlocal enabledelayedexpansion

:: Path to your 7-Zip executable
set "sevenzip=C:\Program Files\7-Zip\7z.exe"

echo --------------------------------------------------
echo      OnePlus OTA Bulk Extractor (Multi-part)
echo --------------------------------------------------

:: Check if 7-zip exists
if not exist "%sevenzip%" (
    echo [ERROR] 7-Zip not found at %sevenzip%
    echo Please install 7-Zip or update the path in this script.
    pause
    exit /b
)

:: Loop through all files ending in .7z.001
for %%F in (*.7z.001) do (
    echo.
    echo [FOUND] %%F
    
    :: Get the base name without the .001 extension
    set "filename=%%~nF"
    
    echo [EXTRACTING] !filename! ...
    
    :: -y: Auto-answer yes to prompts
    :: x:  Extract with full paths
    "%sevenzip%" x "%%F" -y
    
    if %errorlevel% equ 0 (
        echo [SUCCESS] Extracted !filename!
    ) else (
        echo [FAILED] Error extracting %%F
    )
)

echo.
echo --------------------------------------------------
echo All detected parts have been processed.
pause