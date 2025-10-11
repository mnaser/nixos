{ config, pkgs, ... }:

{
  imports = [
    ../../config/home-manager/ssh.nix
    ../../config/home-manager/ghq.nix
    ../../config/home-manager/direnv.nix
    ../../config/home-manager/git.nix
    ../../config/home-manager/depot.nix
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

  home.file."src/.stignore" = {
    force = true;
    text = ''
      .direnv
      node_modules
      **/target/debug
    '';
  };

  services.syncthing.settings = {
    folders = {
      "~/src" = {
        id = "src";
        devices = [
          "rig"
        ];
      };
    };

    devices = {
      rig.id = "4XTK7TP-H34BGEG-UL4MZRF-U4DDLVI-3SCOZDZ-GISBXH2-6PXES5G-6UIUTQG";
    };
  };
}
