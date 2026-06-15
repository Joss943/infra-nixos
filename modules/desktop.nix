{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kscreen
    kdePackages.plasma-nm
    kdePackages.plasma-pa
  ];
}