# Contributing to ctl-nix

Any contribution is welcome.

## Conventional Commits

We follow conventional commit [specification](https://www.conventionalcommits.org/en/v1.0.0/#summary).

## How to upgrade CTL in ctl-nix

- pin CTL and peer deps on `flake.nix`
- `nix flake lock`
- update `nix/package-set/packages.json` to the corresponding CTL `packages.dhall` package-sets rev, [example](https://github.com/purescript/package-sets/blob/psc-0.15.4-20230105/packages.json)
- `nix build .#package-set --impure -L --show-trace --verbose --debug` (you can remove not used and missing deps from `package.json`)
- `cp result nix/package-set/default.nix`
- update `nix/purs-nix/custom-deps.nix` according CTL `{spago/packages}.dhall`
- `./.github/workflows/test.sh` (you'll need to upgrade `LovelaceAcademy/nix-templates` ctl-full in case of template breaking changes, including purs version)

## Commit format
