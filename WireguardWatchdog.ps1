$wgPath = "PLACEHOLDER_WGPATH"
$wgExecutable_wgexe = "${wgPath}\wg.exe"
$wgExecutable_wireguardexe = "${wgPath}\wireguard.exe"
$wgConfigDir = "${wgPath}\PLACEHOLDER_CONFIGDIR"
$wgWatchConfig = "${wgConfigDir}\PLACEHOLDER_WATCHCONFIG"
$tunnelName = "PLACEHOLDER_TUNNELNAME"
$RepeatEvery = "PLACEHOLDER_REPEATEVERY"
$FolderPath = "PLACEHOLDER_FOLDERPATH"
$ScriptName = "PLACEHOLDER_SCRIPTNAME"

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $logFile = "$FolderPath\$ScriptName.log"
    $masterLog = "$FolderPath\$ScriptName.Full.log"

    Start-Transcript -Path $logFile

    $adapterExist = Get-NetAdapter | Where-Object { $_.Name -eq $tunnelName }
    if ($adapterExist) {
        Write-Host "[$timestamp] WireGuard-Netzwerkadapter gefunden, alles ist gut."
    } else {
        Write-Host "[$timestamp] Netzwerkadapter nicht gefunden. Versuche, WireGuard neu zu starten..."
        & $wgExecutable_wireguardexe /installtunnelservice $wgWatchConfig
    }

    Stop-Transcript

    $currentLog = Get-Content $logFile
    $indexOfStart = $currentLog | Select-String -Pattern "Die Aufzeichnung wurde gestartet."
    $actualLogs = $currentLog[($indexOfStart.LineNumber)..($currentLog.Count - 1)]

    # Filtere unerwünschte Zeilen heraus
    $actualLogs = $actualLogs | Where-Object { $_ -notmatch "^\*+$" }
    $actualLogs = $actualLogs | ForEach-Object {
    if ($_ -match "Endzeit:") {
        $_ -replace "Endzeit:", "[$timestamp] Skript beendet um"
    } elseif ($_ -notmatch "Ende der Windows PowerShell-Aufzeichnung") {
        $_
    }
    }

    $username = $currentLog | Select-String -Pattern "Benutzername:" | ForEach-Object { $_ -replace "Benutzername: ", "" }
    $headerLine = "[$timestamp] Scriptausführung durch $username, Script $FolderPath\$ScriptName.ps1"

    $oldMasterLog = Get-Content $masterLog -Raw
    $newMasterLog = "$headerLine`r`n$($actualLogs -join "`r`n")`r`n$oldMasterLog"
    Set-Content -Path $masterLog -Value $newMasterLog

    $archivePath = "$FolderPath\$ScriptName.log.archive.zip"
    $logFileSize = (Get-Item "$masterLog").Length / 1MB

    if ($logFileSize -ge 100) {
    $archiveEntryName = "$timestamp-$ScriptName.log"

    # Archiviere das aktuelle Log und leere es
    if (Test-Path $archivePath) {
        Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
        Compress-Archive -Path $masterLog -Update -DestinationPath $archivePath -CompressionLevel Optimal
    } else {
        Compress-Archive -Path $masterLog -DestinationPath $archivePath
    }

    # Leere das Master-Log
    Clear-Content $masterLog
    }

    Start-Sleep -Seconds $RepeatEvery
}
