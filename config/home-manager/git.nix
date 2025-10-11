{ lib, pkgs, ... }:

rec {
  programs.git.enable = true;
  programs.git.package = pkgs.git;
  programs.git.userName = "Mohammed Naser";
  programs.git.userEmail = "mnaser@vexxhost.com";

  programs.git.hooks = {
    prepare-commit-msg = pkgs.writeShellScript "prepare-commit-msg.sh" ''
      ${lib.getExe' programs.git.package "git"} interpret-trailers --if-exists doNothing --trailer \
          "Signed-off-by: ${programs.git.userName} <${programs.git.userEmail}>" \
          --in-place "$1"
    '';
  };

  programs.git.extraConfig = {
    init = {
      defaultBranch = "main";
    };

    ghq = {
      root = "~/src";
    };
  };
}
