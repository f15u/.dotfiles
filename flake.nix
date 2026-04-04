{
  nixConfig = {
    extra-substituters = [
      "https://install.determinate.systems"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2511";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    llm-agents.url = "github:numtide/llm-agents.nix";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2511";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    ai-skills = {
      url = "github:f15u/ai-skills";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    nix-vscode-extensions,
    llm-agents,
    determinate,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};

      # https://www.chrisportela.com/posts/home-manager-flake/
      modules = [
        ./configuration.nix
        determinate.nixosModules.default
        nur.modules.nixos.default
        {
          nixpkgs.hostPlatform = "x86_64-linux";
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bkp";
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };

          home-manager.users.f15u = import ./home.nix;
        }
      ];
    };
  };
}
