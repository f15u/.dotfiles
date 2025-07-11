# https://www.reddit.com/r/NixOS/comments/1539s44/using_flakes_for_configurationnix/
# https://github.com/novoid/nixos-config
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      ignoreSpace = true;
      ignoreAllDups = true;
      saveNoDups = true;
      expireDuplicatesFirst = true;
    };

    sessionVariables = {
      COLORTERM = "truecolor";
      TERM = "xterm-256color";
    };

    oh-my-zsh = {
      enable = true;
      theme = "refined";
      plugins = [
        "git"
        "docker"
        "docker-compose"
      ];
    };
  };
}
