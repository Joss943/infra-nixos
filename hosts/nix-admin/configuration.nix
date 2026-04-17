{ config, pkgs, ... }:

{
  imports = [
    ../../roles/workstation.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # À changer machine par machine plus tard
  networking.hostName = "nix-admin";

  # Applications + outils nécessaires pour une future intégration AD
  environment.systemPackages = with pkgs; [
    libreoffice
    nextcloud-client
    thunderbird

    adcli
    oddjob
    samba4Full
    sssd
    krb5
    realmd
  ];

  # Compte local temporaire
  users.users.admin = {
    isNormalUser = true;
    description = "Admin local";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "admin";
  };

  security.sudo.wheelNeedsPassword = true;

  networking.networkmanager.enable = true;

  system.stateVersion = "25.11";
}