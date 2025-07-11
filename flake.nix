{
  description = "NixOS system configuration";

  inputs = {
    # Specify the nixpkgs channel you want to use
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Optional: home-manager if you want to manage user configurations
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nix-vscode-extensions,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.f15u = import ./home.nix;
        }
      ];
    };
  };
}
