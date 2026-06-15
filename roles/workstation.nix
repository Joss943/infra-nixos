{ config, pkgs, ... }:

{
  imports = [
    ../modules/common.nix
    ../modules/users.nix
    ../modules/desktop.nix
    ../modules/auto-update.nix
  ];
}