{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    environment = lib.mkOption {
      type = lib.types.enum [
        "gnome"
        "hyprland"
      ];
      default = "gnome";
      description = "Desktop environment to use (gnome or hyprland)";
    };
  };

  config = lib.mkMerge [
    # Common configuration for all desktop environments
    {
      services.gnome.gnome-keyring.enable = true;
    }

    # GNOME configuration
    (lib.mkIf (cfg.environment == "gnome") {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
      '';

      services.gnome.gnome-online-accounts.enable = true;

      home-manager.users.mnaser =
        { ... }:
        {
          home.packages = with pkgs.gnomeExtensions; [
            appindicator
            bing-wallpaper-changer
            clipboard-indicator
          ];

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

            "org/gnome/shell/extensions/bingwallpaper" = {
              icon-name = "high-frame-symbolic";
              set-background = true;
              override-lockscreen-blur = true;
              lockscreen-blur-strength = 2;
              lockscreen-blur-brightness = 30;
            };
          };
        };
    })

    # Hyprland configuration
    (lib.mkIf (cfg.environment == "hyprland") {
      programs.hyprland.enable = true;

      home-manager.users.mnaser =
        { ... }:
        {
          wayland.windowManager.hyprland.enable = true;
        };
    })
  ];
}
