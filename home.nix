{
  config,
  lib,
  pkgs,
  ...
}:

{
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
      adwaita-fonts
      chatterino7
      claude-code
      discord
      font-awesome
      ghq
      pinentry-gnome3
      teams-for-linux
      zoom-us
    ]
    ++ (with pkgs.gnomeExtensions; [
      bing-wallpaper-changer
    ]);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash.enable = true;

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
    x11.enable = true;
    gtk.enable = true;
  };

  gtk.enable = true;
  gtk.font.name = "Adwaita Sans";
  gtk.font.package = pkgs.adwaita-fonts;

  services.mako.enable = true;

  programs.fuzzel.enable = true;

  home.file.".config/waybar/power_menu.xml".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Alexays/Waybar/18a9835b7cf03ce116c0da03939e1cfef7796f7e/resources/custom_modules/power_menu.xml";
    hash = "sha256-od1Hk8vSPvOBC1n3C0nHEXKiEDMRzKFCbUGcTWveKXo=";
  };
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
    };
  };

  programs.niri.settings = {
    input = {
      keyboard = {
        xkb = { };
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      mouse = { };

      focus-follows-mouse = {
        enable = false;
      };
    };

    outputs = {
      "ASUSTek COMPUTER INC PG27UCDM T1LMAS015583" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 240.000;
        };
      };

      "ASUSTek COMPUTER INC PG27UCDM T1LMAS015588" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 240.000;
        };
      };
    };

    cursor = {
      theme = "Adwaita";
    };

    layout = {
      gaps = 16;

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
        { proportion = 1.0; }
      ];

      default-column-width = {
        proportion = 0.5;
      };

      focus-ring = {
        enable = true;
        width = 4;
        active = {
          color = "#7fc8ff";
        };
        inactive = {
          color = "#505050";
        };
      };

      border = {
        enable = false;
        width = 4;
        active = {
          color = "#ffc87f";
        };
        inactive = {
          color = "#505050";
        };
        urgent = {
          color = "#9b0000";
        };
      };

      struts = { };
    };

    hotkey-overlay = { };

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    animations = { };

    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
      }
      {
        excludes = [
          { is-focused = true; }
        ];

        opacity = 1.0;
      }
      {
        matches = [
          { app-id = "^org\\.wezfurlong\\.wezterm$"; }
        ];
        default-column-width = { };
      }
      {
        matches = [
          {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }
    ];

    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };

      "Mod+T" = {
        action.spawn = [ "ghostty" ];
        hotkey-overlay = {
          title = "ghostty";
        };
      };

      "Mod+D" = {
        action.spawn = [ "fuzzel" ];
        hotkey-overlay = {
          title = "Run an Application: fuzzel";
        };
      };
      "Super+Alt+L" = {
        action.spawn = [ "swaylock" ];
        hotkey-overlay = {
          title = "Lock the Screen: swaylock";
        };
      };

      "Super+Alt+S" = {
        action.spawn-sh = "pkill orca || exec orca";
        allow-when-locked = true;
      };

      "XF86AudioRaiseVolume" = {
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        allow-when-locked = true;
      };

      "XF86AudioPlay" = {
        action.spawn-sh = "playerctl play-pause";
        allow-when-locked = true;
      };
      "XF86AudioStop" = {
        action.spawn-sh = "playerctl stop";
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action.spawn-sh = "playerctl previous";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action.spawn-sh = "playerctl next";
        allow-when-locked = true;
      };

      "XF86MonBrightnessUp" = {
        action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "+10%"
        ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action.spawn = [
          "brightnessctl"
          "--class=backlight"
          "set"
          "10%-"
        ];
        allow-when-locked = true;
      };

      "Mod+O" = {
        action.toggle-overview = { };
        repeat = false;
      };

      "Mod+Q" = {
        action.close-window = { };
        repeat = false;
      };

      "Mod+Left".action.focus-column-left = { };
      "Mod+Down".action.focus-window-down = { };
      "Mod+Up".action.focus-window-up = { };
      "Mod+Right".action.focus-column-right = { };
      "Mod+H".action.focus-column-left = { };
      "Mod+J".action.focus-window-down = { };
      "Mod+K".action.focus-window-up = { };
      "Mod+L".action.focus-column-right = { };

      "Mod+Ctrl+Left".action.move-column-left = { };
      "Mod+Ctrl+Down".action.move-window-down = { };
      "Mod+Ctrl+Up".action.move-window-up = { };
      "Mod+Ctrl+Right".action.move-column-right = { };
      "Mod+Ctrl+H".action.move-column-left = { };
      "Mod+Ctrl+J".action.move-window-down = { };
      "Mod+Ctrl+K".action.move-window-up = { };
      "Mod+Ctrl+L".action.move-column-right = { };

      "Mod+Home".action.focus-column-first = { };
      "Mod+End".action.focus-column-last = { };
      "Mod+Ctrl+Home".action.move-column-to-first = { };
      "Mod+Ctrl+End".action.move-column-to-last = { };

      "Mod+Shift+Left".action.focus-monitor-left = { };
      "Mod+Shift+Down".action.focus-monitor-down = { };
      "Mod+Shift+Up".action.focus-monitor-up = { };
      "Mod+Shift+Right".action.focus-monitor-right = { };
      "Mod+Shift+H".action.focus-monitor-left = { };
      "Mod+Shift+J".action.focus-monitor-down = { };
      "Mod+Shift+K".action.focus-monitor-up = { };
      "Mod+Shift+L".action.focus-monitor-right = { };

      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

      "Mod+Page_Down".action.focus-workspace-down = { };
      "Mod+Page_Up".action.focus-workspace-up = { };
      "Mod+U".action.focus-workspace-down = { };
      "Mod+I".action.focus-workspace-up = { };
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
      "Mod+Ctrl+U".action.move-column-to-workspace-down = { };
      "Mod+Ctrl+I".action.move-column-to-workspace-up = { };

      "Mod+Shift+Page_Down".action.move-workspace-down = { };
      "Mod+Shift+Page_Up".action.move-workspace-up = { };
      "Mod+Shift+U".action.move-workspace-down = { };
      "Mod+Shift+I".action.move-workspace-up = { };

      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = { };
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = { };
        cooldown-ms = 150;
      };

      "Mod+WheelScrollRight".action.focus-column-right = { };
      "Mod+WheelScrollLeft".action.focus-column-left = { };
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = { };
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = { };

      "Mod+Shift+WheelScrollDown".action.focus-column-right = { };
      "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = { };
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = { };

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "Mod+BracketLeft".action.consume-or-expel-window-left = { };
      "Mod+BracketRight".action.consume-or-expel-window-right = { };

      "Mod+Comma".action.consume-window-into-column = { };
      "Mod+Period".action.expel-window-from-column = { };

      "Mod+R".action.switch-preset-column-width = { };
      "Mod+Shift+R".action.switch-preset-window-height = { };
      "Mod+Ctrl+R".action.reset-window-height = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };

      "Mod+Ctrl+F".action.expand-column-to-available-width = { };

      "Mod+C".action.center-column = { };

      "Mod+Ctrl+C".action.center-visible-columns = { };

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+V".action.toggle-window-floating = { };
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = { };

      "Mod+W".action.toggle-column-tabbed-display = { };

      "Print".action.screenshot = { };
      "Ctrl+Print".action.screenshot-screen = { };
      "Alt+Print".action.screenshot-window = { };

      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = { };
        allow-inhibiting = false;
      };

      "Mod+Shift+E".action.quit = { };
      "Ctrl+Alt+Delete".action.quit = { };

      "Mod+Shift+P".action.power-off-monitors = { };
    };

    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "BingWallpaper@ineffable-gmail.com"
      ];
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

  programs.ghostty = {
    enable = true;
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
  programs.ssh.matchBlocks = {
    "*" = {
      identityAgent = "~/.1password/agent.sock";
    };
  };

  programs.git.enable = true;
  programs.git.userName = "Mohammed Naser";
  programs.git.userEmail = "mnaser@vexxhost.com";
  programs.git.extraConfig = {
    ghq = {
      root = "~/src";
    };
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
