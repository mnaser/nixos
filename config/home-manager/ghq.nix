{ pkgs, ... }:

{
  home.packages = [ pkgs.ghq ];

  programs.git.settings = {
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
