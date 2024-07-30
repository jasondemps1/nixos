{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nixvim, disko, home-manager, ... }: 
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.phalanx = nixpkgs.lib.nixosSystem {
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
	inherit nixvim;
      };
    };
  };
}
