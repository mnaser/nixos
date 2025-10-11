{ lib, pkgs, ... }:

rec {
  programs.git.enable = true;
  programs.git.package = pkgs.git;
  programs.git.userName = "Mohammed Naser";
  programs.git.userEmail = "mnaser@vexxhost.com";

  programs.git.signing = {
    format = "ssh";
    signer = lib.getExe' pkgs._1password-gui "op-ssh-sign";
    signByDefault = true;
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFUZ4e9irE5jBQZKxpqnoeJns6pmSUNNW0xVTJWB31zF";
  };

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
