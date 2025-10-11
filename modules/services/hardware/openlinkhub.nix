{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.services.hardware.openlinkhub;
in
{
  options.services.hardware.openlinkhub = {
    enable = lib.mkEnableOption "OpenLink Hub service";

    package = lib.mkPackageOption pkgs "openlinkhub" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.services.openlinkhub = {
      description = "Open source interface for iCUE LINK System Hub, Corsair AIOs and Hubs";
      after = [ "network.target" ];
      wants = [ "dev-usb.device" ];
      wantedBy = [ "multi-user.target" ];
      path = with pkgs; [ pciutils ];
      serviceConfig = {
        StateDirectory = "OpenLinkHub";
        WorkingDirectory = "/var/lib/OpenLinkHub";
        ExecStart = "${cfg.package}/bin/OpenLinkHub";
        Restart = "always";
      };
    };
  };
}
