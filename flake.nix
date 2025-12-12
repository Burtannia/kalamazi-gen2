{
  description = "A Haskell project";

  inputs = {
    hix = {
      url = "github:tek/hix?ref=0.9.1";
      inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs =
    { hix, ... }:
    let
      compiler = "ghc912";
    in
    hix.lib.flake {
      inherit compiler;

      hackage.versionFile = "ops/version.nix";

      ghcVersions = [
        compiler
      ];

      haskellTools =
        ghc: with ghc; [
          fourmolu
        ];

      envs.dev = {
        hls.enable = true;
      };

      cabal = {
        license = "BSD-2-Clause-Patent";
        license-file = "LICENSE";
        author = "James Burton";
        language = "GHC2024";

        ghc-options = [
          "-fhide-source-paths"
          "-Wall"
          "-Wcompat"
          "-Widentities"
          # "-Wimplicit-prelude"
          "-Wredundant-constraints"
          "-Wmissing-export-lists"
          "-Wpartial-fields"
          "-Wmissing-deriving-strategies"
          "-Wunused-packages"
          "-Winvalid-haddock"
          "-Wredundant-bang-patterns"
          "-Woperator-whitespace"
          "-Wredundant-strictness-flags"
          "-O2"
        ];

        default-extensions = [
          "BlockArguments"
          "DataKinds"
          "DefaultSignatures"
          "DeriveAnyClass"
          "DerivingStrategies"
          "DuplicateRecordFields"
          "FunctionalDependencies"
          "GADTs"
          "ImportQualifiedPost"
          "LambdaCase"
          "MultiWayIf"
          "OverloadedRecordDot"
          "OverloadedStrings"
          "PartialTypeSignatures"
          "PatternSynonyms"
          "QuasiQuotes"
          "TemplateHaskell"
          "TypeFamilies"
          "TypeFamilyDependencies"
        ];
      };

      packages.kalamazi-gen2 = {
        src = ./.;
        cabal.meta.synopsis = "A Haskell project";

        library = {
          enable = true;
          dependencies = [
            "containers"
            "text"
            "time"
            "network-uri"
            "uuid"
            "aeson"
          ];
        };

        executable.enable = true;

        test = {
          enable = true;
          dependencies = [
            "hedgehog >= 1.1 && < 1.5"
            "tasty ^>= 1.4"
            "tasty-hedgehog >= 1.3 && < 1.5"
          ];
        };

      };
    };
}
