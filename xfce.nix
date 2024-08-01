{ config, pkgs, lib, ... }:
{
  services.xserver = {
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xfce.xfwm4-themes
    xfce.thunar
  ];
}
