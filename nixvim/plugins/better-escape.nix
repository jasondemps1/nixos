{
  programs.nixvim.plugins = {
    better-escape = {
      enable = true;
      settings = {
        timeout = "vim.o.timeoutlen";
      };
    };
  };
}
