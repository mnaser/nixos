{ pkgs, ... }:

{
  home.packages = with pkgs; [
    glow # terminal-based markdown viewer
    python3Packages.grip # browser-based with GitHub styling (auto-refreshes)
  ];
}
