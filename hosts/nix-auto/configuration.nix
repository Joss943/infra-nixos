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

  # Prépare Kerberos sans mettre ton vrai domaine dans Git
  security.krb5.enable = true;

  # Création auto du home au premier login
  security.pam = {
    makeHomeDir.umask = "077";
    services.login.makeHomeDir = true;
    services.sshd.makeHomeDir = true;
  };

  # Recommandé avec SSSD
  services.nscd = {
    enable = true;
    config = ''
      server-user nscd
      enable-cache hosts yes
      positive-time-to-live hosts 0
      negative-time-to-live hosts 0
      shared hosts yes
      enable-cache passwd no
      enable-cache group no
      enable-cache netgroup no
      enable-cache services no
    '';
  };

  # Active SSSD, mais sans config de domaine stockée dans le repo public
  services.sssd.enable = true;

  system.stateVersion = "25.11";
}