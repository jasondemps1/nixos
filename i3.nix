#{ config, pkgs, callPackage, ... }:
{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu
    #i3status
    #i3lock
    #i3blocks
    #lxappearance
    xautolock
    i3lock
    dunst
    pastel # Generator color scheme from wallpaper
    #picom
    xbindkeys
    xorg.xev
    xorg.xfontsel
    xorg.xdpyinfo
    flameshot
    scrot
    polybarFull
    polybar-pulseaudio-control
    rofi
    xsel
    feh
    arandr
    alsa-utils
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = lib.mkForce null; # ignore all home-manager's default i3 config
    extraConfig = builtins.readFile config/i3/i3-config;
    #config = rec {
    ##  assigns = {
    ##    "5: steam" = [{class = "^Steam"; }];
    ##  };
    #  modifier = "Mod4";
    #  keybindings = lib.mkOptionDefault {
    #    "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show combi -modes combi -combi-modes 'window,drun,run';
    #  };
    #  startup = [
    #  ];
  };

  #xdg.configFile = {
  #  "i3/scripts" = {
  #    source = config/i3/scripts;
  #    # Copy scripts directory recursively
  #    recursive = true;
  #    executable = true; # Make them executable
  #  };
  #};

  home.file = {
    ".screenlayout/desktop.sh".source = config/desktop-randr.sh;

    ".config/polybar" = {
      source = config/polybar;
      recursive = true;
      executable = true;
    };
  };

  #services.screen-locker = {
    #enable = true;
    #inactiveInterval = 30; # Minutes
    #lockCmd = "\${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #xautolock = {
      #enable = true;
    #};
  #};

  #programs.i3status = {
    #enable = true;
    #enableDefault = false;
    #general = {
      #colors = true;
      #color_good = "#e0e0e0";
      #color_degraded = "#d7ae00";
      #color_bad = "#f69d6a";
      #interval = 1;
    #};
    #modules = {
      #"volume master" = {
        #position = 1;
        #settings = {
          #format = "♪ %volume";
          #format_muted = "♪ muted (%volume)";
          #device = "pulse:1";
        #};
      #};
      #"disk /" = {
        #position = 2;
        #settings = {
          #format = "/ %avail";
        #};
      #};
      #"tztime local" = {
        #position = 3;
        #settings = {
          #format = "%time";
          #format_time = "%a %-d %b %H:%M";
        #};
      #};
    #};
  #};
  #services.xserver = {
  #  windowManager.i3 = {
  #    enable = true;
  #    extraPackages = with pkgs; [
  #      dmenu
  #      i3status
  #      i3lock
  #      i3blocks
  #    ];
  #  };
  #};
}
