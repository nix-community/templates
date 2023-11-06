{
  description = "C Template";

  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils, systems }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pname = "hello-world"; #package name
        version = "0.0.1";
        src = ./.;
        buildInputs = with pkgs; [
          gcc
        ];
        nativeBuildInputs = with pkgs; [ ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
          shellHook = ''
          '';
        };
        packages.default = pkgs.stdenv.mkDerivation {
          inherit buildInputs pname version src;
          buildPhase = ''
            mkdir -p $out/bin
            gcc main.c -o "$out/bin/${pname}"
          '';
        };

      });
}


