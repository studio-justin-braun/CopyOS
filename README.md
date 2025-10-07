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
