{pkgs, ...}: {
  imports = [
    ./module/git/default.nix
    ./module/zsh/default.nix
    ./module/direnv/default.nix
    ./module/vscodium/default.nix
    ./module/librewolf/default.nix
  ];

  home = {
    username = "f15u";
    homeDirectory = "/home/f15u";

    packages = with pkgs; [
      _1password-gui
      slack
      spotify
      vesktop

      gnumake

      nil
      alejandra

      kitty

      fragment-mono
    ];

    stateVersion = "25.05";
  };
}
