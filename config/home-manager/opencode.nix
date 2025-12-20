{ llm-agents, ... }:

{
  programs.opencode.enable = true;
  programs.opencode.package = llm-agents.opencode;
  programs.opencode.enableMcpIntegration = true;
}
