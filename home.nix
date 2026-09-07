{pkgs, lib, inputs, ...}: let
  # Unzip a Nerd Font release zip into a font package.
  mkFont = name: src:
    pkgs.runCommand name {} ''
      mkdir -p $out/share/fonts/truetype
      ${pkgs.unzip}/bin/unzip -j ${src} '*.ttf' -d $out/share/fonts/truetype
    '';

  ioskeley-mono = mkFont "ioskeley-mono-nerd-font" inputs.ioskeley-mono;
  ioskeley-mono-term = mkFont "ioskeley-mono-term-nerd-font" inputs.ioskeley-mono-term;
in {
  manual.manpages.enable = false;

  imports = [
    ./module/git/default.nix
    ./module/zsh/default.nix
    ./module/direnv/default.nix
    ./module/vscodium/default.nix
    ./module/librewolf/default.nix
    ./module/claude/default.nix
    ./module/opencode/default.nix
    ./module/polypane/default.nix
    ./module/ai-skills/default.nix
    ./module/cinnamon/monitors.nix
    ./module/kitty/default.nix
    ./module/ghostty/default.nix
    ./module/fastpotify/default.nix
  ];

  home = {
    username = "f15u";
    homeDirectory = "/home/f15u";

    packages = with pkgs;
      [
        slack
        spotify
        discord

        gnumake

        nil
        alejandra
        nixfmt

        nerd-fonts.commit-mono
        ioskeley-mono
        ioskeley-mono-term
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
