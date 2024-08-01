#{ config, pkgs, callPackage, ... }:
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dmenu
    i3status
    i3lock
    #i3blocks
    lxappearance
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };
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
