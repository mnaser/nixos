{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ epiphany ];
  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  programs.chromium.enable = true;
}
