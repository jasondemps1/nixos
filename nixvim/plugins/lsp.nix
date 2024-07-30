{
  programs.nixvim.plugins = {

    treesitter = {
      enable = true;
      nixvimInjections = true;
      folding = true;
      settings = {
        auto_install = true;
        highlight = {
          additional_vim_regex_highlighting = true;
          custom_captures = { };
          disable = [
          ];
          enable = true;
        };
        indent = {
          enable = true;
        };
      };
    };

    treesitter-context = {
      enable = true;
    };

    treesitter-refactor = {
      enable = true;
      highlightCurrentScope = {
        enable = true;
      };
      navigation = {
        enable = true;
      };
      smartRename = {
        enable = true;
      };
      highlightDefinitions = {
        enable = true;
        # Set to false if you have an `updatetime` of ~100.
        clearOnCursorMove = false;
      };
    };

    hmts.enable = true;

    # lspkind = {
    #   enable = true;
    #
    #   cmp = {
    #     enable = true;
    #     menu = {
    #       nvim_lsp = "[LSP]";
    #       nvim_lua = "[api]";
    #       path = "[path]";
    #       luasnip = "[snip]";
    #       buffer = "[buffer]";
    #       neorg = "[neorg]";
    #       cmp_tabby = "[Tabby]";
    #     };
    #   };
    # };

    lsp = {
      enable = true;
      servers = {
        csharp-ls.enable = true;
        docker-compose-language-service.enable = true;
        dockerls.enable = true;
        gdscript.enable = true;
        gleam.enable = true;
        gopls.enable = true;
        html.enable = true;
        htmx.enable = true;
        jsonls.enable = true;
        lua-ls.enable = true;
        nil-ls.enable = true;
        pyright.enable = true;
      };
    };

    lsp-format = {
      enable = true;
    };
  };
}
