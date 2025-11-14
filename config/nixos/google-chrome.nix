{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  programs.chromium.enable = true;
}
