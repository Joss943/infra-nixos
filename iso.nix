{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  services.getty.autologinUser = "nixos";

  systemd.services.auto-install = {
    description = "Auto Install NixOS";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      sleep 10
      ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/ribmic21-cloud/infra-nixos/main/install.sh -o /tmp/install.sh
      ${pkgs.bash}/bin/bash /tmp/install.sh
    '';
  };
}