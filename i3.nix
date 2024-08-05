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
    picom
    xbindkeys
    scrot
    polybar
    rofi
    xsel
    feh
    arandr
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = lib.mkForce null; # ignore all home-manager's default i3 config
    extraConfig = builtins.readFile config/i3/i3-config;
    #config = {
    #  assigns = {
    #    "5: steam" = [{class = "^Steam"; }];
    #  };
    #  terminal = "alacritty";
    #  modifier = "Mod4";
    #  gaps = {
    #    inner = 10;
    #    outer = 5;
    #  };
    #  floating = {
    #    criteria = [
    #      {
    #        class = "Pavucontrol";
    #      }
    #    ];
    #  };
    #};
  };

  xdg.configFile = {
    "i3/scripts" = {
      source = config/i3/scripts;
      # Copy scripts directory recursively
      recursive = true;
      executable = true; # Make them executable
    };
  };

  home.file = {
    ".screenlayout/monitor.sh".source = ../config/desktop-randr.sh;
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