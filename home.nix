{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.username = "mnaser";
  home.homeDirectory = "/home/mnaser";

  home.packages = with pkgs; [
    ghq
    git-review
  ];

  home.shellAliases = {
    tailscale = "tailscale.exe";
  };

  programs.home-manager = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
  };

  programs.bat = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.git = rec {
    enable = true;

    userName = "Mohammed Naser";
    userEmail = "mnaser@vexxhost.com";

    hooks = {
      "prepare-commit-msg" = pkgs.writeShellScript "signOffCheck.sh" ''
        git interpret-trailers --if-exists doNothing --trailer \
          "Signed-off-by: ${userName} <${userEmail}>" \
          --in-place "$1"
      '';
    };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
      };

      ghq = {
        root = "/home/mnaser/src";
      };
    };
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
