#!/usr/bin/env bash
set -euo pipefail

export PATH=/run/current-system/sw/bin:$PATH

HOSTNAME="nix-auto"
REPO_URL="https://github.com/ribmic21-cloud/infra-nixos.git"

echo "🚀 Installation automatique NixOS"

DISK="$(
  lsblk -dpno NAME,TYPE,RM \
  | awk '$2=="disk" && $3=="0" {print $1}' \
  | head -n1
)"

if [ -z "${DISK:-}" ]; then
  echo "Aucun disque cible trouvé."
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

nixos-generate-config --root /mnt

git clone "$REPO_URL" /tmp/infra-nixos

cp /mnt/etc/nixos/hardware-configuration.nix "/tmp/infra-nixos/hosts/${HOSTNAME}/hardware-configuration.nix"

nixos-install --no-root-passwd --flake "/tmp/infra-nixos#${HOSTNAME}"

echo "✅ Installation terminée"
reboot