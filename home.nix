{ config, pkgs, ... }: 
{
	home = {
		username = "z3";
		homeDirectory = "/home/z3";
		stateVersion = "24.05";

		packages = with pkgs; [
		    neofetch
		    htop
		];
  	};

	imports = [
		#./bash.nix
		./zsh.nix
		./starship.nix
		./git.nix
	];

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		plugins = with pkgs.vimPlugins; [
			nerdtree
		];
	};
}
