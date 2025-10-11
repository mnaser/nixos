{ ... }:

{
  users.users.mnaser = {
    extraGroups = [ "docker" ];
  };

  virtualisation.docker.enable = true;
}
