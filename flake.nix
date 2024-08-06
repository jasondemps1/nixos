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

    nix-alien-input = {
      url = "github:thiagokokada/nix-alien";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix.url = "github:e-tho/ucodenix";
  };
  outputs = inputs@{ self, nixpkgs, nixvim, disko, home-manager, nix-alien-input, ... }: 
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.phalanx = nixpkgs.lib.nixosSystem rec {
        inherit system;
        specialArgs = { inherit self system; };
        modules = [
          ./configuration.nix
          disko.nixosModules.disko
          ({ self, system, ... }: {
            environment.systemPackages = with nix-alien-input.packages.${system}; [
              nix-alien
            ];
            # Optional, needed for `nix-alien-ld`
            programs.nix-ld.enable = true;
          })
        ];
      };

      homeConfigurations.z3 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          #({ self, system, ... }: {
          #  home.packages = with self.inputs.nix-alien.packages.${system}; [
          #    nix-alien
          #  ];
          #})
        ];
        extraSpecialArgs = {
          inherit self system nixvim;
        };
      };

    # homeConfigurations.nix-alien-home = home-manager.lib.homeManagerConfiguration rec {
    #       inherit pkgs;
    #       extraSpecialArgs = { inherit self system; };
    #       modules = [
    #         ({ self, system, ... }: {
    #           home.packages = with self.inputs.nix-alien.packages.${system}; [
    #             nix-alien
    #           ];
    #         })
    #       ];
    #   };
    };
}
