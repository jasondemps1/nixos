{ pkgs, ... }:
{ 
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "foot"; #"kitty"; 
      startup = [
        # Launch Firefox on start
        #{command = "firefox";}
      ];
    };
  };
}
