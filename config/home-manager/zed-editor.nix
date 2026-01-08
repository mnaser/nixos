{ pkgs, ... }:

{
  programs.zed-editor.enable = true;
  programs.zed-editor.extraPackages = with pkgs; [
    go
    gopls
    nil
    nixd
    package-version-server
    ruff
    rust-analyzer
  ];

  programs.zed-editor.extensions = [
    "catppuccin"
    "catppuccin-icons"
    "just"
    "nix"
    "opencode"
    "terraform"
  ];

  programs.zed-editor.userSettings = {
    theme = {
      dark = "Catppuccin Mocha";
      light = "Catppuccin Latte";
    };
    vim_mode = true;
  };
}
