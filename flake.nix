{
  description = "A structured and configureable NixOS system!";

  inputs = {
    master.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";

    nixos-cn = {
      url = "github:nixos-cn/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mozilla-overlay = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };

    # agenix.url = "github:ryantm/agenix";
    # naersk.url = "github:nmattia/naersk";

  };

  outputs = 
    inputs@{ self
    , nixpkgs
    , master
    , home-manager
    , nixos-hardware
    , flake-utils
    , rust-overlay
    , neovim-nightly 
    , emacs-overlay
    , mozilla-overlay
    , nixos-cn
    , ...
  }:

  let 
    system = "x86_64-linux";

    overlays = with self.overlays; [ 
      rust-overlay.overlay
      emacs-overlay.overlay
      neovim-nightly.overlay
      # mozilla-overlay.overlay <-- does not exist???
    ];

    inherit (nixpkgs.lib) nixosSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (flake-utils.lib) eachDefaultSystem eachSystem;
    inherit (builtins) listToAttrs map;

    # Generate default NixOS config
    mkNixosConfig =
      { system ? "x86_64-linux"
      , hardwareModules
      , baseModules ? [
          home-manager.nixosModules.home-manager
          ./modules/nixos
        ]
      , extraModules ? [ ]
      }:

      nixosSystem {
        inherit system;
        modules = baseModules ++ hardwareModules ++ extraModules
          ++ [{ nixpkgs.overlays = overlays; }];
        specialArgs = { inherit inputs; };
      };

      # Generate default Home-Manager conf
      mkHomeConfig =
        { username
        , system ? "x86_64-linux"
        , baseModules ? [ ./modules/home-manager ]
        , extraModules ? [ ]
        }:

        homeManagerConfiguration rec {
          inherit system username;
          homeDirectory = "/home/${username}";
          extraSpecialArgs = { inherit inputs; };
          configuration = {
            imports = baseModules ++ extraModules
              ++ [{ nixpkgs.overlays = overlays; }];
          };
        };

  in {
    nixosConfigurations = {
      thinkpad = mkNixosConfig {
        hardwareModules = [
          ./modules/hardware/thinkpad.nix
          # nixos-hardware.nixosModules.lenovo-thinkpad-e595
        ];
        extraModules = [ ./profiles/ThinkPad-E595.nix ];
      };
      
      probook = mkNixosConfig {
        hardwareModules = [
          ./modules/hardware/ProBook-440G3.nix
          # nixos-hardware.nixosModules.hp-probook-440g3
        ];
        extraModules = [ ./profiles/ProBook-440G3.nix ];
      };

    };

    homeConfigurations = {
      thinkpad = mkHomeConfig {
        username = "sirius";
        extraModules = [ ./profiles/home-manager/ThinkPad-E595.nix ];
      };

      probook = mkHomeConfig {
        username = "orca";
        extraModules = [ ./profiles/home-manager/ProBook-440G3.nix ];
      };

    };
  };

}