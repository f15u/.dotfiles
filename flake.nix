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
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    llm-agents.url = "github:numtide/llm-agents.nix";

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # Ioskeley Mono Nerd Font. `latest/download` redirect → newest release,
    # so `nix flake update ioskeley-mono*` bumps the font. Built in home.nix.
    ioskeley-mono = {
      url = "file+https://github.com/ahatem/IoskeleyMono/releases/latest/download/IoskeleyMono-NerdFont.zip";
      flake = false;
    };

    # Term variant: terminal-tuned metrics. Used by kitty.
    ioskeley-mono-term = {
      url = "file+https://github.com/ahatem/IoskeleyMono/releases/latest/download/IoskeleyMono-Term-NerdFont.zip";
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
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

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
          home-manager.overwriteBackup = true;
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
