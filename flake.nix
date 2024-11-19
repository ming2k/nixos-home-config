{
  description = "Home Manager configuration of ming";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      
      nixosModules = {
        default = { ... }: {
          imports = [
            ./modules/m2k-programs/zsh.nix
          ];
        };
      };
      homeConfigurations."ming" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          self.nixosModules.default
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
