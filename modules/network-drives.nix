{ config, pkgs, lib, ... }:

{
  ##################################################
  # GVFS / GNOME Keyring
  ##################################################

  services.gvfs.enable = true;

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  services.gnome.core-apps.enable = true;

  ##################################################
  # Packages
  ##################################################

  environment.systemPackages = with pkgs; [
    cifs-utils
    samba4Full
    keyutils

    gvfs
    nautilus
    gnome-online-accounts
  ];

  ##################################################
  # Script système de montage SMB
  ##################################################

  environment.etc."mount-drives.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Attente chargement session GNOME
      sleep 20

      ##################################################
      # RECTORAT/P/130
      ##################################################

      if id -nG | grep -qw "gl_rect_dsi_r"; then
        nautilus smb://bureautique.in.ac-versailles.fr/RECTORAT/P/130
      fi

      ##################################################
      # RECTORAT/s
      ##################################################

      if id -nG | grep -qw "gl_rect_specifiques_r"; then
        nautilus smb://bureautique.in.ac-versailles.fr/RECTORAT/s
      fi

      ##################################################
      # RACA/R
      ##################################################

      if id -nG | grep -qw "gg_raca_lecteur_r"; then
        nautilus smb://ad-idf.in.region-academique-idf.fr/RACA/R
      fi
    '';

    mode = "0755";
  };

  ##################################################
  # Autostart GNOME global
  ##################################################

  environment.etc."xdg/autostart/mount-drives.desktop".text = ''
    [Desktop Entry]
    Name=Mount Drives
    Exec=/etc/mount-drives.sh
    Terminal=false
    Type=Application
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
    X-GNOME-Autostart-Delay=20
  '';
}