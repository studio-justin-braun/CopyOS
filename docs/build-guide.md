# Build-Anleitung für CopyOS

Diese Anleitung führt durch den kompletten Prozess vom Aufsetzen des Buildroot-Projekts bis zum Erstellen eines USB-Abbilds.

## 1. Vorbereitung des Build-Hosts
1. Ubuntu/Debian installieren.
2. Pakete installieren:
   ```bash
   sudo apt-get update
   sudo apt-get install -y build-essential git wget cpio unzip python3 libncurses5-dev rsync bc
   ```
3. Optional: Für grafische Mockups `inkscape` und `gimp` installieren.

## 2. Buildroot einrichten
```bash
git clone https://github.com/buildroot/buildroot.git
cd buildroot
git checkout 2024.02.1
```

## 3. CopyOS-Defconfig hinzufügen
1. Datei `configs/copyos_defconfig` erstellen (siehe Auszug unten).
2. Wichtige Optionen:
   ```make
   BR2_x86_64=y
   BR2_x86_32=y
   BR2_TOOLCHAIN_BUILDROOT_GLIBC=y
   BR2_LINUX_KERNEL=y
   BR2_LINUX_KERNEL_CUSTOM_VERSION=y
   BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.21"
   BR2_PACKAGE_BUSYBOX_CONFIG="board/copyos/busybox.config"
   BR2_ROOTFS_OVERLAY="board/copyos/rootfs-overlay"
   BR2_ROOTFS_POST_BUILD_SCRIPT="board/copyos/post-build.sh"
   BR2_TARGET_ROOTFS_EXT2=y
   BR2_TARGET_ROOTFS_EXT2_4=y
   BR2_TARGET_ROOTFS_SQUASHFS=y
   BR2_TARGET_ROOTFS_TAR=y
   BR2_PACKAGE_RSYNC=y
   BR2_PACKAGE_DIALOG=y
   BR2_PACKAGE_PLYMOUTH=y
   BR2_PACKAGE_ESPEAKUP=y
   ```
3. Overlay-Verzeichnis `board/copyos/` anlegen (enthält Branding, Skripte, Splashscreen).

## 4. Branding integrieren
- `board/copyos/rootfs-overlay/etc/copyos/branding/colors.json`
- `board/copyos/rootfs-overlay/usr/local/share/copyos/ui/`
- Splashscreen in `board/copyos/rootfs-overlay/usr/share/plymouth/themes/copyos/splash.png` (verwende Datei aus `docs/assets`).
- Plymouth-Theme `copyos.plymouth` erstellen, das Logo und Farben nutzt.

## 5. Launcher bereitstellen
- Skript `copyos-launcher` in `board/copyos/rootfs-overlay/usr/local/bin/`.
- Abhängigkeiten: `dialog`, `rsync`, `jq` (für JSON-Parsing der Flow-Dateien).
- Service-Eintrag in `/etc/inittab`: `::respawn:/usr/local/bin/copyos-launcher`.

## 6. Custom-Kommandos hinzufügen
- Shell-Skripte in `board/copyos/rootfs-overlay/usr/local/bin`.
- `chmod +x` sicherstellen.
- Begrüßung via `/etc/profile.d`.

## 7. Build starten
```bash
make copyos_defconfig
make
```
> Hinweis: Der Build kann auf älterer Hardware mehrere Stunden dauern.

## 8. Artefakte
- Ausgabe im Verzeichnis `output/images/`.
- `copyos.ext4` → Basis-Rootfs.
- `bzImage` → Kernel.
- `copyos.img` → USB-Image (ggf. via `support/scripts/genimage.sh`).

## 9. Image auf USB-Stick schreiben
```bash
sudo dd if=output/images/copyos.img of=/dev/sdX bs=4M status=progress && sync
```
> `/dev/sdX` durch das Zielgerät ersetzen.

## 10. Tests
- Boot in QEMU:
  ```bash
  qemu-system-i386 -m 512 -hda output/images/copyos.img
  ```
- Optional: `qemu-system-x86_64` für 64-Bit.

## 11. Wartung
- `make menuconfig` für schnelle Anpassungen.
- Versionsupdates: `git pull` im Buildroot-Verzeichnis, `make clean all`.
- Dokumentation im Repo aktualisieren, wenn neue Features hinzukommen.
