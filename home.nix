{ pkgs, nixvim, ... }:
{
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-5 --off --output USB-C-0 --mode 1920x1080 --pos 863x1080 --rotate normal
  '';

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
			inkscape-with-extensions
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
    ./i3.nix
		#./gnome-settings.nix
	];

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};
}
