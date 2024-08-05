{ config, pkgs, lib, ... }:
{
  services.xserver = {
    desktopManager.xfce = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    xfce.xfwm4-themes
    xfce.thunar
  ];
}
