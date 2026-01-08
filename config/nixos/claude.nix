{
  config,
  lib,
  pkgs,
  llm-agents,
  ...
}:

let
  anthropics-skills = builtins.fetchGit {
    url = "https://github.com/anthropics/skills.git";
    ref = "main";
    rev = "f232228244495c018b3c1857436cf491ebb79bbb";
  };

  claude-code = pkgs.writeShellApplication {
    name = "claude";
    runtimeInputs = [
      pkgs.xclip
      pkgs.bubblewrap
      pkgs.socat
      pkgs.jq
    ];
    runtimeEnv = {
      TMPDIR = "/tmp/claude";
    };
    text = ''
      # shellcheck source=/dev/null
      source ${config.age.secrets.mcp.path}

      exec ${llm-agents.claude-code}/bin/claude "$@"
    '';
  };
in
{
  programs.chromium.extensions = [
    "fcoeoabgfenejglbffodgkkbkcdhcgfn"
  ];

  home-manager.users.mnaser =
    { config, ... }:
    {
      programs.claude-code.enable = true;
      programs.claude-code.package = claude-code;

      programs.claude-code.settings = {
        permissions = {
          allow = [
            "Bash(gh pr list:*)"
            "Bash(gh pr view:*)"
            "Bash(gh run list:*)"
            "Bash(gh run view:*)"
            "Bash(openstack flavor list:*)"
            "Bash(openstack image list:*)"
            "Bash(stern:*)"
            "Bash(tailscale status:*)"
            "Bash(tailscale status:*)"
            "Edit(/home/mnaser/.cache)"
            "Edit(/home/mnaser/.cargo)"
            "Edit(/home/mnaser/src)"
            "WebFetch(domain:ansible-galaxy-ng.s3.dualstack.us-east-1.amazonaws.com)"
            "WebFetch(domain:api.github.com)"
            "WebFetch(domain:channels.nixos.org)"
            "WebFetch(domain:files.pythonhosted.org)"
            "WebFetch(domain:galaxy.ansible.com)"
            "WebFetch(domain:ghcr.io)"
            "WebFetch(domain:github.com)"
            "WebFetch(domain:githubusercontent.com)"
            "WebFetch(domain:opendev.org)"
            "WebFetch(domain:pypi.org)"
            "WebSearch"
            "mcp__atlassian-mcp-server__atlassianUserInfo"
            "mcp__atlassian-mcp-server__getAccessibleAtlassianResources"
            "mcp__atlassian-mcp-server__getJiraIssue"
            "mcp__atlassian-mcp-server__getTransitionsForJiraIssue"
            "mcp__atlassian-mcp-server__getVisibleJiraProjects"
            "mcp__atlassian-mcp-server__lookupJiraAccountId"
            "mcp__atlassian-mcp-server__searchJiraIssuesUsingJql"
            "mcp__github__get_commit"
            "mcp__github__get_file_contents"
            "mcp__github__get_latest_release"
            "mcp__github__get_me"
            "mcp__github__get_release_by_tag"
            "mcp__github__issue_read"
            "mcp__github__list_branches"
            "mcp__github__list_commits"
            "mcp__github__list_pull_requests"
            "mcp__github__list_tags"
            "mcp__github__pull_request_read"
            "mcp__github__search_code"
            "mcp__github__search_issues"
            "mcp__github__search_pull_requests"
            "mcp__github__search_repositories"
            "mcp__kubernetes-mcp-server__configuration_contexts_list"
            "mcp__kubernetes-mcp-server__helm_list"
            "mcp__kubernetes-mcp-server__namespaces_list"
            "mcp__kubernetes-mcp-server__pods_list_in_namespace"
            "mcp__zendesk__get_ticket"
            "mcp__zendesk__get_ticket_comments"
            "mcp__zendesk__get_tickets"
          ];
          ask = [
            "mcp__zendesk__update_ticket"
            "mcp__zendesk__create_ticket_comment"
          ];
        };
        extraKnownMarketplaces = {
          vexxhost = {
            source = {
              source = "github";
              repo = "vexxhost/claude-code-plugins";
            };
          };
        };
        enabledPlugins = {
          "git@vexxhost" = true;
          "renovate@vexxhost" = true;
        };
      };

      programs.claude-code.mcpServers = config.programs.mcp.servers // {
        github = {
          type = "http";
          url = "https://api.githubcopilot.com/mcp";
          headers = {
            Authorization = "Bearer \${GITHUB_TOKEN}";
          };
        };
      };

      programs.claude-code.skillsDir = pkgs.linkFarm "anthropics-skills" [
        {
          name = "frontend-design";
          path = "${anthropics-skills}/skills/frontend-design";
        }
        {
          name = "doc-coauthoring";
          path = "${anthropics-skills}/skills/doc-coauthoring";
        }
      ];

      programs.claude-code.commands = {
        "atmosphere/aio" = ''
          ---
          description: Build an Atmosphere all-in-one for the specified branch or PR.
          argument-hint: branch [branch] | pr [pr-number]
          ---

          If $ARGUMENTS is a number, treat it as a PR number; otherwise, treat it as a
          branch name.

          1. Create a new instance using the OpenStack CLI using an Ubuntu 22.04 image
              with at least 16 cores and 32 GB of RAM.
          2. SSH into the instance and install "git" and "tox".
          3. As root, clone the Atmosphere repository from GitHub into `/opt/atmosphere`.
          4. Checkout the specified branch or PR.
          5. Run the Atmosphere all-in-one build process using "tox -e molecule-aio-ovn"
              inside of a screen session.
          6. Output the public IP address of the instance.

          Make sure to use the following details:

          - Use `--os-cloud public` when creating the instance.
          - Use `--os-region-name ca-ymq-1` when creating the instance.
          - Find the "1password" SSH keypair and use it.
          - Do not use the Sandboxing feature for SSH commands.
        '';
      };
    };
}
