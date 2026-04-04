{pkgs, ...}: {
  imports = [
    ./module/git/default.nix
    ./module/zsh/default.nix
    ./module/direnv/default.nix
    ./module/vscodium/default.nix
    ./module/librewolf/default.nix
    ./module/hyprland/user.nix
  ];

  home = {
    username = "f15u";
    homeDirectory = "/home/f15u";

    packages = with pkgs; [
      claude-code
      mailspring
      slack
      spotify
      vesktop

      gnumake

      nil
      alejandra

      kitty

      proton-pass
    ];

    stateVersion = "25.05";
  };
}
