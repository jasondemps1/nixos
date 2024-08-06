# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko-config.nix
      #./i3.nix
      #./xfce.nix
    ];

  # Set kernel version
  boot.kernelPackages = pkgs.linuxPackages_zen; #6_10;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "phalanx"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable printing
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    videoDrivers = [ "nvidia" ];

    displayManager.gdm.enable = true;

    windowManager.i3.enable = true;

    #displayManager.lightdm.enable = true;
    #displayManager.lightdm.greeters.slick.enable = true;
    desktopManager.gnome.enable = true;
    # Set xrandr settings for monitor layout
    displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-5 --off --output USB-C-0 --mode 1920x1080 --pos 863x1080 --rotate normal
        '';
  };

services.displayManager = {
  defaultSession = "none+i3";
};


  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    #driSupport = true;
    #driSupport32Bit = true;
  };

  # Proprietary Nvidia Drivers
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.latest;
    # Right now, explicitly get 555.58
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "555.58.02";
      sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
      openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
    };
  };

  # Enable the GNOME Desktop Environment.
  programs.dconf.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.fstrim.enable = true;

  hardware.pulseaudio.enable = false;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable docker
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
	      enable = true;
	      setSocketVariable = true;
      };
    };
   };

  users.extraGroups.docker.members = [ "z3" ];

  # Kubernetes (k3s)
  networking.firewall = {
    allowedTCPPorts = [
      6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
      # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
      # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
    ];

    allowedUDPPorts = [
      # 8472 # k3s, flannel: required if using multi-node for inter-node networking
    ];
  };

  services.k3s.enable = false;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.z3 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" "audio" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
	    git-credential-manager
      firefox
      brave
      tree
      starship
      spotify
      thunderbird
      discord
      godot_4
      tree-sitter
      krita
      aseprite
	    reaper
      lmms
      sbcl
	    vscode
      gimp
      k3s
      k9s
      dbeaver-bin
      unityhub
	    jetbrains-toolbox
      dotnet-sdk_8
      dotnet-runtime_8
      dotnetPackages.Nuget
      csharp-ls
      mono
      msbuild
	    obsidian
      xdg-desktop-portal-hyprland
      obs-studio
      audacity
	    gleam
      erlang_27
      filezilla
	    xivlauncher
	    openrct2
      btop
      grafx2
      SDL
      SDL_mixer
      SDL2
      libGLU
      luajitPackages.luarocks-nix
      helix
      zed-editor
      pyright
      black
      material-icons
    ];
  };

  # Set our GDM settings correctly (or it'll guess at monitor config and be wrong)
  #home-manager.users.gdm = {
  #home.file.".config/monitors.xml".source = "/home/z3/.config/monitors.xml";
  #};

  programs.zsh.enable = true;

  # Turn on Hyprland
  programs.hyprland.enable = true;
  programs.hyprlock.enable = false; #true;
  security.pam.services.hyprlock = {};
  services.hypridle.enable = false; #true;

  # Turn on Sway ( Need Polkit for home-manager Sway config )
  security.polkit.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    vim
    wget
    steam
    go
    emacs

    pulseaudio # for pactl

    # Terminals
    alacritty
	  alacritty-theme
    foot
    kitty
    warp-terminal

    gparted

    gnumake
    gcc
    cmake
    libtool
    nodejs
    (python3.withPackages (ps: with ps; [ requests ]))

    unzip
    p7zip
    openssl
    ranger
    ffmpeg

    blender

	  gnome-tweaks

	  neofetch
	  htop
	  gtop
	  fzf
	  fd
	  ripgrep

    linuxKernel.packages.linux_latest_libre.veikk-linux-driver
    veikk-linux-driver-gui

    pkg-config
    fontconfig

    usbutils
    arandr
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.nix-ld.enable = true;

  programs.steam = {
	  enable = true;
	  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  fonts.packages = with pkgs; [
    ibm-plex
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    fira-code
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
