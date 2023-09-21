CHCP 1252
@echo off
setlocal
:: Version 1.0
:: Prüfe auf Admin-Rechte und fordere diese an, falls nicht vorhanden
echo Check if User is Admin.
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Keine Admin-Rechte. Versuche, Admin-Rechte zu erhalten.
    powershell "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:: Setze Variablen für die Standardpfade
echo Default Variables are being created. 
set "DefaultFolderPath=%systemdrive%\apps"
set "DefaultScriptName=WireguardWatchdog"
set "DefaultWGPath=%systemdrive%\Program Files\WireGuard"
set "DefaultConfigDir=Data\Configurations"
set "DefaultWatchConfig=wg-config.conf.dpapi"
set "DefaultTunnelName=wg-config"
set "DefaultRepeatEvery=60"

:: Frage den User nach den gewünschten Pfaden
echo Install Path and Config for the Powershell Script
:: (dein Code für die Abfragen)
set /p "FolderPath=Select Install Path for Script [Standard %DefaultFolderPath%]: "
set /p "ScriptName=Select Install Name for Script and Task without .ps1[Standard %DefaultScriptName%]: "
set /p "RepeatEvery=Check Interval of WG Tunnel in Seconds [Standard %DefaultRepeatEvery%]: "
echo Location of Wireguard and Configs?
set /p "WGPath=Wireguard Install Dir? [Standard %DefaultWGPath%]: "
set /p "ConfigDir=Config Dir? [Standard %DefaultConfigDir%]: "
set /p "WatchConfig=Config File? [Standard %DefaultWatchConfig%]: "
set /p "TunnelName=Tunnel Name [Config File Name without extension]? [Standard %DefaultTunnelName%]: "

:: Setze die Standardpfade, falls keine Angabe gemacht wurde
echo Set default path if no response was made
if "%FolderPath%"=="" set "FolderPath=%DefaultFolderPath%"
if "%ScriptName%"=="" set "ScriptName=%DefaultScriptName%"
if "%WGPath%"=="" set "WGPath=%DefaultWGPath%"
if "%ConfigDir%"=="" set "ConfigDir=%DefaultConfigDir%"
if "%WatchConfig%"=="" set "WatchConfig=%DefaultWatchConfig%"
if "%TunnelName%"=="" set "TunnelName=%DefaultTunnelName%"
if "%RepeatEvery%"=="" set "RepeatEvery=%DefaultRepeatEvery%"

:: Überprüfe, ob der Ordner existiert
echo Check if desired folder exists
if not exist "%FolderPath%\" (
    mkdir "%FolderPath%" 2>nul
)

:: Kopiere die Vorlage und ersetze die Platzhalter
echo Copying and modifying PowerShell template...
copy ".\WireguardWatchdog.ps1" "%FolderPath%\%ScriptName%.ps1"

:: Ersetze die Platzhalter in der PowerShell-Datei
echo Replace Placeholders
powershell -Command "(Get-Content '%FolderPath%\%ScriptName%.ps1') -replace 'PLACEHOLDER_WGPATH', '%WGPath%' -replace 'PLACEHOLDER_CONFIGDIR', '%ConfigDir%' -replace 'PLACEHOLDER_WATCHCONFIG', '%WatchConfig%' -replace 'PLACEHOLDER_TUNNELNAME', '%TunnelName%' -replace 'PLACEHOLDER_REPEATEVERY', '%RepeatEvery%' -replace 'PLACEHOLDER_FOLDERPATH', '%FolderPath%' -replace 'PLACEHOLDER_SCRIPTNAME', '%ScriptName%' | Set-Content '%FolderPath%\%ScriptName%.ps1'"
:: Erstelle die geplante Aufgabe
echo Create scheduled task.
schtasks /create /tn "%ScriptName%" /tr "powershell -File '%FolderPath%\%ScriptName%.ps1'" /sc ONSTART /ru SYSTEM /f
echo.
echo Done! The Script %ScriptName%.ps1 tried to install and create the scheduled task, named %ScriptName%, created.
echo Please check %FolderPath% and the Scheduled tasks for availability.
echo To uninstall, just delete the %FolderPath%\%ScriptName%.ps1, .log and the scheduled task %ScriptName%.
echo Thank you for using the installer. 
echo After the following keypress the scheduled task will be started. Otherwise close (X) this window.
pause
schtasks /run /tn "%ScriptName%"
endlocal
