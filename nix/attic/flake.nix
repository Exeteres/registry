{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
    attic,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    image = pkgs.dockerTools.buildLayeredImage {
      name = "ghcr.io/exeteres/attic";
      contents = [pkgs.attic-server];
    };
  };
}
