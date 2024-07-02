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
        imageName = "ghcr.io/exeteres/devcontainer-base";
        imageDigest = "sha256:48036727ee7d0006deb8c233316b310d6bae2ca193599c96c5cf72a2e7d6b868";
        sha256 = "sha256-lvvNrCM69x4q2Meoxt0zQ9eTAmF1n9LyuuEmr1PBKQg=";
      };

      extraCommands = ''
        # The upstream image links the whole /bin directory to /usr/bin,
        # but buildLayeredImage overwrites it with the new /bin directory and links /nix/store binaries to it.
        # This breaks some tools expecting /bin/sh to be present (like VSCode DevContainers),
        # so we need to create a symlink to /usr/bin/sh.
        ln -s /usr/bin/sh /bin/sh
        ln -s /usr/bin/bash /bin/bash
      '';

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
        nodenv
        alejandra
        nil
      ];
    };
  };
}
