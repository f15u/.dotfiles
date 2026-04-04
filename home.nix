{pkgs, ...}: {
  imports = [
    ./module/git/default.nix
    ./module/zsh/default.nix
    ./module/direnv/default.nix
    ./module/vscodium/default.nix
    ./module/librewolf/default.nix
    ./module/claude/default.nix
    ./module/opencode/default.nix
    ./module/ai-skills/default.nix
  ];

  home = {
    username = "f15u";
    homeDirectory = "/home/f15u";

    packages = with pkgs; [
      slack
      spotify
      vesktop

      gnumake

      nil
      alejandra

      kitty

      nerd-fonts.commit-mono

      gnupg

      proton-pass
    ];

    stateVersion = "25.05";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "x-scheme-handler/discord" = "vesktop.desktop";
    };
  };
}
