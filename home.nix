{ pkgs, ... }:
{
	home = {
		username = "z3";
		homeDirectory = "/home/z3";
		stateVersion = "24.05";
	};

	home.packages = with pkgs;
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

		gnome.gnome-themes-extra
	];

	imports = [
		#./bash.nix
		./alacritty.nix
		./foot.nix
		./zsh.nix
		./starship.nix
		./git.nix
		./neovim.nix
		./hyprland.nix
		./gtk.nix
	];
}
