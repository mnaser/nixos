{ config, pkgs, ... }:

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
      chatterino7
      claude-code
      discord
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
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.gh.enable = true;

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

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
