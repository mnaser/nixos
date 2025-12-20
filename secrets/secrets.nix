let
  rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtRRMwl0XJ0G4K/1/8RN09hy2i1kRPNGaRaBfLUx0nb";
  zenbook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSqZ9U6Ll8u5ZIM0KSkJ5kAKjKy1N5QTZ5TkA60QWpI";
in
{
  "github.age".publicKeys = [
    rig
    zenbook
  ];

  "mcp.age".publicKeys = [
    rig
    zenbook
  ];
}
