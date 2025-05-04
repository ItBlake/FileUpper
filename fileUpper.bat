@echo off
title FileUpper
setlocal enabledelayedexpansion

:: History log stuff
set loguploads=false
set history_file=upload_history.txt

:: Set the maximum allowed file size (512 MiB)
set max_size=536870912

:: Check if a file or folder is dragged and dropped
if "%~1"=="" (
    echo Drag and drop a file or folder onto this script to upload to 0x0.st
    pause
    exit /b
)

:: Initialize flags and variables
set "is_folder=false"
set "temp_zip=upload_temp.zip"
set "total_size=0"

:: Only handle the first dragged file or folder
set "target=%~1"

:: Calculate the size
if exist "%target%\" (
    set is_folder=true
    echo Calculating size of folder "%target%"...

    for /f "tokens=3" %%A in ('dir /s /a "%target%" ^| findstr "bytes"') do (
        set /a total_size=%%A
    )
) else (
    for /f "tokens=3" %%A in ('dir /a "%target%" ^| findstr "bytes"') do (
        set /a total_size=%%A
    )
)

:: Check size against limit
if !total_size! gtr %max_size% (
    echo Error: The file or folder exceeds the 512.0 MiB limit for uploads.
    pause
    exit /b
)

:: Zip if it's a folder
if "!is_folder!"=="true" (
    echo Zipping folder...
    powershell Compress-Archive -Path "%target%" -DestinationPath "!temp_zip!" -Force
    set "file=!temp_zip!"
) else (
    set "file=%target%"
)

:: Upload to 0x0.st
echo Uploading: "!file!"
for /f "usebackq delims=" %%A in (`curl -# -F "file=@!file!" https://0x0.st`) do (
    set "url=%%A"
)

:: Check result
if "!url!"=="</html>" (
    echo Error: File is too large for 0x0.st upload or failed to upload.
    pause
    exit /b
)

echo.
echo File URL: !url!

:: Copy to clipboard
echo !url! | clip

:: Log history
if /i "!loguploads!"=="true" (
    echo !date! !time! - Uploaded: !file! - URL: !url! >> !history_file!
)

echo.
echo QR Code for the URL:
curl qrcd.to/!url!
echo.

:: Clean up
if exist "!temp_zip!" del "!temp_zip!"

pause
