{
  programs.nixvim.plugins = {
    undotree = {
      enable = true;
      settings = {
        CursorLine = true;
        DiffAutoOpen = true;
        DiffCommand = "diff";
        HelpLine = true;
        HighlightChangedText = true;
        RelativeTimestamp = true;
        TreeNodeShape = "*";
        TreeReturnShape = "\\";
        TreeSplitShape = "/";
        TreeVertShape = "|";
        WindowLayout = 4;
      };
    };
  };
}
