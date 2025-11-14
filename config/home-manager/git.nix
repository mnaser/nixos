{ lib, pkgs, ... }:

rec {
  programs.git.enable = true;
  programs.git.package = pkgs.git;

  programs.git.settings = {
    user = {
      name = "Mohammed Naser";
      email = "mnaser@vexxhost.com";
    };

    init = {
      defaultBranch = "main";
    };
  };

  programs.git.hooks = {
    prepare-commit-msg = pkgs.writeShellScript "prepare-commit-msg.sh" ''
      ${lib.getExe' programs.git.package "git"} interpret-trailers --if-exists doNothing --trailer \
          "Signed-off-by: ${programs.git.settings.user.name} <${programs.git.settings.user.email}>" \
          --in-place "$1"
    '';
  };
}
