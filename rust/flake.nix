{
  description = "Rust Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        nativeBuildInputs = with pkgs; [
          rust-bin.stable.latest.default
          rust-analyzer
        ];

        buildInputs = with pkgs; [];
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};

        packages.default = pkgs.rustPlatform.buildRustPackage rec {
          name = "projectname"; # Same that is in Cargo.toml
          src = ./.;
          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          inherit buildInputs;
        };
      }
    );
}
