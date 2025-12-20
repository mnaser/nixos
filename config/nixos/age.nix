{
  services.openssh.enable = true;

  age.secrets.mcp = {
    owner = "mnaser";
    file = ../../secrets/mcp.age;
  };

  age.secrets.github = {
    owner = "mnaser";
    file = ../../secrets/github.age;
  };
}
