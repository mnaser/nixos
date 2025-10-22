{ pkgs, ... }:

{
  services.gnome.gnome-keyring.enable = true;
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
      };
    };
}
