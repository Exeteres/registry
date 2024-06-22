{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    attic = {
      url = "github:zhaofengli/attic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      contents = [attic.packages.x86_64-linux.attic-server];
    };
  };
}
