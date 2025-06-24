@echo off
setlocal

rem Get the folder path from the first argument
set "FolderPath=%~1"

rem Check if the folder exists
if not exist "%FolderPath%" (
    echo Folder does not exist: "%FolderPath%"
    exit /b 1
)

rem Set the path for the ZIP file (same location as the folder)
set "ZipPath=%FolderPath%.zip"

rem Path to the 7-Zip executable
set "SevenZip=C:\Program Files\7-Zip\7z.exe"

rem Check if 7-Zip exists
if not exist "%SevenZip%" (
    echo 7-Zip executable not found at: "%SevenZip%"
    exit /b 1
)

rem Change to the parent directory of the folder
pushd "%FolderPath%\.."

rem Compress the folder into a ZIP file with maximum compression
"%SevenZip%" a -tzip "%ZipPath%" "%~nx1" -mx=9

rem Check if the compression was successful
if exist "%ZipPath%" (
    echo Compression successful. Original folder will be deleted.
    rem Delete the original folder
    rmdir /S /Q "%FolderPath%"
) else (
    echo Compression failed. Original folder not deleted.
)

popd
endlocal
