#!/usr/bin/env bash
set -euo pipefail

export PATH=/run/current-system/sw/bin:$PATH

echo "🚀 Installation automatique NixOS"

DISK="$(
  /run/current-system/sw/bin/lsblk -dpno NAME,TYPE \
  | /run/current-system/sw/bin/awk '$2=="disk"{print $1}' \
  | /run/current-system/sw/bin/grep -vE '/dev/sr|/dev/loop' \
  | /run/current-system/sw/bin/head -n1
)"

if [ -z "${DISK:-}" ]; then
  echo "No target disk found."
  exit 1
fi

echo "Disque détecté : $DISK"
sleep 3

/run/current-system/sw/bin/parted -s "$DISK" -- mklabel gpt
/run/current-system/sw/bin/parted -s "$DISK" -- mkpart ESP fat32 1MiB 512MiB
/run/current-system/sw/bin/parted -s "$DISK" -- set 1 esp on
/run/current-system/sw/bin/parted -s "$DISK" -- mkpart primary ext4 512MiB 100%

if [[ "$DISK" =~ nvme ]]; then
  P1="${DISK}p1"
  P2="${DISK}p2"
else
  P1="${DISK}1"
  P2="${DISK}2"
fi

/run/current-system/sw/bin/mkfs.vfat -F 32 "$P1"
/run/current-system/sw/bin/mkfs.ext4 -F "$P2"

/run/current-system/sw/bin/mount "$P2" /mnt
/run/current-system/sw/bin/mkdir -p /mnt/boot
/run/current-system/sw/bin/mount "$P1" /mnt/boot

/run/current-system/sw/bin/nixos-install --no-root-passwd --flake github:ribmic21-cloud/infra-nixos#nix-admin

echo "✅ Installation terminée"
/run/current-system/sw/bin/reboot