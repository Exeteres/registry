{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    image = pkgs.dockerTools.buildLayeredImage {
      name = "ghcr.io/exeteres/devcontainer";

      fromImage = pkgs.dockerTools.pullImage {
        imageName = "ghcr.io/exeteres/devcontainer-base:46bb56918c5d0ffd710c1c1bb476bf2695d68775";
        imageDigest = "sha256:48036727ee7d0006deb8c233316b310d6bae2ca193599c96c5cf72a2e7d6b868";
        sha256 = "";
      };

      contents = with pkgs; [
        kubectl
        vim
        inetutils
        kubernetes-helm
        dive
        pulumi
        go
        crd2pulumi
        dotnet-sdk_8
      ];
    };
  };
}
