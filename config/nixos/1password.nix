{ lib, pkgs, ... }:

{
  programs._1password.enable = true;

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "mnaser" ];
  };

  programs.chromium.extensions = [
    "aeblfdkhhhdcdjpifhhbdiojplfjncoa"
  ];

  home-manager.users.mnaser =
    { ... }:
    {
      programs.ssh.matchBlocks = {
        "*" = {
          identityAgent = "~/.1password/agent.sock";
        };
      };

      programs.git.signing = {
        format = "ssh";
        signer = lib.getExe' pkgs._1password-gui "op-ssh-sign";
        signByDefault = true;
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFUZ4e9irE5jBQZKxpqnoeJns6pmSUNNW0xVTJWB31zF";
      };
    };
}
