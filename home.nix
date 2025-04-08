{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.username = "mnaser";
  home.homeDirectory = "/home/mnaser";

  home.packages = with pkgs; [
    ghq
    git-review
  ];

  home.shellAliases = {
    tailscale = "tailscale.exe";
  };

  programs.home-manager = {
    enable = true;
  };

  programs.bash = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.git = {
    enable = true;

    userName = "Mohammed Naser";
    userEmail = "mnaser@vexxhost.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
      };

      ghq = {
        root = "/home/mnaser/src";
      };
    };
  };
}
