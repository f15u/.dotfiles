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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./home.nix
      ];
    };
  };
}
