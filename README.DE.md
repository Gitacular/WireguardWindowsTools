# WireguardWindowsTools
Eine Sammlung von Windows-Administratorhilfsmitteln, um WireGuard auf Deinem System zu managen.

Herzlich willkommen! Diese beiden Dateien stellen einen Watchdog für Deine Windows- oder Windows Server WireGuard-Installation bereit.

WireGuard selbst bietet einen stabilen Client, der sich nach einem Windows-Neustart automatisch neu startet und erneut verbindet. Aber wenn Du dynamisches DNS verwendest (typisch für Heim- oder mobile Verbindungen), kann Deine WireGuard-Verbindung manchmal inaktiv werden. Das ist normal, weil WireGuard nicht für solche Szenarien entwickelt wurde, und genau hier kommt dieses Tool ins Spiel.

## Was macht WireguardWatchdog?

1. **Überprüfung der Verbindung:** WireguardWatchdog überwacht Deine Verbindung von einem Windows Server zu z.B. einer AVM FritzBox, um sicherzustellen, dass sie aktiv bleibt.
2. **Wiederherstellung:** Wenn die Verbindung inaktiv wird (z.B. der Netzwerkadapter unterbricht die Verbindung), stellt das Skript Deine Konfiguration automatisch wieder her.
3. **Verwaltung von Protokolldateien:** Wenn Deine Protokolldatei 100 MB erreicht, wird sie automatisch komprimiert.

## Voraussetzungen

- Windows 10 oder höher | Windows Server 2016 oder höher
- Administrative Rechte auf Deinem Computer
- Installierter WireGuard-Client
- Konfigurierter WireGuard-Client
- Du musst Deine individuellen Pfade kennen, falls Du die Standardeinstellungen geändert hast.

## Enthaltene Dateien

Du erhältst und benötigst zwei Dateien:

- `InstallPlan.bat` – Das Installations-Skript
- `WireguardWatchdog.ps1` – Die Vorlage für das Watchdog-Skript

## Was macht das Installations-Skript?

- Es fragt Dich nach den Pfaden und Speicherorten Deiner WireGuard-Installation auf Deinem System.
- Es definiert Variablen für das Installationsziel und den Speicherort der WireGuard-Anwendung.
- Es erstellt eine geplante Aufgabe mit Systemrechten für die Hintergrundfunktionalität.
- Optional kann es die geplante Aufgabe für Dich starten, mit einer kurzen Pause am Ende.
- Das Skript verwendet `/` als Verzeichnistrennzeichen.

## Was das Installations-Skript NICHT tut

- Es installiert WireGuard selbst nicht.
- Es konfiguriert keine Tunnel.
- Es ändert oder löscht keine Tunnel.
- Es funktioniert nicht korrekt, wenn Du Änderungen vornimmst, von denen Du keine Ahnung hast.
- Es enthält keinen Deinstallationsmechanismus.

## Installation

Um zu installieren, platziere einfach beide Dateien an einem Ort mit Zugriff und führe `InstallPlan.bat` aus. Wenn Du keine administrativen Rechte hast, wird Deine Sitzung erhöht. Andernfalls kannst Du es direkt ausführen. Nachdem `InstallPlan.bat` abgeschlossen ist, kannst Du beide Dateien bei Bedarf löschen.

## Deinstallation

Um das Skript zu deinstallieren, lösche die `.ps1`- und `.log`-Dateien aus dem Installationsverzeichnis und lösche dann die zugehörige geplante Aufgabe. Das war's!
