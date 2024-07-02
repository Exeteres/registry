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
      fromImage = ./devcontainer;

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
