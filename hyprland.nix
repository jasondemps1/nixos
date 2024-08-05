{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    wofi
    dunst
    pavucontrol
    hyprpaper
    hypridle
    hyprcursor
    nwg-displays
  ];

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  #environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  home.sessionVariables = {
    GBM_BACKEND="nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME= "nvidia";
    LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      "$mod" = "SUPER";

      env = [
        "NIXOS_OZONE_WL,1"
        "GDK_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORM,wayland"
        "MOZ_WEBRENDER,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      windowrule = 
        [
        ];

      bind = 
        [
          "$mod, RETURN, exec, foot"
          "$mod, M, exit"

          "$mod, Q, killactive"

          "$mod, r, exec, wofi --show run"
          "$mod, w, exec, wofi --show window"

          # Move focus with mainMod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod,Space,togglefloating"
          "$mod,S,pseudo"


          # Switch workspaces with mainMod + [0-9]
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ];

        bindm = [
          # Move floaters with mouse
          "$mod,mouse:272,movewindow"
          "$mod,mouse:273,resizewindow"
        ];

      monitor =
        [
          "HDMI-A-1, preferred, -1920x0, 1"
          "DP-3, preferred, 0x0, 1"
          "Unknown-1, preferred, 0x1080, 1"
        ];

      dwindle = {
        # keep floating dimentions while tiling
        pseudotile = true;
        preserve_split = true;
      };

      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      cursor = {
        no_hardware_cursors = true;
        #allow_dumb_copy = true;
      };

      exec = [
        "pkill waybar & sleep 0.5 && waybar"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgba(88888888)";
        "col.inactive_border" = "rgba(00000088)";
  
        allow_tearing = false;
        resize_on_border = true;
      };
  
      decoration = {
        rounding = 16;
        blur = {
          enabled = true;
          brightness = 1.0;
          contrast = 1.0;
          noise = 0.01;
  
          vibrancy = 0.2;
          vibrancy_darkness = 0.5;
  
          passes = 4;
          size = 7;
  
          popups = true;
          popups_ignorealpha = 0.2;
        };
  
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 15";
        shadow_range = 100;
        shadow_render_power = 2;
        shadow_scale = 0.97;
        "col.shadow" = "rgba(00000055)";
      };
  
      animations = {
        enabled = true;
        animation = [
          "border, 1, 2, default"
          "fade, 1, 4, default"
          "windows, 1, 3, default, popin 80%"
          "workspaces, 1, 2, default, slide"
        ];
      };
    };
  };
}
