#!/bin/sh
set -e

mkdir -p out

echo "<+> Building base image using Dockerfile"
docker build . -t base
docker save base -o out/base.tar
git add out/base.tar

trap "rm -rf out" EXIT

echo "<+> Building devcontainer image using nix build"
nix build .#image -o out/result
image_name=`./out/result | docker load | grep -oP 'Loaded image: \K.*'`
echo "<+> Image name: $image_name"

echo "<+> Pushing image to registry"
docker push $image_name