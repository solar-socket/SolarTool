@ECHO off
cls
:start
echo [47m-----------------------------------------------------[0m
echo.
echo     SolarTool - The easy way to fix [36mSolarTweaks.[0m
echo                   made by [31mSavrien[0m
echo.
echo            [36mhttps://discord.gg/solarsocket[0m
ECHO.
echo [47m-----------------------------------------------------[0m
echo.
ECHO 1. [4mInstall SolarTweaks[0m - [32mInstall SolarTweaks using the fixed launcher.[0m
ECHO 2. [4mFix SolarTweaks[0m - [32mAutomatically reinstalls SolarTweaks and replaces patcher.[0m
ECHO 3. [4mReplace Patcher[0m - [32mAutomatically replace patcher.[0m
echo.
ECHO ?. [4mDisplay help[0m - [32mGet info[0m
set choice=
set /p choice=Type your choice:
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto install
if '%choice%'=='2' goto uninst
if '%choice%'=='3' goto patcher
if '%choice%'=='?' goto info
cls
echo [41m"%choice%" is not a valid option.[0m
echo.
goto start
:uninst
REM Credit where credit is due, this is the original Solar Purge batch file
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------- 

taskkill /f /im "solar tweaks.exe"
rmdir /s /q "%userprofile%\.lunarclient\solartweaks"
rmdir /s /q "%appdata%\solartweaks"
"C:\Program Files\Solar Tweaks\Uninstall Solar Tweaks.exe"
cls
echo [41mPlease press Ok in the uninstaller before continuing![0m
pause

goto install

REM install the laucher from the link specified when c.fix is ran in the discord
:install
cls
echo.
echo --DOWNLOADING INSTALLER--
echo.
powershell -Command "Invoke-WebRequest "https://cdn.discordapp.com/attachments/981343105448046632/1002045608804229141/Solar_Tweaks_Setup_4.0.3.exe" -OutFile Installer.exe"
echo.
echo --RUNNING INSTALLER--
echo.
installer
goto patcher
REM replace patcher jar.
:patcher
taskkill /f /im "solar tweaks.exe"
cls
IF EXIST solar-patcher.jar (
	echo solar-patcher.jar exists, deleting...
	del solar-patcher.jar
)
echo.
echo --DOWNLOADING PATCHER--
echo.
powershell -Command "Invoke-WebRequest "https://cdn.discordapp.com/attachments/981343105448046632/1002060638178250832/solar-patcher.jar" -OutFile %userprofile%\.lunarclient\solartweaks\solar-patcher.jar"
cls
echo.
echo [42mReplaced Solar Patcher! Make sure you run regular Lunar client to update it before you try Solar![0m
echo [41mIf your game crashes, try relaunching this and select option 3.[0m
echo.
pause
exit

:info
cls
echo.
echo [35m"What is SolarTweaks?"[37m:[0m
echo [36mSolarTweaks[32m is a Lunar client patcher which provides quality of life changes.[0m
echo [32mMore info can be found in the [36mDiscord server:[0m
echo [36mhttps://discord.gg/solarsocket
echo.
echo [35m"Why does this tool exist?"[37m:[0m
echo [32mCurrently, SolarTweaks is not so easy to get working, and there are a growing
echo [32mnumber of people who need help installing SolarTweaks. I made this tool[0m
echo [32mto make it easy to install and fix SolarTweaks.
echo.
echo [35m"What's the WebSocket URL for free cosmetics?"[37m:
echo [32mThe websocket url is [0m[41mwss://socket.solartweaks.com[0m
echo [32mMore info can be found in the Discord server.[0m
pause
cls
goto start
