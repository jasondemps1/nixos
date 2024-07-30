{
  programs.git = {
    enable = true;
    lfs.enable = true;
    #    extraConfig = {
    #      credential = {
    #        credential.helper = "${
    #          pkgs.git.override { withLibsecret = true; }
    #        }/bin/git-credential-libsecret";
    #      };
    #    };
    #config.credential.helper = "libsecret";
    userName  = "jasondemps1";
    userEmail = "jason@offworld.dev";
  };
}
