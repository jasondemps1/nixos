#{ config, pkgs, callPackage, ... }:
{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu
    #i3status
    #i3lock
    #i3blocks
    #lxappearance
    navi
    xautolock
    i3lock
    dunst
    pastel # Generator color scheme from wallpaper
    picom
    zellij # Better Tmux
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

    ".config/picom.conf".source = config/picom.conf;
   };

  #services.screen-locker = {
    #enable = true;
    #inactiveInterval = 30; # Minutes
    #lockCmd = "\${pkgs.i3lock}/bin/i3lock -n -c 000000";
    #xautolock = {
      #enable = true;
    #};
  #};
}
