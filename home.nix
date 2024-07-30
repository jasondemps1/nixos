{ pkgs, nixvim, ... }:
{
	home = {
		username = "z3";
		homeDirectory = "/home/z3";
		stateVersion = "24.05";
		sessionPath = [
			"$HOME/go/bin"
			"$HOME/.dotnet/tools"
		];
		sessionVariables = {

		};
		packages = with pkgs;
		[
			nil
			jq
			yq-go
			tmux
			socat
			zoxide
			kubectl
			inkscape
			yt-dlp
			playerctl
			git-lfs
			glib
			weechat

			wl-clipboard

			bibata-cursors
			tokyo-night-gtk

			gnome-themes-extra

			lua
			rustup

			yt-dlp
		];
	};

	imports = [
		#./bash.nix
		./alacritty.nix
		./foot.nix
		./zsh.nix
		./starship.nix
		./git.nix
		#./neovim.nix
		./hyprland.nix
		./gtk.nix
		nixvim.homeManagerModules.nixvim
		./nixvim/nixvim.nix
		#./gnome-settings.nix
	];

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};
}
