{ config, pkgs, ... }:

{
  imports = [
    ../../roles/workstation.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-auto";

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