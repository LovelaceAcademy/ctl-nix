{
  description = "Cardano transaction lib backed by nix";

  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      utils.url = "github:ursi/flake-utils";
      # TODO remove pinned to match v4.0.2
      ctl.url = "github:Plutonomicon/cardano-transaction-lib/e3003b91d97ac02504f8b5e23657189b663d797b";
      # TODO find a way to get package-set-repo from ctl
      #  package-set-repo now is pinned to follow ctl /packages.dhall
      #  we need a way to extract this information from there
      package-set-repo.url = "github:purescript/package-sets/2f7bde38fae5f6726f354b31b6d927347ef54c4a";
      package-set-repo.flake = false;

      npmlock2nix.url = "github:nix-community/npmlock2nix";
      npmlock2nix.flake = false;
    };

  outputs = { self, nixpkgs, utils, package-set-repo, ctl, npmlock2nix, ... }@inputs:
    let
      # this export a lib with the override
      __functor = _: { system }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          npmlock2nix' = import npmlock2nix { inherit pkgs; };
        in
        import ./nix/purs-nix
          package-set-repo
          ctl
          pkgs
          npmlock2nix';
    in
    { inherit __functor; } // utils.apply-systems
      {
        inherit inputs;
        # TODO remove systems limited by the test
        systems = [ "x86_64-linux" ];
      }
      ({ system, ... }@ctx:
        let
          package-set = import ./nix/package-set/generate.nix package-set-repo ctx.pkgs;
        in
        {
          packages.package-set = package-set;
        });
}
