{ pkgs, ... }:

{
  programs.evolution.enable = true;
  programs.evolution.plugins = with pkgs; [
    evolution-ews
  ];
}
