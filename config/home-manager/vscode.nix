{ lib, pkgs, ... }:

let
  anthropic-claude-code = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "anthropic";
      name = "claude-code";
      version = "2.0.37";
      hash = "sha256-wXYdMoJhdH5S8EGdELVFbmwrwO7LHgYiEFqiUscQo4Y=";
    };
  };

  atlassian-atlascode = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "Atlassian";
      name = "atlascode";
      version = "4.1.45";
      hash = "sha256-EjpkjnhzqY5dH4oH6MBhSQ4kqYP2umNjTh0kZI1RSdI=";
    };
  };

  opentofu-vscode-opentofu = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "opentofu";
      name = "vscode-opentofu";
      version = "0.4.2";
      hash = "sha256-27D28MMytOZMLf24cBCR/uJZuBVngGrhoLvrTjv+Xt0=";
    };

    postInstall = ''
      cd "$out/$installPrefix"
      ${lib.getExe pkgs.jq} '.contributes.configuration[1].properties."opentofu.languageServer.path".default = "${pkgs.tofu-ls}/bin/tofu-ls"' package.json | ${lib.getExe' pkgs.moreutils "sponge"} package.json
    '';
  };

in
{
  home.packages = with pkgs; [ monaspace ];

  programs.vscode.enable = true;
  programs.vscode.profiles.default = {
    extensions =
      with pkgs.vscode-extensions;
      [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        github.copilot
        github.copilot-chat
        golang.go
        jnoortheen.nix-ide
        mkhl.direnv
        ms-python.black-formatter
        ms-python.isort
        ms-python.mypy-type-checker
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode-remote.remote-ssh
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        vscodevim.vim
      ]
      ++ [
        anthropic-claude-code
        atlassian-atlascode
        opentofu-vscode-opentofu
      ];

    userSettings = {
      "atlascode.rovodev.enabled" = false;
      "atlascode.bitbucket.enabled" = false;
      "claudeCode.claudeProcessWrapper" = lib.getExe pkgs.claude-code;
      "direnv.restart.automatic" = true;
      "editor.fontFamily" = "'Monaspace Neon', monospace";
      "editor.fontLigatures" =
        "'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09'";
      "editor.fontSize" = 15;
      "editor.inlineSuggest.fontFamily" = "'Monaspace Krypton', monospace";
      "editor.minimap.autohide" = "scroll";
      "extensions.autoUpdate" = false;
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
      "terminal.integrated.fontLigatures.enabled" = true;
      "terminal.integrated.fontSize" = 15;
      "update.mode" = "none";
      "vim.useSystemClipboard" = true;
      "window.autoDetectColorScheme" = true;
      "workbench.iconTheme" = "catppuccin-mocha";
      "workbench.preferredDarkColorTheme" = "Catppuccin Mocha";
      "workbench.preferredLightColorTheme" = "Catppuccin Latte";
      "yaml.schemas" = {
        "file:///home/mnaser/.vscode/extensions/atlassian.atlascode-${atlassian-atlascode.version}/resources/schemas/pipelines-schema.json" =
          "bitbucket-pipelines.yml";
      };
    };
  };
}
