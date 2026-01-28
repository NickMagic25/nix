{
  description = "Personal macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }: {
    darwinConfigurations = {
      # Personal MacBook Pro configuration
      personal-macbook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin"; # Change to "x86_64-darwin" for Intel Macs
        modules = [
          ./hosts/personal-macbook/darwin-configuration.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nmajkic = import ./hosts/personal-macbook/home.nix;
          }
        ];
      };

      # Work Mac configuration
      work-mac = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin"; # Change to "x86_64-darwin" for Intel Macs
        modules = [
          ./hosts/work-mac/darwin-configuration.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nmajkic = import ./hosts/work-mac/home.nix;
          }
        ];
      };
    };
  };
}
