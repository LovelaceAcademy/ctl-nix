#!/bin/bash
CTL=$(pwd)
TEST_DIR=$(mktemp)
set +ex
rm -Rf $TEST_DIR
set -ex
mkdir $TEST_DIR
(
	cd $TEST_DIR
	git init
	nix flake init -t github:LovelaceAcademy/nix-templates#pix-ctl-full
	sed -i "s|github:LovelaceAcademy/ctl-nix/upgrade-ctl|path:$CTL|g" flake.nix
	nix develop --command npm install --no-save
	nix build --show-trace -L
	nix flake check --show-trace
)
