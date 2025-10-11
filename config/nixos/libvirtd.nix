{ ... }:

{
  users.users.mnaser = {
    extraGroups = [ "libvirtd" ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  programs.virt-manager.enable = true;

  home-manager.users.mnaser =
    { ... }:
    {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };
    };
}
