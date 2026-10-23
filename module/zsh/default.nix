{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # pnpm package ships _pnpm completion; unregister it (spawns node per TAB, no file fallback)
    initContent = lib.mkAfter ''
      compdef -d pnpm pn

      # herdr types resume commands into the shell; keep them out of history
      zshaddhistory() {
        [[ $HERDR_ENV == 1 && $1 == (claude|opencode)\ (--resume|--session)\ * ]] && return 1
        return 0
      }
    '';

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
