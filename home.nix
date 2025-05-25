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

    colorschemes.tokyonight.enable = true;
    colorschemes.tokyonight.settings.style = "night";

    plugins.sleuth.enable = true;
    plugins.nix.enable = true;
    plugins.lastplace.enable = true;

    plugins.treesitter.enable = true;
    plugins.treesitter.settings = {
      highlight.enable = true;
      incremental_selection.enable = true;
      indent.enable = true;
    };

    plugins.blink-cmp-copilot.enable = true;
    plugins.blink-cmp.enable = true;
    plugins.blink-cmp.settings.sources = {
      providers = {
        copilot = {
          async = true;
          module = "blink-cmp-copilot";
          name = "copilot";
          score_offset = 100;
        };
      };

      default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
        "copilot"
      ];
    };

    plugins.conform-nvim.enable = true;
    plugins.conform-nvim.settings = {
      formatters = {
        nixpkgs_fmt = {
          command = lib.getExe pkgs.nixfmt-rfc-style;
        };
      };

      formatters_by_ft = {
        nix = [ "nixpkgs_fmt" ];
      };
    };

    plugins.lspconfig.enable = true;
    plugins.trouble.enable = true;
    plugins.web-devicons.enable = true;

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
