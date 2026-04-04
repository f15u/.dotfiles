{pkgs, ...}: {
  programs.git = {
    enable = true;

    signing = {
      key = "CE0B5314D1D1A757";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Federico Biccheddu";
        email = "service+git@f15u.dev";
      };

      init.defaultBranch = "main";
      pull.ff = true;
      pull.rebase = true;
      rebase.autosquash = true;
      help.autoCorrect = "prompt";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry = {
      package = pkgs.pinentry-qt;
    };
  };
}
