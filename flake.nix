#.nixfiles/flake.nix
#  ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗
#  ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
#  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
#  ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
#  ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
#  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
{
  description = "Avari Flake BTW";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager ---------------------------------------------------------
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix ---------------------------------------------------------------
    stylix.url = "github:nix-community/stylix/release-25.11";

    # Noctalia-Shell -------------------------------------------------------
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # LazyVim --------------------------------------------------------------
    lazyvim ={
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    # Qylock SDDM ----------------------------------------------------------
    qylock = {
      url = "github:LordHerdier/qylock-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ----------------------------------------------------------------------
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    stylix,
    qylock,
    lazyvim,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for nix files, available through 'nix fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Exports -----------------------------------------------------------------------
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # Nix OS-------------------------------------------------------------------------
    nixosConfigurations = {
      avari = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          qylock.nixosModules.default
          ./nixos/configuration.nix
          ./modules/nixos
        ];
      };
    };
    # Home Managere ------------------------------------------------------------------
    homeConfigurations = {
      "avari" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          stylix.homeModules.stylix
          lazyvim.homeManagerModules.default
          ./home-manager/home.nix
        ];
      };
    };
  };
}
