{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = [ "fbdev" ];

  services.xserver.xkb = {
    layout = "fr";
  };

  console.keyMap = "fr";

  i18n.defaultLocale = "fr_FR.UTF-8";
}

