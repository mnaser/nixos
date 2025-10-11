{ ... }:

{
  services.syncthing.enable = true;
  services.syncthing.settings.folders = {
    "~/src" = {
      id = "src";
      devices = [];
    };
  };
}
