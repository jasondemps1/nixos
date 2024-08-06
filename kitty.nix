{ ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Moon";

    font = {
      name = "IBM Plex Text";
      size = 13;
    };

    settings = {
      background_opacity = "0.93";
      enable_audio_bell = false;
      tab_bar_edge = "top";
    };
  };
}
