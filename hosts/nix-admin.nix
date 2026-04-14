{ config, pkgs, ... }:

{
  networking.hostName = "nix-admin";

  services.openssh.enable = true;

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  system.stateVersion = "25.11";
}