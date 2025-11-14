{ pkgs, ... }:

{
  home.packages = with pkgs; [
    corefonts
    vista-fonts
  ];
}
