#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Installation automatique NixOS"

DISK="$(lsblk -dpno NAME,TYPE | awk '$2=="disk"{print $1}' | grep -vE '/dev/sr|/dev/loop' | head -n1)"

if [ -z "${DISK:-}" ]; then
  echo "No target disk found."
  exit 1
fi

echo "Disque détecté : $DISK"
sleep 3

parted -s "$DISK" -- mklabel gpt
parted -s "$DISK" -- mkpart ESP fat32 1MiB 512MiB
parted -s "$DISK" -- set 1 esp on
parted -s "$DISK" -- mkpart primary ext4 512MiB 100%

if [[ "$DISK" =~ nvme ]]; then
  P1="${DISK}p1"
  P2="${DISK}p2"
else
  P1="${DISK}1"
  P2="${DISK}2"
fi

mkfs.vfat -F 32 "$P1"
mkfs.ext4 -F "$P2"

mount "$P2" /mnt
mkdir -p /mnt/boot
mount "$P1" /mnt/boot

nixos-install --no-root-passwd --flake github:ribmic21-cloud/infra-nixos#nix-admin

echo "✅ Installation terminée"
reboot