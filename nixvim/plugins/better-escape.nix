{
  programs.nixvim.plugins = {
    better-escape = {
      enable = true;
      settings = {
        mapping = {
          i = {
            " " = {
              "<tab>" = {
                __raw = ''
                  function()
                    -- Defer execution to avoid side-effects
                    vim.defer_fn(function()
                        -- set undo point
                        vim.o.ul = vim.o.ul
                        require("luasnip").expand_or_jump()
                    end, 1)
                  end
                '';
              };
            };
          };
        };
        timeout = "vim.o.timeoutlen";
      };
    };
  };
}
