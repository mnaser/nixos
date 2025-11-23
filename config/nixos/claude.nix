{ pkgs, ... }:

{
  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = with pkgs; [
        claude-code
        xclip
      ];
    };
}
