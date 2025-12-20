{ lib, pkgs, ... }:

let
  npx = pkgs.symlinkJoin {
    name = "npx-wrapped";
    paths = [ pkgs.nodejs ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/npx \
        --prefix PATH : ${lib.makeBinPath [ pkgs.nodejs ]}
    '';
  };

  npxServer = name: {
    command = lib.getExe' npx "npx";
    args = [
      "-y"
      "${name}@latest"
    ];
  };

  zenpy = pkgs.python3Packages.callPackage ../../pkgs/zenpy/default.nix { };
  zendesk-mcp-server = pkgs.python3Packages.callPackage ../../pkgs/zendesk-mcp-server/default.nix {
    inherit zenpy;
  };
in
{
  programs.mcp.enable = true;
  programs.mcp.servers = {
    atlassian-mcp-server = {
      type = "sse";
      url = "https://mcp.atlassian.com/v1/sse";
    };
    chrome-devtools = npxServer "chrome-devtools-mcp";
    kubernetes-mcp-server = npxServer "kubernetes-mcp-server";
    zendesk = {
      command = lib.getExe zendesk-mcp-server;
    };
  };
}
