{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ geary ];

  services.gnome.evolution-data-server.enable = true;

  programs.evolution.enable = true;
  programs.evolution.plugins = with pkgs; [
    evolution-ews
  ];
}
