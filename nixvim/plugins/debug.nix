{
  programs.nixvim.plugins = {
    dap = {
      enable = true;
      extensions = {
        dap-ui = {
          enable = true;
        };
        dap-go = {
          enable = true;
        };
        dap-python = {
          enable = true;
        };
      };
    };
  };
}
