{
  programs.alacritty = {
    enable = true;
    settings = {
      #import = [
      #  "~/.config/alacritty/themes/themes/tokyo-night.toml"
      #];
      env = {
        TERM = "alacritty-direct";
      };

      window = {
        blur = true;
        opacity = 0.95;
        dynamic_title = true;
      };

      font = {
        size = 13.0;
        # draw_bold_text_with_bright_colors = true;
        normal = {
          family = "IBM Plex Mono"; #"JetBrains Mono";
          style = "Bold";
        };
      };

      colors.primary.background = "#1d2021";
      selection.save_to_clipboard = true;
    };
  };
}
