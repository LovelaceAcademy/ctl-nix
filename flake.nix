{
  description = "Additional purs-nix packages through different package sets";

  inputs =
    {
      utils.url = "github:ursi/flake-utils";
      npmlock2nix.url = "github:nix-community/npmlock2nix";
      npmlock2nix.flake = false;

      # TODO move CTL to own its flake in subdir
      # TODO remove pinned to match v5.0.0
      ctl.url = "github:Plutonomicon/cardano-transaction-lib/205f25b591656b825186d2187fdcba1e00c3df87";
      # TODO move to upstream purs-nix
      #  depends on purs-nix/purs-nix#44
      purs-nix.url = "github:LovelaceAcademy/purs-nix/ctl-nix";
      nixpkgs.follows = "purs-nix/nixpkgs";
      # TODO find a way to get package-set-repo from ctl
      #  package-set-repo now is pinned to follow ctl /packages.dhall
      #  we need a way to extract this information from there
      ctl-package-set-repo.url = "github:purescript/package-sets/2f7bde38fae5f6726f354b31b6d927347ef54c4a";
      ctl-package-set-repo.flake = false;
      # TODO find a way to get peer dependencies from ctl
      #  these inputs now is pinned to follow ctl /packages.dhall
      toppokki.url = "github:firefrorefiddle/purescript-toppokki/6983e07bf0aa55ab779bcef12df3df339a2b5bd9";
      toppokki.flake = false;
    };

  outputs = { self, nixpkgs, utils, ctl-package-set-repo, npmlock2nix, ... }@inputs:
    let
      # this export a lib with the override
      __functor = _: { system }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          npmlock2nix' = import npmlock2nix { inherit pkgs; };
        in
        {
          ctl-overlay = import ./ctl/purs-nix
            ctl-package-set-repo
            inputs
            pkgs
            npmlock2nix';
        };
    in
    { inherit __functor; } // utils.apply-systems
      {
        inherit inputs;
        # TODO remove systems limited by the test
        systems = [ "x86_64-linux" ];
      }
      ({ system, ... }@ctx:
        let
          ctl-package-set = import ./ctl/package-set/generate.nix ctl-package-set-repo ctx.pkgs;
        in
        {
          packages = {
            inherit ctl-package-set;
          };
        });
}
