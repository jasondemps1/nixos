{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
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
  outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: 
    let 
      system = "x86_64-linux";
    in {
    nixosConfigurations.phalanx = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
	./configuration.nix 
	disko.nixosModules.disko
      ];
    };

    homeConfigurations.z3 = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
	./home.nix
      ];
    };
  };
}
