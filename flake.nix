{
  description = "Nix Community Templates";

  outputs = {self}: let
    mkWelcomeText = {
      name,
      description,
      path,
      buildTools ? null,
      setupCommand ? "",
    }: {
      inherit path;

      description = name;

      welcomeText = ''
        # ${name}
        ${description}

        To set up the project run:
        ```sh
            ${setupCommand}
        ```

        ${
          if buildTools != null
          then ''
            Comes bundled with:
            ${builtins.concatStringsSep "\n" buildTools}
          ''
          else ""
        }

        ## Other tips
        If you use direnv run:
        ```sh
            echo "use flake" > .envrc
        ```

        For a quick license setup use licensor:
        ```sh
            # SPDX is the license id like MIT or GPL-3.0
            nix-shell -p licensor --command "licensor <SPDX> > LICENSE"
        ```

        ## More info
        - [flake-utils Github Page](https://github.com/numtide/flake-utils)
      '';
    };
  in {
    templates = {
      empty = mkWelcomeText {
        name = "Empty Template";
        description = ''
          A simple flake that provides a devshell
        '';
        path = ./empty;
      };
      rust = mkWelcomeText {
        path = ./rust;
        name = "Rust Template";
        description = ''
          A basic rust application template with a package build.
        '';
        buildTools = [
          "The full suite of tools provides by oxalica's [rust-overlay](https://github.com/oxalica/rust-overlay)"
          "rust-analyzer"
        ];
      };
      zig = mkWelcomeText {
        path = ./zig;
        name = "Zig Template";
        description = ''
          A basic Zig application template with a package build.
        '';
        buildTools = [
          "Zig"
          "The zig language server"
        ];
      };
      go = mkWelcomeText {
        path = ./go;
        name = "Go template";
        description = "A basic go project";
        buildTools = [
          "Go"
          "gopls language server"
        ];
        setupCommand = "go mod init";
      };
      python = {
        path = ./python;
        description = "Python Template";
      };
      haskell = {
        path = ./haskell;
        description = "Haskell Template";
      };
      flutter = {
        path = ./flutter;
        description = "Flutter Template";
      };
      nextjs = {
        path = ./nextjs;
        description = "NextJS Template";
        welcomeText = ''
          # NextJS Template
          A basic NextJS application template with a package build.

          Comes bundled with nodejs and pnpm.

          ## More info
          - [flake-utils Github Page](https://github.com/numtide/flake-utils)
        '';
      };
      c = {
        path = ./c;
        description = "C Template";
        welcomeText = ''
          # C Template
          A basic C application template with a package build.

          Comes bundled with gcc.

          ## More info
          - [flake-utils Github Page](https://github.com/numtide/flake-utils)
        '';
      };
    };
  };
}
