{
  services.openssh.enable = true;

  age.secrets.github = {
    owner = "mnaser";
    file = ../../secrets/github.age;
  };
}
