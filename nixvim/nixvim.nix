{
  imports = [
    ./plugins/plugins.nix
  ];

  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    colorschemes.tokyonight.enable = true;
  };
}
