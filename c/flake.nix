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

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    }:
    # For more information about the C/C++ infrastructure in nixpkgs: https://nixos.wiki/wiki/C
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      pname = "hello-world"; #package name
      version = "0.0.1";
      src = ./.;
      buildInputs = with pkgs; [
        # add library dependencies here i.e.
        #zlib
        # Tipp: you can use `nix-locate foo.h` to find the package that provides a header file, see https://github.com/nix-community/nix-index
      ];
      nativeBuildInputs = with pkgs; [
        # add build dependencies here
        ## For mesonbuild:
        #meson ninja
        ## For cmake:
        #cmake
        ## For autotools:
        # autoconf-archive
        # autoreconfHook
        pkg-config
        # clangd language server.
        # Also start your IDE/editor from the shell provided by `nix develop` as the wrapped clangd from clang-tools needs environment variables set by the shell
        #clang-tools
      ];
    in
    {
      devShells.default = pkgs.mkShell {
        inherit buildInputs nativeBuildInputs;

        # You can use NIX_CFLAGS_COMPILE to set the default CFLAGS for the shell
        #NIX_CFLAGS_COMPILE = "-g";
        # You can use NIX_LDFLAGS to set the default linker flags for the shell
        #NIX_LDFLAGS = "-L${lib.getLib zstd}/lib -lzstd";
      };

      # Pinned gcc: remain on gcc10 even after `nix flake update`
      #default = pkgs.mkShell.override { stdenv = pkgs.gcc10Stdenv; } {
      #  inherit buildInputs nativeBuildInputs;
      #};

      # Clang example:
      #default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
      #  inherit buildInputs nativeBuildInputs;
      #};

      packages.default = pkgs.stdenv.mkDerivation {
        inherit buildInputs nativeBuildInputs pname version src;
      };
    });
}
