{ ... }:

{
  users.users.mnaser = {
    extraGroups = [ "libvirtd" ];
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  programs.virt-manager.enable = true;
}
