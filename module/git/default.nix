{
  programs.git = {
    enable = true;
    userName = "Federico Biccheddu";
    userEmail = "service+git@f15u.dev";

    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = true;
      pull.rebase = true;
      rebase.autosquash = true;
      help.autoCorrect = "prompt";
    };

    delta.enable = true;
  };
}
