{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  users.users.admin = {
    isNormalUser = true;
    description = "Admin local";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "admin";
  };

  security.sudo.wheelNeedsPassword = true;

  environment.systemPackages = with pkgs; [
    git
    vim

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

  security.krb5.enable = true;

  security.pam = {
    makeHomeDir.umask = "077";
    services.login.makeHomeDir = true;
    services.sshd.makeHomeDir = true;
  };

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
}