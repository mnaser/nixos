{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    secureSocket = false;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      better-mouse-mode
    ];
    extraConfig = ''
      set-option -g set-titles on
      set-option -g set-titles-string "#{pane_title}"
    '';
  };
}
