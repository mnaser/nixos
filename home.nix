{
  lib,
  pkgs,
  nixvim,
  ...
}:

{
  home.stateVersion = "25.05";

  home.username = "mnaser";
  home.homeDirectory = "/home/mnaser";

  imports = [
    nixvim.homeManagerModules.nixvim
  ];

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

  programs.zoxide = {
    enable = true;
  };

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    opts = {
      cursorline = true;
      number = true;
      relativenumber = true;
      signcolumn = "yes";
    };

    extraPlugins = with pkgs.vimPlugins; [
      ansible-vim
    ];

    colorschemes.tokyonight.enable = true;
    colorschemes.tokyonight.settings.style = "night";

    plugins.sleuth.enable = true;
    plugins.nix.enable = true;
    plugins.lastplace.enable = true;
    plugins.direnv.enable = true;

    plugins.gitsigns = {
      enable = true;

      settings = {
        signs = {
          add = {
            text = "▍";
          };
          change = {
            text = "▍";
          };
          delete = {
            text = "▍";
          };
          topdelete = {
            text = "▍";
          };
          changedelete = {
            text = "▍";
          };
        };
      };
    };

    plugins.treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };

    plugins.blink-cmp-copilot.enable = true;
    plugins.blink-cmp-git.enable = true;
    plugins.blink-cmp = {
      enable = true;

      settings.sources = {
        providers = {
          git = {
            name = "git";
            module = "blink-cmp-git";
          };

          copilot = {
            name = "copilot";
            module = "blink-cmp-copilot";
            async = true;
            score_offset = 100;
          };
        };

        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "copilot"
          "git"
        ];
      };
    };

    plugins.conform-nvim = {
      enable = true;

      settings = {
        formatters = {
          ansible-lint = {
            command = lib.getExe pkgs.ansible-lint;
          };
          nixpkgs_fmt = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
          };
        };

        formatters_by_ft = {
          ansible = [ "ansible-lint" ];
          nix = [ "nixpkgs_fmt" ];
        };
      };
    };

    plugins.lspconfig.enable = true;
    plugins.trouble.enable = true;
    plugins.web-devicons.enable = true;

    lsp.servers.ansiblels.enable = true;
    lsp.servers.nixd.enable = true;
    lsp.servers.rust_analyzer.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua require('conform').format()<CR>";
        options.desc = "Format document";
      }
    ];
  };
}
