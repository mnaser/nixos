{ pkgs, ... }:

let
  atlassian-atlascode = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "Atlassian";
      name = "atlascode";
      version = "4.1.12";
      hash = "sha256-NiRgmE7JIjCcdELJu9X7Ks+tB/g2quQrwGhvhJ1bQQw=";
    };
  };

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
  home.packages = with pkgs; [ monaspace ];

  programs.vscode.enable = true;
  programs.vscode.profiles.default = {
    extensions =
      with pkgs.vscode-extensions;
      [
        atlassian-atlascode
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
        mkhl.direnv
        ms-vscode-remote.remote-ssh
        redhat.vscode-yaml
        rust-lang.rust-analyzer
      ]
      ++ [
        github-copilot
        github-copilot-chat
      ];

    userSettings = {
      "editor.fontFamily" = "'Monaspace Neon', monospace";
      "editor.fontLigatures" =
        "'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09'";
      "editor.inlineSuggest.fontFamily" = "'Monaspace Krypton', monospace";
      "files.insertFinalNewline" = true;
      "git.alwaysSignOff" = true;
      "git.confirmSync" = false;
      "github.copilot.chat.commitMessageGeneration.instructions" = [
        {
          text = "Use conventional commit message format (based on @commitlint/config-conventional).";
        }
        {
          text = "Do not exceed 72 characters for the subject line.";
        }
        {
          text = "Use lowercase letters for the subject line.";
        }
        {
          text = "Do not use the prefix 'feat:' unless the commit introduces a new user facing feature.";
        }
      ];
      "github.copilot.enable" = {
        "*" = true;
      };
      "github.copilot.nextEditSuggestions.enabled" = true;
      "window.autoDetectColorScheme" = true;
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
      "workbench.preferredLightColorTheme" = "Catppuccin Latte";
    };
  };
}
