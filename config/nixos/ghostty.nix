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
        font-size = 11;
        shell-integration-features = true;
        theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
      };
    };
}
