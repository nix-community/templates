{
  description = "Nix Community Templates";

  outputs = { self }: {
    templates = rec {
      empty = {
        path = ./empty;
        description = "Empty Template";
        welcomeText = ''
          # Empty Template
          Just a simple flake to make setting up a development project with nix a little easier.

          ## More info
          - [flake-utils Github Page](https://github.com/numtide/flake-utils)
        '';
      };
      rust = {
        path = ./rust;
        description = "Rust Template";
        welcomeText = ''
          # Rust Template
          A basic rust application template with a package build.

          Comes bundled with cargo and rust-analyzer.

          ## More info
          - [rust-overlay Github Page](https://github.com/oxalica/rust-overlay)
          - [flake-utils Github Page](https://github.com/numtide/flake-utils)
        '';

      };
      zig = { path = ./zig; description = "Zig Template"; };
      go = { path = ./go; description = "Go Template"; };
      python = { path = ./python; description = "Python Template"; };
      haskell = { path = ./haskell; description = "Haskell Template"; };
      flutter = { path = ./flutter; description = "Flutter Template"; };
    };
  };
}
