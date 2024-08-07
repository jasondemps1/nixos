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
			#zoxide
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

			fzf
			tldr
			ast-grep
			# Some language servers and other stuff for editing, should move to own file
			bash-language-server
			yaml-language-server
			omnisharp-roslyn
			docker-compose-language-service
			dockerfile-language-server-nodejs
			markdown-oxide
			nixpkgs-fmt
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
    #./xfce.nix
    ./i3.nix
		#./gnome-settings.nix
		./yazi.nix
		./kitty.nix
	];

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	# zoxide is a smarter cd command, inspired by z and autojump.
  # It remembers which directories you use most frequently,
  # so you can "jump" to them in just a few keystrokes.
  # zoxide works on all major shells.
  #
  #   z foo              # cd into highest ranked directory matching foo
  #   z foo bar          # cd into highest ranked directory matching foo and bar
  #   z foo /            # cd into a subdirectory starting with foo
  #
  #   z ~/foo            # z also works like a regular cd command
  #   z foo/             # cd into relative path
  #   z ..               # cd one level up
  #   z -                # cd into previous directory
  #
  #   zi foo             # cd with interactive selection (using fzf)
  #
  #   z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
}
