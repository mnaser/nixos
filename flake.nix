{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
    claude-desktop.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-master,
      home-manager,
      nixvim,
      treefmt-nix,
      claude-desktop,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-master = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };
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
          specialArgs = { inherit pkgs-master; };
          modules = [
            { nixpkgs.overlays = [ (import ./overlays/gitbutler.nix) ]; }
            ./hosts/rig/configuration.nix
            ./modules/services/hardware/openlinkhub.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mnaser = ./hosts/rig/home.nix;

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];

              home-manager.extraSpecialArgs = {
                inherit pkgs-master;
                claude-desktop-pkg = claude-desktop.packages.${system}.claude-desktop-with-fhs;
              };
            }
          ];
        };

        zenbook = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs-master; };
          modules = [
            { nixpkgs.overlays = [ (import ./overlays/gitbutler.nix) ]; }
            ./hosts/zenbook/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mnaser = ./hosts/zenbook/home.nix;

              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];

              home-manager.extraSpecialArgs = {
                inherit pkgs-master;
                claude-desktop-pkg = claude-desktop.packages.${system}.claude-desktop-with-fhs;
              };
            }
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixfmt-rfc-style
        ];
      };
    };
}
