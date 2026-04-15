{ config, pkgs, ... }:

{
  imports = [
    ../../roles/workstation.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-auto";

  system.stateVersion = "25.11";
}