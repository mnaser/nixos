{ config, pkgs, pkgs-master, ... }:

let
  claude-code = pkgs.symlinkJoin {
    name = "claude-code-wrapped";
    paths = [ pkgs-master.claude-code ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --set TMPDIR /tmp/claude \
        --run 'export GITHUB_TOKEN="$(cat ${config.age.secrets.github.path})"'
    '';
  };
in
{
  environment.etc."claude-code/managed-mcp.json" = {
    text = builtins.toJSON {
      mcpServers = {
        atlassian-mcp-server = {
          type = "sse";
          url = "https://mcp.atlassian.com/v1/sse";
        };
        github = {
          type = "http";
          url = "https://api.githubcopilot.com/mcp";
          headers = {
            Authorization = "Bearer \${GITHUB_TOKEN}";
          };
        };
      };
    };
  };

  programs.chromium.extensions = [
    "fcoeoabgfenejglbffodgkkbkcdhcgfn"
  ];

  home-manager.users.mnaser =
    { ... }:
    {
      home.packages = [
        claude-code
        pkgs.xclip
        pkgs.bubblewrap
        pkgs.socat
      ];

      home.file.".claude/settings.json" = {
        text = builtins.toJSON {
          permissions = {
            allow = [
              "mcp__atlassian-mcp-server__getJiraIssue"
              "mcp__github__get_commit"
              "mcp__github__get_file_contents"
              "mcp__github__get_me"
              "mcp__github__issue_read"
              "mcp__github__list_branches"
              "mcp__github__list_commits"
              "mcp__github__list_tags"
              "mcp__github__pull_request_read"
              "mcp__github__search_repositories"
              "mcp__zendesk__get_ticket"
              "mcp__zendesk__get_ticket_comments"
            ];
          };
          sandbox = {
            enabled = true;
          };
        };
      };
    };
}
