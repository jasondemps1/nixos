{ config, pkgs, lib, ... }:
{
  services.xserver = {
    desktopManager.xfce4 = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
    windowManager.i3.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xfce4.xfwm4-themes
    xfce4.thunar
  ];
}
