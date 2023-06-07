# this is a purs-nix overlay (not nixpkgs overlay)
package-set-repo: inputs: pkgs: npmlock2nix:
let
  b = builtins;
  p = pkgs;
  l = p.lib;
  package-set = import ./package-set.nix;
  custom-deps = import ./custom-deps.nix package-set-repo inputs p npmlock2nix;
in
l.composeExtensions package-set custom-deps
