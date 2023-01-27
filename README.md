# ctl-nix

Cardano transaction lib backed by nix

## Usage

```bash
nix flake init -t github:LovelaceAcademy/nix-templates#ctl
```

## How to upgrade

- pin CTL
- `nix flake lock`
- pin `package-set-repo` flake input to corresponding CTL `packages.dhall` upstream rev
- `nix build .#package-set --impure`
- `cp result nix/package-set/default.nix`
- update `nix/purs-nix/custom-deps.nix` according CTL `{spago/packages}.dhall`
- `cd test && nix flake check && nix build`
