#!/usr/bin/env bash
set -euo pipefail

overlay_dir="${BR2_ROOTFS_OVERLAY:-board/copyos/rootfs-overlay}"

# Ensure launcher is executable
chmod +x "${TARGET_DIR}/usr/local/bin/copyos-launcher"
chmod +x "${TARGET_DIR}/usr/local/bin/sicherung-start"
chmod +x "${TARGET_DIR}/usr/local/bin/zeig"
chmod +x "${TARGET_DIR}/usr/local/bin/zu"
chmod +x "${TARGET_DIR}/usr/local/bin/laufwerke"
chmod +x "${TARGET_DIR}/usr/local/bin/hilfe"
chmod +x "${TARGET_DIR}/usr/local/bin/logbuch"

# Copy splash placeholder if provided
if [ -f "${overlay_dir}/usr/share/copyos/splashscreen.png" ]; then
  install -D -m 0644 "${overlay_dir}/usr/share/copyos/splashscreen.png" \
    "${TARGET_DIR}/usr/share/copyos/splashscreen.png"
fi
