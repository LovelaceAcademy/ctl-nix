# Contributing to purs-nix-packages

Any contribution is welcome.

## Conventional Commits

We follow conventional commit [specification](https://www.conventionalcommits.org/en/v1.0.0/#summary).

## How to upgrade CTL

- pin CTL and peer deps on `flake.nix`
- `nix flake lock`
- pin `package-set-repo` flake input to corresponding CTL `packages.dhall` upstream rev
- `nix build .#ctl-package-set --impure`
- `cp result ctl/package-set/default.nix`
- update `ctl/purs-nix/custom-deps.nix` according CTL `{spago/packages}.dhall`
- `./.github/workflows/test.sh` (you'll need to upgrade `LovelaceAcademy/nix-templates` ctl-full in case of template breaking changes)
