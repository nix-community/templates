{
  description = "Nix Community Templates";

  outputs = { self }: {
    templates = rec {
      empty = { path = ./empty; description = "Empty Template"; };
      rust = { path = ./rust; description = "Rust Template"; };
      zig = { path = ./zig; description = "Zig Template"; };
      go = { path = ./go; description = "Go Template"; };
      python = { path = ./python; description = "Python Template"; };
      haskell = { path = ./haskell; description = "Haskell Template"; };
      flutter = { path = ./flutter; description = "Flutter Template"; };
    };
  };
}
