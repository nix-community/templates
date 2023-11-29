{
  description = "Python Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        python = pkgs.python310;

        nativeBuildInputs = with pkgs; [
          python
        ];

        buildInputs = with pkgs; [];
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};

        packages.default = python.pkgs.buildPythonApplication {
          pname = "template";
          version = "0.0.0";
          format = "setuptools";

          src = ./.;

          # True if tests
          doCheck = false;

          inherit nativeBuildInputs buildInputs;
        };
      }
    );
}
