{
  description = "Go Template";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            go
            gopls
          ];

          buildInputs = with pkgs; [ ];
        };

        packages.default = pkgs.stdenv.mkDerivation rec {
          name = "go-template";
          src = ./.;

          nativeBuildInputs = with pkgs; [
            go
          ];

          buildInputs = with pkgs; [ ];

          buildPhase = ''
            export HOME=$(mktemp -d) # Go needs access to the home directory. So we make a temp directory and set the home to it's path.
            go build -o ${name}
          '';

          installPhase = ''
            cp ${name} $out
          '';
        };
      }
    );
}
