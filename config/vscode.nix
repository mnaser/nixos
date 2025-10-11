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
      version = "0.32.2025100703";
      hash = "sha256-U+l8lbX4STVDd6G5WrSIaGvShUxr1XArDX5Zb28uR3A=";
    };
  };

in
{
  programs.vscode.enable = true;

  programs.vscode.profiles.default = {
    extensions =
      with pkgs.vscode-extensions;
      [
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
    };
  };
}
