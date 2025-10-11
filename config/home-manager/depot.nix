{ pkgs, ... }:

let
  depot = pkgs.buildGoModule rec {
    pname = "depot";
    version = "2.100.8";

    src = pkgs.fetchFromGitHub {
      owner = "depot";
      repo = "cli";
      tag = "v${version}";
      hash = "sha256-qUuCFRheNzWhbhCcxb9e6CuuXF7bjQcmVw5FZY/Mm2E=";

      leaveDotGit = true;
      postFetch = ''
        cd "$out"
        date -u -d "@$(git log -1 --pretty=%ct)" "+%Y-%m-%d" > $out/BUILD_COMMIT_DATE
        find "$out" -name .git -print0 | xargs -0 rm -rf
      '';
    };

    vendorHash = "sha256-NsSc5bod+7Gb1RBZajjBIYaIRXPOn62ZTu6R/kJzbMA=";

    preBuild = ''
      ldflags+=" -X github.com/depot/cli/internal/build.Date=$(cat BUILD_COMMIT_DATE)"
    '';


    ldflags =
      let
        t = "github.com/depot/cli/internal/build";
      in
      [
        "-X ${t}.Version=${version}"
        "-X ${t}.SentryEnvironment=release"
      ];
  };

in
{
  home.packages = [ depot ];
}
