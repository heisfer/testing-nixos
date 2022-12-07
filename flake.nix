{
  description = "A very basic flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nur.url = "github:nix-community/NUR";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    webcord.url = "github:fufexan/webcord-flake";
  };

  outputs = { self, nixpkgs, hyprland, webcord, hyprpicker, home-manager, ... } @inputs:
    let
      user = "heisfer";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          webcord.overlays.default
        ];
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        thinkchan = lib.nixosSystem {
          inherit pkgs;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs hyprland pkgs; };
              home-manager.users.${user} = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
