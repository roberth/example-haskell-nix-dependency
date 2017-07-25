{ pkgs ? import <nixpkgs> {} }:

let
  hlib = pkgs.haskell.lib;

  filterHaskellSource = builtins.filterSource (path: type: type != "unknown" 
		     && baseNameOf path != ".git"
                     && baseNameOf path != "dist"
                     && builtins.match "result.*" (baseNameOf path) == null);


  inherit (pkgs) hello;

  myHaskellPackages = pkgs.haskellPackages.override {
    overrides = self: super: {


      it-depends = hlib.overrideCabal (
                            hlib.overrideSrc (self.callPackage ./it-depends/package.nix {}) {
                              src = filterHaskellSource ./it-depends;
                            }
                   ) (old: {
        postConfigure = ''
          substituteInPlace src/Configuration.hs --replace 'helloPrefix = Nothing' 'helloPrefix = Just "${pkgs.hello}"'
        '';
      });


    };
  };

  shell-env = (hlib.addBuildDepends myHaskellPackages.it-depends [hello]).env;

in {
  inherit (myHaskellPackages) it-depends;
  inherit shell-env;
}
