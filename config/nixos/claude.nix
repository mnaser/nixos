{ lib, pkgs, ... }:

{
  environment.etc."claude-code/managed-mcp.json" = {
    mode = "0644";
    text = builtins.toJSON {
      mcpServers = {
        next-devtools = {
          command = lib.getExe' pkgs.nodejs "npx";
          args = [ "next-devtools-mcp@latest" ];
        };
        playwright = {
          command = lib.getExe' pkgs.nodejs "npx";
          args = [ "@playwright/mcp@latest" ];
        };
        shadcn = {
          command = lib.getExe' pkgs.nodejs "npx";
          args = [ "shadcn@latest" "mcp" ];
        };
      };
    };
  };

  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = with pkgs; [ claude-code ];
    };
}
