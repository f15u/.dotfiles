{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.f15u =
      { pkgs, ... }:
      {
        imports = [
            ./module/git/default.nix
        ];

        home = {
          username = "f15u";
          homeDirectory = "/home/f15u";

          stateVersion = "25.05";
        };
      };
  };
}
