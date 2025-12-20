{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    llm-agents-nix.url = "github:numtide/llm-agents.nix";

    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    claude-desktop.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      agenix,
      home-manager,
      nixvim,
      treefmt-nix,
      llm-agents-nix,
      claude-desktop,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};
      llm-agents = llm-agents-nix.packages.${system};

      treefmtEval = treefmt-nix.lib.evalModule nixpkgs.legacyPackages.x86_64-linux {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    in
    {
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;

      nixosConfigurations = {
        rig = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit llm-agents;
          };

          modules = [
            agenix.nixosModules.default
            ./hosts/rig/configuration.nix
            ./modules/services/hardware/openlinkhub.nix
            ./modules/desktop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mnaser = ./hosts/rig/home.nix;

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];

              home-manager.extraSpecialArgs = {
                inherit llm-agents;

                claude-desktop-pkg = claude-desktop.packages.${system}.claude-desktop-with-fhs;
              };
            }
          ];
        };

        zenbook = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            llm-agents = llm-agents.packages.${system};
          };

          modules = [
            agenix.nixosModules.default
            ./hosts/zenbook/configuration.nix
            ./modules/desktop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mnaser = ./hosts/zenbook/home.nix;

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];

              home-manager.extraSpecialArgs = {
                inherit llm-agents;

                claude-desktop-pkg = claude-desktop.packages.${system}.claude-desktop-with-fhs;
              };
            }
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages =
          with pkgs;
          [
            nixfmt-rfc-style
          ]
          ++ [
            agenix.packages.${system}.default
          ];
      };
    };
}
