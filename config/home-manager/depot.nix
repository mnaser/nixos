{ pkgs, ... }:

let
  depot = pkgs.buildGoModule rec {
    pname = "depot";
    version = "2.100.8";

    src = pkgs.fetchFromGitHub {
      owner = "depot";
      repo = "cli";
      tag = "v${version}";
      hash = "sha256-XJnnDVHbUB40Y+cAerrybhlvQjFAnAckDDNjLmkKXyc=";
    };

    vendorHash = "sha256-NsSc5bod+7Gb1RBZajjBIYaIRXPOn62ZTu6R/kJzbMA=";

    ldflags =
      let
        t = "github.com/depot/cli/internal/build";
      in
      [
        "-X ${t}.Version=${version}"
        "-X ${t}.Date=1970-01-01T01:01:01Z"
        "-X ${t}.SentryEnvironment=release"
      ];
  };

in
{
  home.packages = [ depot ];
}
