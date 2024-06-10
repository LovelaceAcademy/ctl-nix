# this is a purs-nix overlay (not nixpkgs overlay)
system: inputs: pkgs: npmlock2nix: self: super: with self;
let
  inherit (pkgs.lib.attrsets) recursiveUpdate;
  # FIXME we should rely on node_modules from ctl-scaffhold
  node_modules_ = npmlock2nix.v2.node_modules {
    inherit (pkgs) nodejs;
    src = inputs.ctl;
    githubSourceHashMap = {
      Fourierlabs.cardano-serialization-lib-gc.fcb15e03ffb30d3a63133a7c7a447b2a6d461b09 = "1zyy1nxbby4wcl30rc8fsis1c3f7nafavnwd3qi4bg0x00gxjdnh";
    };
  };
  node_modules = node_modules_ + /node_modules;
  ffi = { inherit node_modules; };
  purs-nix = inputs.purs-nix { inherit system; };
  inherit (purs-nix) build;
in
{
  cardano-transaction-lib = build {
    name = "cardano-transaction-lib";
    # TODO find a way to reuse ctl to build cardano-transaction-lib overlay
    #  it seems that we'll need a purs-nix api change for that
    #  also applies to other inputs
    src.path = inputs.ctl;
    info = {
      version = "7.0.0";
      foreign = {
        # TODO get all .js files and use their paths to generate foreigns
        #  command used `grep -rl --include "*.js" import src/ | xargs -I _ sh -c "S=_; grep module \${S/js/purs} | cut -d ' ' -f2"`
        #  command used for nested dependencies `spago install && grep -rl --include "*.js" import .spago/ | xargs -I _ sh -c "S=_; grep -H module \${S/js/purs}"`
        "Ctl.Internal.BalanceTx.UtxoMinAda" = ffi;
        "Ctl.Internal.Deserialization.FromBytes" = ffi;
        "Ctl.Internal.Deserialization.Keys" = ffi;
        "Ctl.Internal.Deserialization.Language" = ffi;
        "Ctl.Internal.Deserialization.NativeScript" = ffi;
        "Ctl.Internal.Deserialization.PlutusData" = ffi;
        "Ctl.Internal.Deserialization.Transaction" = ffi;
        "Ctl.Internal.Deserialization.UnspentOutput" = ffi;
        "Ctl.Internal.Plutip.PortCheck" = ffi;
        "Ctl.Internal.Plutip.Spawn" = ffi;
        "Ctl.Internal.Plutip.Utils" = ffi;
        "Ctl.Internal.QueryM.UniqueId" = ffi;
        "Ctl.Internal.Serialization.Address" = ffi;
        "Ctl.Internal.Serialization.AuxiliaryData" = ffi;
        "Ctl.Internal.Serialization.BigInt" = ffi;
        "Ctl.Internal.Serialization.Hash" = ffi;
        "Ctl.Internal.Serialization.MinFee" = ffi;
        "Ctl.Internal.Serialization.NativeScript" = ffi;
        "Ctl.Internal.Serialization.PlutusData" = ffi;
        "Ctl.Internal.Serialization.PlutusScript" = ffi;
        "Ctl.Internal.Serialization.WitnessSet" = ffi;
        "Ctl.Internal.Types.BigNum" = ffi;
        "Ctl.Internal.Types.ByteArray" = ffi;
        "Ctl.Internal.Types.Int" = ffi;
        "Ctl.Internal.Types.TokenName" = ffi;
        "Ctl.Internal.Wallet.Cip30.SignData" = ffi;
        "Ctl.Internal.Wallet.Bip32" = ffi;
        "Ctl.Internal.Affjax" = ffi;
        "Ctl.Internal.ApplyArgs" = ffi;
        "Ctl.Internal.Hashing" = ffi;
        "Ctl.Internal.JsWebSocket" = ffi;
        "Ctl.Internal.Serialization" = ffi;
      };

      dependencies = [
        aeson
        aff
        aff-promise
        aff-retry
        affjax
        ansi
        argonaut
        argonaut-codecs
        arraybuffer-types
        arrays
        avar
        bifunctors
        js-bigints
        bignumber
        checked-exceptions
        console
        control
        crypto
        datetime
        debug
        effect
        either
        encoding
        enums
        exceptions
        foldable-traversable
        foreign
        foreign-object
        formatters
        functions
        gen
        heterogeneous
        http-methods
        identity
        integers
        js-date
        lattice
        lists
        maybe
        media-types
        monad-logger
        mote
        newtype
        noble-secp256k1
        node-buffer
        node-child-process
        node-fs
        node-fs-aff
        node-path
        node-process
        node-readline
        node-streams
        nonempty
        now
        numbers
        optparse
        ordered-collections
        orders
        parallel
        partial
        posix-types
        prelude
        profunctor
        profunctor-lenses
        purescript-toppokki
        quickcheck
        quickcheck-combinators
        quickcheck-laws
        random
        rationals
        record
        refs
        safe-coerce
        spec
        spec-quickcheck
        strings
        stringutils
        tailrec
        these
        transformers
        tuples
        typelevel
        typelevel-prelude
        uint
        unfoldable
        untagged-union
        variant
        web-html
        web-storage
      ];
    };
  };

  # additional packages for CTL
  # TODO: automate the set generation using CTL input
  # pinned to match ctl arg
  aeson = build {
    name = "aeson";
    src.git = {
      repo = "https://github.com/mlabs-haskell/purescript-aeson.git";
      # v2.0.0 rev
      rev = "4fddd518a143de563299d484272a0ef18daa7dcd";
    };
    info = {
      foreign.Aeson = ffi;
      dependencies = [
        aff
        argonaut
        argonaut-codecs
        argonaut-core
        arrays
        bifunctors
        const
        control
        effect
        either
        exceptions
        foldable-traversable
        foreign-object
        integers
        js-bigints
        lists
        maybe
        mote
        numbers
        ordered-collections
        partial
        prelude
        quickcheck
        record
        spec
        strings
        tuples
        typelevel
        typelevel-prelude
        uint
        untagged-union
      ];
    };
  };

  bigints = build (recursiveUpdate super.bigints {
    name = "bigints";
    info.foreign."Data.BigInt" = ffi;
  });

  bignumber = build {
    name = "bignumber";
    src.git = {
      repo = "https://github.com/mlabs-haskell/purescript-bignumber.git";
      rev = "760d11b41ece31b8cdd3c53349c5c2fd48d3ff89";
    };
    info = {
      foreign."Data.BigNumber" = ffi;

      dependencies = [
        console
        effect
        either
        exceptions
        functions
        integers
        partial
        prelude
        tuples
        # FIXME remove missing Data.UInt workaround
        uint
        # /endworkaround
      ];
    };
  };

  properties = {
    src.git = {
      repo = "https://github.com/Risto-Stevcev/purescript-properties.git";
      # v0.2.0
      rev = "ddcad0f6043cc665037538467a2e2e4173ef276a";
    };
    info = {
      dependencies = [ prelude console ];
    };
  };

  lattice = {
    src.git = {
      repo = "https://github.com/Risto-Stevcev/purescript-lattice.git";
      # v0.3.0
      rev = "aebe3686eba30f199d17964bfa892f0176c1742d";
    };
    info = {
      dependencies = [ prelude console properties ];
    };
  };

  mote = {
    src.git = {
      repo = "https://github.com/garyb/purescript-mote.git";
      # v3.0.0
      rev = "29aea4ad7b013d50b42629c87b01cf0202451abd";
    };
    info = {
      dependencies = [
        these
        transformers
        arrays
      ];
    };
  };

  purescript-toppokki = build {
    name = "purescript-toppokki";
    src.path = inputs.toppokki;
    info = {
      dependencies = [
        prelude
        record
        functions
        node-http
        aff-promise
        node-buffer
        node-fs-aff
      ];

      foreign =
        let
          # Missing in CTL, but available in ctl-scaffold
          p = pkgs.mkYarnModules {
            pname = "toppokki-node_modules";
            version = inputs.toppokki.shortRev;
            yarnLock = inputs.toppokki + /yarn.lock;
            packageJSON = inputs.toppokki + /package.json;
          };
          ffi = [
            "Toppokki"
          ];
          node_modules = p + /node_modules;
        in
        pkgs.lib.attrsets.genAttrs ffi (_: { inherit node_modules; });
    };
  };

  noble-secp256k1 = build {
    name = "noble-secp256k1";
    src.path = inputs.noble-secp256k1;
    info = {
      foreign = {
        "Noble.Secp256k1.Schnorr" = ffi;
        "Noble.Secp256k1.ECDSA" = ffi;
      };
      dependencies =
        [
          aff
          aff-promise
          effect
          prelude
          spec
          tuples
          unsafe-coerce
          # FIXME remove missing Data.ArrayBuffer.Types workaround
          arraybuffer-types
          # /endworkaround
        ];
    };
  };
  js-bigints = build {
    name = "js-bigints";
    src.path = inputs.js-bigints;
    info = {
      dependencies =
        [
          integers
          maybe
          prelude
        ];
    };
  };
}
