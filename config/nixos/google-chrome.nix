{ lib, pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ epiphany ];
  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  programs.chromium.enable = true;

  # NOTE(mnaser): Several AI tools depend on Google Chrome being located
  #               at `/opt/google/chrome/chrome`.
  system.activationScripts.chrome-alias = ''
    mkdir -p /opt/google/chrome
    ln -sf ${lib.getExe pkgs.google-chrome} /opt/google/chrome/chrome
  '';
}
