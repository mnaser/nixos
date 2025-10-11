{ pkgs, ... }:

{
  home.packages = [ pkgs.ghq ];

  programs.git.extraConfig = {
    ghq = {
      root = "~/src";
    };
  };
}
