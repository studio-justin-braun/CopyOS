# CopyOS – Konzept und Bauplan

CopyOS ist ein bewusst minimalistisches Linux-basiertes Sicherungs-OS, das unter dem Markendach „Studio Justin Braun“ firmiert. Dieses Repository bündelt den technischen Bauplan, Branding-Richtlinien sowie Build-Anweisungen, um ein auf USB-Sticks lauffähiges System zu erstellen, das Ordner von lokalen Laufwerken auf externe Datenträger kopiert – ohne Terminal-Expertise und mit einer geführten Schritt-für-Schritt-Oberfläche.

## Ziele des Projekts
- **Einfachheit:** Nutzer:innen sollen nur Quelle und Ziel auswählen und die Sicherung mit Enter bestätigen.
- **Universelle Einsatzfähigkeit:** Bootfähig von USB-Sticks auf sehr alter x86-Hardware (vergleichbar zu Knoppix-Unterstützung). Moderne Plattformen werden getestet, exotische Systeme werden soweit möglich durch generische Images adressiert.
- **Eigenständiges Branding:** Start-Splashscreen, Logo und CLI-Kommandos folgen einer modernen CopyOS-Identity.
- **Transparenz:** Dokumentation aller Design- und Entwicklungsentscheidungen in diesem Repository.

Weitere Details zur Architektur, zum UI-Fluss und zu den Custom-Kommandos befinden sich in `docs/`.

## Ordnerstruktur
- `docs/` – Technische Konzepte, UX-Flows, Branding-Assets und Build-Anleitungen.
- `docs/assets/` – Platzhalter für Splashscreen, Logo und UI-Mockups.

## Status
Dieses Repository enthält aktuell nur Dokumentation. Die beschriebenen Schritte ermöglichen es, CopyOS mit Buildroot zu bauen und anzupassen.

## Schnellstart: Komplettes Build mit einem Befehl
Wenn die Einrichtung nicht klappt oder Sie sich den kompletten Ablauf kopieren möchten, nutzen Sie einfach folgenden Copy-&-Paste Einzeiler. Er installiert alle benötigten Pakete (unter Debian/Ubuntu), klont dieses Repository und startet anschließend den automatisierten Build:

```bash
sudo apt-get update && \
  sudo apt-get install -y build-essential git wget cpio unzip python3 libncurses5-dev rsync bc && \
  git clone https://github.com/<your-org>/CopyOS.git && \
  cd CopyOS && \
  ./tools/copyos-build.sh
```

Das Skript klont Buildroot (Standard: Version `2024.02.1`), kopiert die vorkonfigurierten CopyOS-Vorlagen und startet den Build mit der Anzahl an CPU-Kernen des Systems. Nach erfolgreichem Lauf liegen die Images unter `buildroot/output/images/`.
