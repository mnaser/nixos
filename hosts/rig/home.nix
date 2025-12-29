{
  config,
  pkgs,
  claude-desktop-pkg,
  ...
}:

{
  imports = [
    ../../config/home-manager/fonts.nix
    ../../config/home-manager/bash.nix
    ../../config/home-manager/tmux.nix
    ../../config/home-manager/starship.nix
    ../../config/home-manager/bat.nix
    ../../config/home-manager/eza.nix
    ../../config/home-manager/zoxide.nix
    ../../config/home-manager/ssh.nix
    ../../config/home-manager/direnv.nix
    ../../config/home-manager/git.nix
    ../../config/home-manager/ghq.nix
    ../../config/home-manager/gh-dash.nix
    ../../config/home-manager/depot.nix
    ../../config/home-manager/mcp.nix
    ../../config/home-manager/vscode.nix
    ../../config/home-manager/zed-editor.nix
    ../../config/home-manager/opencode.nix
    ../../config/home-manager/openstack.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mnaser";
  home.homeDirectory = "/home/mnaser";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages = [
    claude-desktop-pkg
  ]
  ++ (with pkgs; [
    chatterino7
    discord
    element-desktop
    openlinkhub
    pinentry-gnome3
    prismlauncher
    slack
    spotify
    streamlink
    teams-for-linux
    vlc
    zoom-us
  ]);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.gh.enable = true;

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    lsp.servers = {
      nixd = {
        enable = true;
      };
    };

    plugins = {
      lspconfig = {
        enable = true;
      };

      trouble = {
        enable = true;
      };
    };

    plugins.copilot-lua.settings.filetypes = {
      yaml = true;
    };

    plugins.blink-copilot.enable = true;

    plugins.blink-cmp = {
      enable = true;

      settings.keymap.preset = "super-tab";

      settings.sources.providers = {
        copilot = {
          name = "copilot";
          module = "blink-copilot";
          score_offset = 100;
          async = true;
        };
      };

      settings.sources.default = [
        "copilot"
      ];
    };
  };

  services.syncthing.settings = {
    folders = {
      "~/src" = {
        id = "src";
        devices = [
          "zenbook"
        ];
      };
    };

    devices = {
      zenbook.id = "JG5EJDZ-QY2UEW6-WBUVSTV-SZV5Z6E-N3B6HLB-BUCWPRB-LLUTDE3-6E4ZIQL";
    };
  };
}
