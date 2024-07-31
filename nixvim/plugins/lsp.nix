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
          disable = [ ];
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

    lsp = {
      enable = true;
      #keymaps = {
      #  extra = [
      #    {
      #      #action = {
      #      #  __raw = "require('telescope.builtin').lsp_definitions()";
      #      #};
      #      #key = "fd";
      #      action = "<CMD>vim.lsp.buf.definition<CR>";
      #      key = "<leader>fd";
      #    }
      #  ];
        #lspBuf = {
          #la = "code_action";
          #fR = "references";
          #fd = "definition";
        #};
      #};
      servers = {
        csharp-ls = {
          enable = true;
          #rootDir = lspconfig.util.root_pattern("*.git");
        };
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

    lspkind = {
      enable = true;
    };

    lsp-format = {
      enable = true;
    };

    trouble = {
      enable = true;
      settings = {
        auto_close = true;
      };
    };
  };
}
