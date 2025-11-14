{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ gnome-console ];

  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = with pkgs; [ monaspace ];

      programs.ghostty.enable = true;
      programs.ghostty.settings = {
        font-family = "Monaspace Neon";
        font-size = 12;
        shell-integration-features = "cursor,sudo,title,ssh-env";
        theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
        window-height = 36;
        window-padding-color = "extend";
        window-width = 120;
      };
    };
}
