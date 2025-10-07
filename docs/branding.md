# Branding-Richtlinien für CopyOS

## 1. Logos & Splashscreen
- Offizielles Splash-Image: `http://watchy.online/CopyOS.png`
- Datei herunterladen und in `docs/assets/splashscreen.png` speichern:
  ```bash
  curl -L -o docs/assets/splashscreen.png http://watchy.online/CopyOS.png
  ```
- Logo-Variation: Weiß auf dunklem Hintergrund (#0B0E14).
- Platzierungsregeln: Logo mittig, Claim „Sichern. Fertig.“ darunter.

## 2. Farbschema
| Verwendungszweck         | Farbwert |
|--------------------------|---------|
| Primär (Buttons, Links)  | `#1F4B99` |
| Sekundär (Highlights)    | `#00C4B3` |
| Hintergrund dunkel       | `#0B0E14` |
| Hintergrund hell (Karten)| `#121826` |
| Text primär              | `#FFFFFF` |
| Text sekundär            | `#D8DEE9` |
| Warnungen                | `#FF6B6B` |
| Erfolg                   | `#3FCF8E` |

## 3. Typografie
- Primärschrift: **Inter** (Variable Font, SIL Open Font License)
- Alternative: **Source Sans Pro**
- Terminal/Monospace: **JetBrains Mono** oder **Fira Code** (für Logs)

## 4. UI-Elemente
- Buttons: Abgerundete Ecken (6px Radius), leichte Schatten (0 4px 12px rgba(0,0,0,0.2)).
- Icons: Lineare Icons (Feather Icons Stil), 2px Strichstärke, weiß oder Sekundärfarbe.
- Progressbar: 6px Höhe, Sekundärfarbe, auf dunkler Schiene.

## 5. Tonality
- Sprache freundlich, direkt, „Du“-Ansprache.
- Kurze Sätze, positive Bestätigung.
- Fehlermeldungen immer mit nächstem Schritt („Bitte USB-Stick prüfen und erneut versuchen“).

## 6. Druckmaterial & Dokumente
- DIN-A4-Template mit dunklem Titelbalken (#1F4B99) und CopyOS-Logo links.
- QR-Code zum Download des aktuellen Images.

## 7. Lizenzhinweise
- Logo und Name „CopyOS“ © Studio Justin Braun.
- Offene Komponenten (Linux Kernel, BusyBox, Buildroot) behalten ihre jeweiligen Lizenzen. Dokumentation zu Lizenztexten unter `docs/licenses/` (noch anzulegen).
