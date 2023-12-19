{
  description = "Cardano transaction lib backed by nix";

  inputs =
    {
      # TODO remove pinned to match v.7.0.0
      ctl.url = "github:Plutonomicon/cardano-transaction-lib/v7.0.0";
      purs-nix.url = "github:purs-nix/purs-nix";
      utils.url = "github:ursi/flake-utils";
      nixpkgs.follows = "purs-nix/nixpkgs";

      npmlock2nix.url = "github:nix-community/npmlock2nix";
      npmlock2nix.flake = false;

      # TODO find a way to get peer dependencies from ctl
      #  these inputs now is pinned to follow ctl /packages.dhall
      toppokki = {
        url = "github:firefrorefiddle/purescript-toppokki/5992e93396a734c980ef61c74df5b6ab46108920";
        flake = false;
      };
      noble-secp256k1 = {
        url = "github:mlabs-haskell/purescript-noble-secp256k1/a3c0f67e9fdb0086016d7aebfad35d09a08b4ecd";
        flake = false;
      };
      js-bigints = {
        url = "github:purescript-contrib/purescript-js-bigints/36a7d8ac75a7230043ae511f3145f9ed130954a9";
        flake = false;
      };
    };

  outputs = { self, nixpkgs, utils, npmlock2nix, ... }@inputs:
    let
      # this export a lib with the override
      __functor = _: { system }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          npmlock2nix' = import npmlock2nix { inherit pkgs; };
        in
        import ./nix/purs-nix system inputs pkgs npmlock2nix';
    in
    { inherit __functor; } // utils.apply-systems
      {
        inherit inputs;
        # TODO remove systems limited by the test
        systems = [ "x86_64-linux" ];
      }
      ({ system, ... }@ctx:
        let
          package-set = import ./nix/package-set/generate.nix ctx.pkgs;
        in
        {
          packages.package-set = package-set;
        });
}
