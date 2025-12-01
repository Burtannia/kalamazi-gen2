{
  description = "A Haskell project";

  inputs.hix.url = "github:tek/hix?ref=0.9.1";

  outputs = {hix, ...}: hix.lib.flake {
    hackage.versionFile = "ops/version.nix";

    cabal = {
      license = "BSD-2-Clause-Patent";
      license-file = "LICENSE";
      author = "James Burton";
      ghc-options = ["-Wall"];
    };

    language = "GHC2024";

    packages.kalamazi-gen2 = {
      src = ./.;
      cabal.meta.synopsis = "A Haskell project";

      library = {
        enable = true;
        dependencies = [
          "containers"
          "text"
          "time"
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
