{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ gnome-console ];

  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = with pkgs; [ monaspace ];

      programs.ghostty.enable = true;
      programs.ghostty.settings = {
        theme = "light:Catppuccin Latte,dark:Catppuccin Mocha";
        font-family = "Monaspace Neon";
        font-size = 11;
      };

      programs.ssh.matchBlocks = {
        "*" = {
          setEnv = {
            TERM = "xterm-256color";
          };
        };
      };
    };
}
