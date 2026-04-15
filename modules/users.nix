{ config, pkgs, ... }:

{
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}