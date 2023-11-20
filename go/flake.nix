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

        packages.default = pkgs.buildGoModule rec {
          name = "template";
          src = ./.;

          buildInputs = with pkgs; [ ];

          vendorHash = null;
        };
      }
    );
}
