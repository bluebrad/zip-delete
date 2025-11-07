# zip-delete
To add a "Zip and Delete" option to your Windows right-click context menu, allowing you to compress a folder into a ZIP file and then delete the original folder
This requires 7zip to be installed x64 and upto date. 
follow these steps:
1. Create the Batch Script:
First, you'll need to create a batch script that performs the desired action.
    • Open Notepad:
        ◦ Press Win + R, type notepad, and press Enter.
    • Write the Script:
        ◦ Paste the following code into Notepad:
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
    echo Compression successful: "%ZipPath%"
    rem Delete the original folder
    rmdir /S /Q "%FolderPath%"
    echo Original folder deleted: "%FolderPath%"
) else (
    echo Compression failed for: "%FolderPath%"
)

popd
endlocal



Save the Script:
    • Click File > Save As.
    • Choose a location, set the file type to "All Files", and name it ZipAndDelete.bat.
    • Click Save.


2. Add to the Context Menu:
Next, you'll add an entry to the Windows Explorer context menu to execute this script.
    • Open the Registry Editor:
        ◦ Press Win + R, type regedit, and press Enter.
    • Navigate to the Directory Key:
        ◦ For all users:
        HKEY_CLASSES_ROOT\Directory\shell
        ◦ For the current user only:
        HKEY_CURRENT_USER\Software\Classes\directory\shell
    • Create a New Key:
        ◦ Right-click on shell, select New > Key, and name it ZipAndDelete.
   
    • Set the Menu Item Name:
        ◦ With the ZipAndDelete key selected, double-click the (Default) value in the right pane and set it to Zip and Delete.
   
    • Add an Icon (Optional):
        ◦ Right-click in the right pane, select New > String Value, and name it Icon.
    Double-click Icon and set its value to the path of an icon file, e.g., "C:\Program Files\7-Zip\7zG.exe".
   Create the Command Subkey:
   Right-click on the ZipAndDelete key, select New > Key, and name it command.

   Set the Command to Execute:
   With the command key selected, double-click the (Default) value in the right pane and set it to the path of your batch script, e.g., C:\Program Files\7-Zip\ZipAndDelete.bat "%1".

Important Considerations:
    • Backup the Registry:
        ◦ Before making changes, it's advisable to back up the registry. In the Registry Editor, select File > Export and save the backup.
    • Administrative Privileges:
        ◦ Ensure you have administrative rights to modify the registry and that your batch script has the necessary permissions to execute.
    • Testing:
        ◦ Test the context menu option with a sample folder to confirm it works as intended before using it on important data.
By following these steps, you'll have a "Zip and Delete" option in your right-click context menu, streamlining the process of compressing and removing folders.

