# CopyOS Architektur- und Buildkonzept

Dieses Dokument beschreibt, wie ein minimalistisches CopyOS-Abbild erstellt wird, das auf älterer x86-Hardware läuft und sich wie gefordert ausschließlich auf das Kopieren von Ordnern konzentriert.

## 1. Zielplattform und Kompatibilität
- **Primärziel:** 32-Bit- und 64-Bit-x86-Systeme mit Legacy-BIOS (vergleichbar zu den Maschinen, auf denen Knoppix läuft).
- **Sekundärziel:** Moderne x86- und ARM-Systeme über zusätzliche Build-Profile.
- **Hinweis zu „allen Geräten“:** Eine bitgenaue Unterstützung sämtlicher exotischer Plattformen (z. B. Quantencomputer, historische Nicht-x86-Architekturen) ist physikalisch nicht realistisch. Stattdessen liefern wir ein generisches USB-Abbild, das dank angepasstem Kernel und modularem Init-System auf sehr breiter Legacy-Hardware einsatzfähig ist.

## 2. Toolchain
Wir nutzen **Buildroot** als Basis, weil es
- kleine, reproduzierbare Root-Dateisysteme erzeugt,
- BusyBox integriert (ermöglicht Custom-Kommandos),
- U-Boot/GRUB-konforme Images für USB-Sticks erstellen kann.

### Voraussetzungen
- Aktuelle Linux-Distribution (Ubuntu, Debian oder Fedora) als Buildhost.
- Pakete: `build-essential`, `git`, `wget`, `cpio`, `unzip`, `python3`, `libncurses5-dev`, `rsync` u. a.

```bash
sudo apt-get install build-essential git wget cpio unzip python3 libncurses5-dev rsync bc
```

## 3. Buildroot-Konfiguration
1. Repository klonen:
   ```bash
   git clone https://github.com/buildroot/buildroot.git
   cd buildroot
   git checkout 2024.02.1
   ```
2. Neues Defconfig erzeugen (`configs/copyos_defconfig`), das auf `x86_64` basiert, aber `BR2_x86_32=y` als Option für Legacy-CPU aktiviert.
3. Pakete aktivieren:
   - `busybox` (Standard, später mit Custom-Aliases),
   - `dialog` oder `whiptail` für TUI,
   - `python3` (minimal) für zukünftige Erweiterungen,
   - `rsync` und `coreutils` (für robustes Kopieren),
   - `parted`, `lsblk`, `ntfs-3g`, `dosfstools` zur Datenträger-Erkennung.
4. Grafikstack minimal halten (Framebuffer für Splashscreen, ggf. Plymouth-Light oder `fbsplash`), kein schweres Desktop.
5. Init-System: `busybox init` mit eigener `/etc/inittab`.

## 4. Dateisystemstruktur
```
/
├── boot/              # Kernel, Initrd, Splash
├── etc/
│   ├── inittab        # Startet CopyOS Launcher
│   └── copyos/
│       ├── branding/  # Logos, Farben, Texte
│       ├── flows/     # YAML/JSON-Beschreibung der Schritt-für-Schritt-Anleitung
│       └── commands/  # BusyBox-Aliases bzw. Wrapper
├── usr/
│   └── local/
│       ├── bin/
│       │   ├── copyos-launcher
│       │   ├── zeig
│       │   ├── zu
│       │   ├── laufwerke
│       │   └── sicherung-start
│       └── share/copyos/
│           └── ui/
└── var/log/copyos/
```

## 5. Launcher-Workflow
1. **Splashscreen** (Bootloader → Framebuffer): Anzeige von `docs/assets/splashscreen.png` (Download aus dem angegebenen Link).
2. **Hardware-Check:** Skript `copyos-hwcheck` sammelt Informationen über verfügbare Laufwerke (`lsblk`, `blkid`).
3. **UI (Dialog/TUI):** `copyos-launcher` führt Nutzer:innen durch drei Schritte:
   - Quelle wählen (Liste der Laufwerke/Ordner, wahlweise mit automatischer Suche nach bekannten Pfaden).
   - Ziel wählen (standardmäßig der eingesteckte USB-Stick, Formatierung optional).
   - Zusammenfassung + Bestätigung (ENTER startet Sicherung).
4. **Kopiervorgang:** `rsync` mit Optionen `-aHAX --info=progress2` für robusten Transfer, Logging nach `/var/log/copyos/`.
5. **Abschluss:** Meldung „Sicherung abgeschlossen“, Option zum Beenden oder Neustart.

## 6. Custom-Kommandos
Implementierung über Wrapper-Skripte in `/usr/local/bin`:
- `zeig` → `ls --group-directories-first --color=auto`.
- `zu <pfad>` → Shell-Wrapper für `cd` (über `busybox ash -c 'cd "$1" && exec ash'`).
- `laufwerke` → Aufruf `lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,LABEL`.
- `sicherung-start` → Direkter Start des Backup-Dialogs.

Die Shell wird mit einer Willkommensnachricht versehen, die diese Kommandos erklärt, falls Nutzer:innen in den Terminal-Modus wechseln.

## 7. Tests & Validierung
- **QEMU:** Automatisierte Tests mit 32-Bit- und 64-Bit-VMs.
- **Alte Hardware:** Checkliste für reale Maschinen (Pentium III, VIA C3, Core2Duo etc.).
- **USB-Kompatibilität:** Boot mit BIOS-only und UEFI-BIOS.

## 8. Release-Artefakte
- `copyos.img` – USB-Abbild (dd-fähig).
- `copyos.iso` – Optionales ISO für optische Medien.
- `SHA256SUMS` & Signaturen.

## 9. Weiteres Vorgehen
- UI-Prototyp (Mockups in `docs/ui-flow.md`).
- Lokalisierung (Deutsch/Englisch).
- Automatisierte Backups & Reporting (Optionale zukünftige Features).
