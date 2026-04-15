systemd.services.auto-install = {
  description = "Auto Install NixOS";

  wantedBy = [ "default.target" ];   # 

  after = [ "network-online.target" ];
  wants = [ "network-online.target" ];

  serviceConfig = {
    Type = "oneshot";
  };

  script = ''
    sleep 15
    echo "Starting auto install..."
    ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/ribmic21-cloud/infra-nixos/main/install.sh -o /tmp/install.sh
    chmod +x /tmp/install.sh
    ${pkgs.bash}/bin/bash /tmp/install.sh
  '';
};