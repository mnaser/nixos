{ pkgs, ... }:

{
  boot.plymouth.enable = true;
  boot.initrd.systemd.enable = true;

  boot.plymouth.theme = "deus_ex";
  boot.plymouth.themePackages = with pkgs; [
    (adi1090x-plymouth-themes.override {
      selected_themes = [ "deus_ex" ];
    })
  ];

  boot.loader.timeout = 0;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
}
