{ pkgs, pkgs-master, ... }:

{
  programs.chromium.extensions = [
    "fcoeoabgfenejglbffodgkkbkcdhcgfn"
  ];

  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = [
        pkgs-master.claude-code
        pkgs.xclip
      ];
    };
}
