{ config, pkgs, ... }:

{
  imports = [
    ../../config/home-manager/git.nix
    ../../config/home-manager/vscode.nix
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

  home.packages =
    with pkgs;
    [
      chatterino7
      claude-code
      discord
      ghq
      openlinkhub
      pinentry-gnome3
      teams-for-linux
      zoom-us
    ]
    ++ (with pkgs.gnomeExtensions; [
      appindicator
      bing-wallpaper-changer
      clipboard-indicator
    ]);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash.enable = true;
  programs.bash.sessionVariables = {
    DEPOT_INSTALL_DIR = "/home/mnaser/.depot/bin";
    PATH = "$DEPOT_INSTALL_DIR:$PATH";
  };

  dconf.settings = {
    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "BingWallpaper@ineffable-gmail.com"
        "clipboard-indicator@tudmotu.com"
      ];
    };

    "org/gnome/shell/weather" = {
      automatic-location = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };

    "org/gnome/shell/extensions/bingwallpaper" = {
      icon-name = "high-frame-symbolic";
      set-background = true;
      override-lockscreen-blur = true;
      lockscreen-blur-strength = 2;
      lockscreen-blur-brightness = 30;
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

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

  programs.ssh.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

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
