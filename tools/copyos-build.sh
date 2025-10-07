#!/usr/bin/env bash
set -euo pipefail

BR_REPO=${BR_REPO:-"https://github.com/buildroot/buildroot.git"}
BR_TAG=${BR_TAG:-"2024.02.1"}
REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TEMPLATE_ROOT="$REPO_ROOT/templates/buildroot"
BUILDROOT_DIR=${BUILDROOT_DIR:-"$REPO_ROOT/buildroot"}
if [ -z "${JOBS:-}" ]; then
  if command -v nproc >/dev/null 2>&1; then
    JOBS=$(nproc)
  else
    JOBS=1
  fi
fi

required_tools=(git make rsync tar patch)
missing=()
for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    missing+=("$tool")
  fi
done

if [ ${#missing[@]} -ne 0 ]; then
  echo "Fehlende Werkzeuge: ${missing[*]}" >&2
  echo "Bitte installieren Sie die in docs/build-guide.md genannten Pakete." >&2
  exit 1
fi

if [ -d "$BUILDROOT_DIR/.git" ]; then
  echo "Verwende bestehendes Buildroot-Verzeichnis $BUILDROOT_DIR"
  (
    cd "$BUILDROOT_DIR"
    git fetch --tags
    git checkout "$BR_TAG"
  )
else
  if [ -d "$BUILDROOT_DIR" ]; then
    echo "Vorhandenes Verzeichnis $BUILDROOT_DIR ist unvollständig – entferne es."
    rm -rf "$BUILDROOT_DIR"
  fi
  echo "Klone Buildroot $BR_TAG nach $BUILDROOT_DIR ..."
  git clone --branch "$BR_TAG" --depth 1 "$BR_REPO" "$BUILDROOT_DIR"
fi

SPLASH_SRC="$REPO_ROOT/docs/assets/splashscreen.png"
if [ -f "$SPLASH_SRC" ]; then
  install -D -m 0644 "$SPLASH_SRC" \
    "$TEMPLATE_ROOT/board/copyos/rootfs-overlay/usr/share/copyos/splashscreen.png"
fi

echo "Übernehme CopyOS-Konfiguration und Overlays ..."
mkdir -p "$BUILDROOT_DIR/board/copyos"
rsync -a --delete "$TEMPLATE_ROOT/board/copyos/" "$BUILDROOT_DIR/board/copyos/"
mkdir -p "$BUILDROOT_DIR/configs"
rsync -a "$TEMPLATE_ROOT/configs/" "$BUILDROOT_DIR/configs/"

cd "$BUILDROOT_DIR"

echo "Starte Buildroot-Konfiguration (make copyos_defconfig)"
make copyos_defconfig

echo "Starte Build mit $JOBS Jobs"
make -j"$JOBS"

echo "Build abgeschlossen. Artefakte liegen in $BUILDROOT_DIR/output/images"
