# WireguardWindowsTools
Eine Sammlung von Windows-Administratorhilfsmitteln zur Verwaltung von WireGuard auf Ihrem System.

Herzlich willkommen! Diese beiden Dateien stellen einen Watchdog für Ihre Windows- oder Windows Server WireGuard-Installation bereit.

WireGuard selbst bietet einen stabilen Client, der automatisch nach einem Windows-Neustart neu gestartet und wieder verbunden wird. Wenn Sie jedoch dynamische DNS (üblich bei Heim- oder mobilen Verbindungen) verwenden, kann Ihre WireGuard-Verbindung manchmal inaktiv werden. Dies ist normal, da WireGuard nicht für solche Szenarien ausgelegt ist, und hier kommt dieses Werkzeug ins Spiel.

## Was macht WireguardWatchdog?

1. **Überprüfung der Verbindung:** WireguardWatchdog überwacht Ihre Verbindung von einem Windows Server zu beispielsweise einer AVM FritzBox, um sicherzustellen, dass sie aktiv bleibt.
2. **Wiederherstellung:** Wenn die Verbindung inaktiv wird (z. B. die Netzwerkadapterverbindung unterbricht), stellt das Skript Ihre Konfiguration automatisch wieder her.
3. **Verwaltung von Protokolldateien:** Wenn Ihre Protokolldatei 100 MB erreicht, wird sie automatisch komprimiert.

## Voraussetzungen

- Windows 10 oder höher | Windows Server 2016 oder höher
- Administrative Rechte auf Ihrem Computer
- Installierter WireGuard-Client
- Konfigurierter WireGuard-Client
- Kenntnis Ihrer individuellen Pfade, wenn Sie die Standardeinstellungen geändert haben

## Enthaltene Dateien

Sie erhalten und benötigen zwei Dateien:

- `InstallPlan.bat` – Das Installations-Skript
- `WireguardWatchdog.ps1` – Die Vorlage für das Watchdog-Skript

## Was macht das Installations-Skript?

- Es fordert Sie auf, die Pfade und Speicherorte Ihrer WireGuard-Installation auf Ihrem System anzugeben.
- Es definiert Variablen für das Installationsziel und den Speicherort der WireGuard-Anwendung.
- Es erstellt eine geplante Aufgabe mit Systemrechten für die Hintergrundfunktionalität.
- Optional kann es die geplante Aufgabe für Sie starten, mit einer kurzen Pause am Ende.
- Das Skript verwendet `/` als Verzeichnistrennzeichen.

## Was das Installations-Skript NICHT tut

- Es installiert WireGuard selbst nicht.
- Es konfiguriert keine Tunnel.
- Es ändert oder löscht keine Tunnel.
- Es funktioniert nicht korrekt, wenn Sie Änderungen vornehmen, mit denen Sie nicht vertraut sind.
- Es enthält keinen Deinstallationsmechanismus.

## Installation

Um zu installieren, platzieren Sie einfach beide Dateien an einem Ort mit Zugriff und führen Sie `InstallPlan.bat` aus. Wenn Sie keine administrativen Rechte haben, wird Ihre Sitzung erhöht. Andernfalls können Sie es direkt ausführen. Nachdem `InstallPlan.bat` abgeschlossen ist, können Sie beide Dateien bei Bedarf löschen.

## Deinstallation

Um das Skript zu deinstallieren, löschen Sie die `.ps1` und `.log`-Dateien aus dem Installationsverzeichnis und löschen Sie dann die zugehörige geplante Aufgabe. Das ist alles!
