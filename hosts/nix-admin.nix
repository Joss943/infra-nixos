{ config, pkgs, ... }:

{
  imports = [
    ../modules/common.nix
    ../hardware/nix-admin-hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-admin";

  system.stateVersion = "25.11";
}