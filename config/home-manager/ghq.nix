{ pkgs, ... }:

{
  home.packages = [ pkgs.ghq ];

  programs.git.extraConfig = {
    ghq = {
      root = "~/src";
    };
  };

  home.file."src/.stignore" = {
    force = true;
    text = ''
      .direnv
      node_modules
      **/target/debug
    '';
  };
}
