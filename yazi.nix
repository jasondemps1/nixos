{ ... }:
{ 
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
