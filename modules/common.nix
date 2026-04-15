{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  console.keyMap = "fr";
  i18n.defaultLocale = "fr_FR.UTF-8";

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "admin";
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}