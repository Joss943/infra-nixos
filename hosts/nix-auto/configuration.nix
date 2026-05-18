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
    # Applications
    libreoffice
    nextcloud-client
    thunderbird
    firefox

    # Utilitaires
    p7zip
    openconnect

    # Impression / PaperCut
    cups
    system-config-printer
    jre

    # Active Directory
    adcli
    oddjob
    samba4Full
    sssd
    krb5
    realmd
  ];

  ########################################
  # Impression
  ########################################

  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  ########################################
  # Kerberos / AD
  ########################################

  security.krb5.enable = true;

  security.pam = {
    makeHomeDir.umask = "077";

    services.login.makeHomeDir = true;
    services.sshd.makeHomeDir = true;
  };

  ########################################
  # NSS Cache
  ########################################

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

  ########################################
  # Version NixOS
  ########################################

  system.stateVersion = "25.11";
}