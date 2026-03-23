#.nixfiles/flake.nix
{
description = "Avari Flake BTW";

inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
      home-manager.url = "github:nix-community/home-manager/release-25.11";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

     # Stylix
      stylix.url = "github:nix-community/stylix/release-25.11";

      # Noctalia-Shell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.noctalia-qs.follows = "noctalia-qs";
      };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

  };


  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }@ inputs:
  let
    systems = [
      #"aarch64-linux"
      #"i686-linux"
      "x86_64-linux"
      #"aarch64-darwin"
      #"x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

  in {
      # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;



    nixosConfigurations = {
      avari = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
        stylix.nixosModules.stylix
        ./nixos/configuration.nix
        ./modules/nixos    # ← Imports all modules through default.nix
        ];
      };
    };

    homeConfigurations = {
        "avari" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          stylix.homeModules.stylix
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
