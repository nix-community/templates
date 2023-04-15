{
  description = "Nix Community Templates";

  outputs = { self }: {
    templates = rec {
      rust.path = ./rust;
      zig.path = ./zig;
      go.path = ./go;
      haskell.path = ./haskell;
    };
  };
}
