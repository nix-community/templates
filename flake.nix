{
  description = "Nix Community Templates";

  outputs = { self }: {
    templates = rec {
      rust.path = ./rust;
      go.path = ./go;
    };
  };
}
