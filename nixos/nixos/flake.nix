{
  description = "Nixos config flake with Jovian support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Add Jovian NixOS
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    jovian-nixos,
    nvf,
    ...
  } @ inputs: {
    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./modules/config/nvf-configuration.nix];
      }).neovim;

    nixosConfigurations.Artemis = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        # Add Jovian module here
        jovian-nixos.nixosModules.jovian
        inputs.home-manager.nixosModules.default
        inputs.nvf.nixosModules.default
      ];
    };
  };
}
