{ pkgs, ... }:

{
  home.packages = with pkgs; [
    openstackclient
    openstack-rs
  ];
}
