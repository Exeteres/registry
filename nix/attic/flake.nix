{
  inputs = {
    nixpkgs.url = "nixpkgs/unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    image = pkgs.dockerTools.buildLayeredImage {
      name = "ghcr.io/exeteres/attic";
      contents = [pkgs.attic-server];
    };
  };
}
