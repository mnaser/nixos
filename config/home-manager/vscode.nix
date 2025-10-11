{ pkgs, ... }:

let
  github-copilot = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "github";
      name = "copilot";
      version = "1.380.1802";
      hash = "sha256-zCXq4g/WN0mh52vnzSY4mUFOEfQKUoOVT0K0xRtkM78=";
    };
  };

  github-copilot-chat = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "github";
      name = "copilot-chat";
      version = "0.32.0";
      hash = "sha256-0B4ZJd2D+GY2CpVB4gyJ3NHiLS1HiG948Ycu7UCysF0=";
    };
  };

in
{
  programs.vscode.enable = true;

  programs.vscode.profiles.default = {
    extensions =
      with pkgs.vscode-extensions;
      [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        mkhl.direnv
      ]
      ++ [
        github-copilot
        github-copilot-chat
      ];

    userSettings = {
      "files.insertFinalNewline" = true;
      "git.alwaysSignOff" = true;
      "git.confirmSync" = false;
      "github.copilot.nextEditSuggestions.enabled" = true;
      "window.autoDetectColorScheme" = true;
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
      "workbench.preferredLightColorTheme" = "Catppuccin Latte";
    };
  };
}
