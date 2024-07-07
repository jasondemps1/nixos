{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.85;
      window.blur = true;

      font = {
        size = 13.0;
        # draw_bold_text_with_bright_colors = true;
        normal = {
          family = "IBM Plex Mono"; #"JetBrains Mono";
          style = "Bold";
        };
      };

      colors.primary.background = "#1d2021";
    };
  };
}
