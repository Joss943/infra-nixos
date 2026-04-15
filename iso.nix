{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
  ];

  # Auto login root
  services.getty.autologinUser = "root";

  # Lancer ton script au boot
  systemd.services.auto-install = {
    description = "Auto Install NixOS";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/ribmic21-cloud/infra-nixos/main/install.sh | ${pkgs.bash}/bin/bash
      '';
    };
  };
}