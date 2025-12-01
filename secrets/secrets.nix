let
  mnaser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0idNvgGiucWgup/mP78zyC23uFjYq0evcWdjGQUaBH";

  rig = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtRRMwl0XJ0G4K/1/8RN09hy2i1kRPNGaRaBfLUx0nb";
in
{
  "github.age".publicKeys = [ mnaser rig ];
}
