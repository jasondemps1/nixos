{
  imports = [
    ./keymaps.nix
    ./opts.nix
    ./plugins/plugins.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    colorschemes.tokyonight.enable = true;
  };
}
