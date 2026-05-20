#!/usr/bin/env bash
set -euo pipefail

export PATH=/run/current-system/sw/bin:$PATH

HOSTNAME="nix-auto"
REPO_URL="https://github.com/ribmic21-cloud/infra-nixos.git"

echo "🚀 Installation NixOS avec LUKS"

##################################################
# Détection disque
##################################################

DISK="$(
  lsblk -dpno NAME,TYPE,RM \
  | awk '$2=="disk" && $3=="0" {print $1}' \
  | head -n1
)"

if [ -z "${DISK:-}" ]; then
  echo "❌ Aucun disque détecté."
  exit 1
fi

echo "✅ Disque cible : $DISK"
sleep 3

##################################################
# Nettoyage disque
##################################################

swapoff -a || true

umount -R /mnt 2>/dev/null || true

wipefs -af "$DISK"

sgdisk --zap-all "$DISK"

partprobe "$DISK"

sleep 2

##################################################
# Partitionnement
##################################################

parted -s "$DISK" -- mklabel gpt

parted -s "$DISK" -- mkpart ESP fat32 1MiB 512MiB
parted -s "$DISK" -- set 1 esp on

parted -s "$DISK" -- mkpart primary 512MiB 100%

##################################################
# Gestion NVMe / SATA
##################################################

if [[ "$DISK" =~ nvme ]]; then
  EFI_PART="${DISK}p1"
  CRYPT_PART="${DISK}p2"
else
  EFI_PART="${DISK}1"
  CRYPT_PART="${DISK}2"
fi

##################################################
# Format EFI
##################################################

mkfs.vfat -F 32 "$EFI_PART"

##################################################
# LUKS2
##################################################

echo "🔐 Configuration chiffrement disque"

cryptsetup luksFormat "$CRYPT_PART"

cryptsetup open "$CRYPT_PART" cryptroot

##################################################
# Filesystem root
##################################################

mkfs.ext4 -F /dev/mapper/cryptroot

##################################################
# Montage
##################################################

mount /dev/mapper/cryptroot /mnt

mkdir -p /mnt/boot

mount "$EFI_PART" /mnt/boot

##################################################
# Génération config NixOS
##################################################

nixos-generate-config --root /mnt

##################################################
# Clone repo infra
##################################################

git clone "$REPO_URL" /tmp/infra-nixos

##################################################
# Hardware config
##################################################

mkdir -p "/tmp/infra-nixos/hosts/${HOSTNAME}"

cp /mnt/etc/nixos/hardware-configuration.nix \
  "/tmp/infra-nixos/hosts/${HOSTNAME}/hardware-configuration.nix"

##################################################
# Installation flake
##################################################

nixos-install \
  --no-root-passwd \
  --flake "/tmp/infra-nixos#${HOSTNAME}"

echo ""
echo "✅ Installation terminée"
echo ""
echo "⚠️ Au prochain boot :"
echo "Le mot de passe LUKS sera demandé."
echo ""

reboot