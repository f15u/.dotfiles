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

    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nur,
    nix-vscode-extensions,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      # https://www.chrisportela.com/posts/home-manager-flake/
      modules = [
        ./configuration.nix
        nur.modules.nixos.default
        {
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bkp";

          home-manager.users.f15u = import ./home.nix;
        }
      ];
    };
  };
}
