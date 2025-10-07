# CopyOS UI- und Experience-Konzept

Dieses Dokument beschreibt die Nutzerführung vom Boot bis zur abgeschlossenen Sicherung. Fokus: maximal einfache Bedienung ohne klassische Kommandozeilen-Eingaben.

## 1. Branding & Stil
- **Farben:**
  - Primär: #1F4B99 (Studio Justin Braun Blau)
  - Sekundär: #00C4B3 (Akzent für Fortschrittsanzeigen)
  - Hintergrund: #0B0E14 (dunkel, modern)
  - Text: #FFFFFF / #D8DEE9
- **Typografie:** Inter oder Source Sans Pro (je nach Lizenzlage in Buildroot-Paket einbinden).
- **Logo & Splash:** Boot-Splash zeigt `CopyOS`-Logo mit Untertitel „Studio Justin Braun“ und Claim „Sichern. Fertig.“ (siehe `docs/assets/splashscreen.png`).

## 2. Bootsequenz
1. BIOS/UEFI → GRUB/Barebox Menü mit CopyOS-Branding.
2. Splashscreen für 3–5 Sekunden, Fortschrittsbalken auf Basis der Kernel-Initialisierung.
3. Automatischer Start von `copyos-launcher` im Framebuffer- oder TTY-Modus.

## 3. Schritt-für-Schritt-Anleitung

### Bildschirm A: Willkommen
- Headline: „Willkommen bei CopyOS“
- Text: „Wir sichern jetzt Ihre Daten. Folgen Sie einfach den Anweisungen.“
- Buttons: `[Weiter]` (ENTER), `[Systeminformationen]` (F10), `[Beenden]` (ESC)

### Bildschirm B: Quellordner wählen
- Liste aller erkannten Laufwerke + Dateisysteme (z. B. `C: 120 GB NTFS (Windows)`).
- Nach Auswahl eines Laufwerks zeigt eine zweite Spalte Favoritenordner (`Dokumente`, `Desktop`, `Projekte`) + Option „Individuellen Ordner suchen“.
- Kontext-Hilfe rechts mit Schrittbeschreibung.

### Bildschirm C: Ziel wählen
- Standardmäßig wird der CopyOS-Stick vorgeschlagen.
- Option „Anderen Datenträger wählen“ (z. B. externe USB-Platte).
- Checkbox „Ziel vor Sicherung leeren (Formatieren)“ mit Warnhinweis.

### Bildschirm D: Zusammenfassung
- Tabelle mit Quelle → Ziel, geschätzter Speicherbedarf, Freier Speicher.
- Checkliste („Bitte sicherstellen, dass …“).
- Buttons: `[Sicherung starten]`, `[Zurück]`.

### Bildschirm E: Fortschritt
- Fortschrittsbalken (rsync `--info=progress2` geparst).
- Log-Auszug (letzte 5 Dateien).
- Hinweis „Sie können den Vorgang mit F2 im Log-Modus beobachten“.

### Bildschirm F: Abschluss
- Erfolgsmeldung oder Fehlerhinweis.
- Optionen: `[Log ansehen]`, `[Weitere Sicherung]`, `[Herunterfahren]`, `[Neustarten]`.

## 4. Tastatursteuerung
- ENTER = Primäre Aktion.
- ESC = Zurück/Abbrechen (mit Sicherheitsabfrage während Sicherung).
- F1 = Hilfe-Overlay mit Symbolerklärungen.
- F10 = Systeminformationen (Hostname, Kernel-Version, erkannte Laufwerke).

## 5. Barrierefreiheit
- Hoher Kontrast, Tastatur-only Bedienung, optional Screenreader (espeakup) aktivierbar.
- Schriftgrößen anpassbar über F3/F4 (größer/kleiner).

## 6. Fallback-Terminal
Sollte der Launcher fehlschlagen, wechselt das System in einen TTY mit Willkommensbanner:
```
CopyOS Sicherungsumgebung
Verfügbare Befehle: zeig, zu, laufwerke, sicherung-start
Tippen Sie `sicherung-start`, um die geführte Sicherung erneut zu starten.
```

## 7. Internationalisierung
- Texte in YAML (`/etc/copyos/flows/de.yaml`, `en.yaml`).
- Launcher lädt je nach Tastenkombination (F6 → Sprache wechseln).

## 8. Wartungsmodus
- Admin-Tastenkürzel (CTRL+ALT+A) öffnet Passwortabfrage.
- Nach Authentifizierung Zugriff auf erweiterte Tools (SMART-Check, Netzwerkmounts).
