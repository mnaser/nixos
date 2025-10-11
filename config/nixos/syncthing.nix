{ ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      21027
      22000
    ];
  };

  home-manager.users.mnaser =
    { ... }:
    {
      services.syncthing.enable = true;
    };
}
