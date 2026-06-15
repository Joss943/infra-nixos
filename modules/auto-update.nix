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
      ExecStart = "/bin/bash -c 'cd /tmp && rm -rf infra-nixos && git clone https://github.com/Joss943/infra-nixos.git && nixos-rebuild switch --flake /tmp/infra-nixos#nix-auto &'";
    };
  };
}