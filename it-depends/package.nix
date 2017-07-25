{ mkDerivation, base, filepath, process, stdenv }:
mkDerivation {
  pname = "it-depends";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base filepath process ];
  description = "Example of calling a Nix dependency from a Haskell package";
  license = "unknown";
}
