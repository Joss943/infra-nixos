#!/usr/bin/env bash
set -euo pipefail

export PATH=/run/current-system/sw/bin:$PATH

HOSTNAME="nix-auto"
REPO_URL="https://github.com/ribmic21-cloud/infra-nixos.git"

echo "🚀 Installation NixOS avec LUKS"

DISK="$(
  lsblk -dpno NAME,TYPE \
  | awk '$2=="disk"{print $1}' \
  | grep -vE '/dev/sr|/dev/loop' \
  | head -n1
)"

if [ -z "${DISK:-}" ]; then
  echo "Aucun disque détecté."
  exit 1
fi

echo "Disque cible : $DISK"
sleep 3

##################################################
# Partitionnement
##################################################

parted -s "$DISK" -- mklabel gpt

parted -s "$DISK" -- mkpart ESP fat32 1MiB 512MiB
parted -s "$DISK" -- set 1 esp on

parted -s "$DISK" -- mkpart primary 512MiB 100%

EFI_PART="${DISK}1"
CRYPT_PART="${DISK}2"

##################################################
# Format EFI
##################################################

mkfs.fat -F32 "$EFI_PART"

##################################################
# LUKS
##################################################

cryptsetup luksFormat "$CRYPT_PART"

cryptsetup open "$CRYPT_PART" cryptroot

##################################################
# Filesystem
##################################################

mkfs.ext4 /dev/mapper/cryptroot

##################################################
# Montage
##################################################

mount /dev/mapper/cryptroot /mnt

mkdir -p /mnt/boot
mount "$EFI_PART" /mnt/boot

##################################################
# Configuration NixOS
##################################################

nixos-generate-config --root /mnt

##################################################
# Hostname
##################################################

sed -i "s/networking.hostName = .*/networking.hostName = \"$HOSTNAME\";/" \
  /mnt/etc/nixos/configuration.nix

##################################################
# Git
##################################################

nix-shell -p git --run "
  git clone $REPO_URL /mnt/etc/nixos/infra-nixos
"

##################################################
# Installation
##################################################

nixos-install --no-root-password

echo "✅ Installation terminée"