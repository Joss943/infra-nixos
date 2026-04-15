{
  description = "Infra NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nix-admin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nix-admin/configuration.nix
        ];
      };
    };
  };
}