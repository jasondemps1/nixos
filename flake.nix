{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, disko, home-manager, ... }: 
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
    nixosConfigurations.phalanx = nixpkgs.lib.nixosSystem {
      specialArgs = {
	pkgs-unstable = import nixpkgs-unstable {
	  inherit system;
	  config.allowUnfree = true;
	};
      };
      inherit system;
      modules = [ 
	./configuration.nix 
	disko.nixosModules.disko
      ];
    };

    homeConfigurations.z3 = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
	./home.nix
      ];
      extraSpecialArgs = {
	inherit pkgs-unstable;
      };
    };
  };
}
