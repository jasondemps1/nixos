{
	home = {
		username = "z3";
		homeDirectory = "/home/z3";
		stateVersion = "24.05";
  	};

	imports = [
		#./bash.nix
		./alacritty.nix
		./foot.nix
		./zsh.nix
		./starship.nix
		./git.nix
		./neovim.nix
	];
}
