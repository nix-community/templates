{
  description = "Flutter Template";

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
        pkgs = import nixpkgs {
          inherit system;
          config = {
            android_sdk.accept_license = true;
            allowUnfree = true;
          };
        };
        nativeBuildInputs = [
        ];

        buildInputs = [
          androidSdk
          pkgs.flutter
          pkgs.jdk11
        ];

        # Android config
        buildToolsVersion = "30.0.3";
        androidComposition = pkgs.androidenv.composeAndroidPackages {
          buildToolsVersions = [buildToolsVersion "28.0.3"];
          platformVersions = ["31" "28"];
          abiVersions = ["armeabi-v7a" "arm64-v8a"];
        };
        androidSdk = androidComposition.androidsdk;
      in {
        devShells.default = pkgs.mkShell {inherit nativeBuildInputs buildInputs;};
      }
    );
}
