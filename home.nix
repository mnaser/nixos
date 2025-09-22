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

  home.packages = with pkgs; [
    claude-code
    discord
    ghq
    teams-for-linux
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.gh.enable = true;
  programs.vim.enable = true;

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
