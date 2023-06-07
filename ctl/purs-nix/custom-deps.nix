# this is a purs-nix overlay (not nixpkgs overlay)
package-set-repo: inputs: pkgs: npmlock2nix: self: super: with self;
let
  # FIXME we should rely on node_modules from ctl-scaffhold
  node_modules = npmlock2nix.v1.node_modules { src = inputs.ctl; };
in
{
  cardano-transaction-lib = {
    # TODO find a way to reuse ctl to build cardano-transaction-lib overlay
    #  it seems that we'll need a purs-nix api change for that
    #  also applies to other inputs
    #src = ctl;
    src.git = {
      inherit (inputs.ctl) rev;
      repo = "https://github.com/Plutonomicon/cardano-transaction-lib.git";
    };
    info = {
      foreign = node_modules;
      version = "5.0.0";
      dependencies = [
        aeson
        aff
        aff-promise
        aff-retry
        affjax
        argonaut
        argonaut-codecs
        arraybuffer-types
        arrays
        avar
        bifunctors
        bigints
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
        math
        maybe
        medea
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
        undefined
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
  aeson = {
    src.git = {
      repo = "https://github.com/mlabs-haskell/purescript-aeson.git";
      rev = "bfd8f4dcd0522a076320f9dc710c24817438e02e";
    };
    info = {
      foreign = node_modules;
      dependencies = [
        aff
        argonaut
        argonaut-codecs
        argonaut-core
        arrays
        bifunctors
        bigints
        bignumber
        const
        control
        effect
        either
        exceptions
        foldable-traversable
        foreign-object
        integers
        lists
        maybe
        mote
        numbers
        ordered-collections
        partial
        prelude
        quickcheck
        record
        sequences
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

  bignumber = {
    src.git = {
      repo = "https://github.com/mlabs-haskell/purescript-bignumber.git";
      rev = "705923edd892a3397b90d28ce7db9a7181dcd599";
    };
    info = {
      foreign = node_modules;
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

  sequences = {
    src.git = {
      repo = "https://github.com/hdgarrood/purescript-sequences";
      rev = "1f1d828ef30070569c812d0af23eb7253bb1e990";
    };
    info = {
      dependencies =
        [
          arrays
          self."assert"
          console
          effect
          lazy
          maybe
          newtype
          nonempty
          partial
          prelude
          profunctor
          psci-support
          quickcheck
          quickcheck-laws
          tuples
          unfoldable
          unsafe-coerce
        ];
    };
  };

  properties = {
    src.git = {
      repo = "https://github.com/Risto-Stevcev/purescript-properties.git";
      rev = "ddcad0f6043cc665037538467a2e2e4173ef276a";
    };
    info = {
      dependencies = [ prelude console ];
    };
  };

  lattice = {
    src.git = {
      repo = "https://github.com/Risto-Stevcev/purescript-lattice.git";
      rev = "aebe3686eba30f199d17964bfa892f0176c1742d";
    };
    info = {
      dependencies = [ prelude console properties ];
    };
  };

  mote = {
    src.git = {
      repo = "https://github.com/garyb/purescript-mote.git";
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

  medea = {
    src.git = {
      repo = "https://github.com/juspay/medea-ps.git";
      rev = "8b215851959aa8bbf33e6708df6bd683c89d1a5a";
    };
    info = {
      dependencies =
        [
          aff
          argonaut
          arrays
          bifunctors
          control
          effect
          either
          enums
          exceptions
          foldable-traversable
          foreign-object
          free
          integers
          lists
          maybe
          mote
          naturals
          newtype
          node-buffer
          node-fs-aff
          node-path
          nonempty
          ordered-collections
          parsing
          partial
          prelude
          psci-support
          quickcheck
          quickcheck-combinators
          safely
          spec
          strings
          these
          transformers
          typelevel
          tuples
          unicode
          unordered-collections
          unsafe-coerce
        ];
    };
  };

  purescript-toppokki = {
    src.git = {
      repo = "https://github.com/firefrorefiddle/purescript-toppokki";
      ref = "mike/browserpages";
      inherit (inputs.toppokki) rev;
    };
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

  noble-secp256k1 = {
    src.git = {
      repo = "https://github.com/mlabs-haskell/purescript-noble-secp256k1.git";
      rev = "710c15c48c5afae5e0623664d982a587ff2bd177";
    };
    info = {
      foreign = node_modules;
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
          # FIXME remove missing Data.UInt workaround
          uint
          # /endworkaround
        ];
    };
  };
}
