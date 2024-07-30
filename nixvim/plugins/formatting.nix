{
  programs.nixvim.plugins = {
    guess-indent = {
      enable = true;
    };

    mini = {
      enable = true;

      modules = {
        #align = {};
        #basics = {
        #  options.extra_ui = true;
        #};
        #clue = {};
        cursorword = {};
        doc = {};
        extra = {};
        #files = {};
        indentscope = {};
        trailspace = {};
        misc = {};
        #surround = {};
      };
    };
  };
}
