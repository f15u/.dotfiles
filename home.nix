{
  imports = [
    ./module/git/default.nix
    ./module/zsh/default.nix
    ./module/vscodium/default.nix
  ];

  home = {
    username = "f15u";
    homeDirectory = "/home/f15u";

    stateVersion = "25.05";
  };
}
