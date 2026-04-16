{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  console.keyMap = "fr";

  # 
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "uas"
    "sd_mod"
    "sr_mod"
  ];

  boot.kernelModules = [
    "uas"
  ];

  boot.supportedFilesystems = [ "ext4" "vfat" "ntfs" ];

  # 
  boot.kernelParams = [
    "usbcore.autosuspend=-1"
    "rootdelay=10"
    "loglevel=7"
  ];

  services.getty.autologinUser = "nixos";

  systemd.services.auto-install = {
    description = "Auto Install NixOS";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };

    script = ''
      sleep 15
      echo "Starting auto install..."
      ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/ribmic21-cloud/infra-nixos/main/install.sh -o /tmp/install.sh
      chmod +x /tmp/install.sh
      ${pkgs.bash}/bin/bash /tmp/install.sh
    '';
  };
}