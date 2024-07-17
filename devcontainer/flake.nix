{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    image = pkgs.dockerTools.streamLayeredImage {
      name = "ghcr.io/exeteres/devcontainer";
      tag = "latest";
      fromImage = ./out/base.tar;

      contents = with pkgs; [
        kubectl
        kubernetes-helm
        dive
        pulumi
        pulumiPackages.pulumi-language-nodejs
        go
        crd2pulumi
        dotnet-sdk_8
        alejandra
        nil
        go-task
      ];
    };
  };
}
