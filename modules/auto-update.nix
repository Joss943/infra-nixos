{ config, pkgs, ... }:

{
  systemd.services.auto-update-config = {
    description = "Auto update NixOS config from GitHub";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    script = '
      cd /tmp
      rm -rf infra-nixos
      git clone https://github.com/Joss943/infra-nixos.git
      cp -r infra-nixos/modules/* /etc/nixos/modules/
      cp -r infra-nixos/hosts/* /etc/nixos/hosts/
      nixos-rebuild switch --flake /etc/nixos#nix-auto
    ';
  };
}