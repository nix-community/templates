{
  description = "Nix Community Templates";

  outputs = {self}: let
    mkWelcomeText = {
      name,
      description,
      path,
      buildTools ? null,
      additionalSetupInfo ? null,
    }: {
      inherit path;

      description = name;

      welcomeText = ''
        # ${name}
        ${description}

        ${
          if buildTools != null
          then ''
            Comes bundled with:
            ${builtins.concatStringsSep ", " buildTools}
          ''
          else ""
        }
        ${
          if additionalSetupInfo != null
          then ''
            ## Additional Setup
            To set up the project run:
            ```sh
            flutter create .
            ```
          ''
          else ""
        }
        ## Other tips
        If you use direnv run:

        ```
            echo "use flake" > .envrc
        ```

        For a quick license setup use licensor:

        ```
            # SPDX is the license id like MIT or GPL-3.0
            nix-shell -p licensor --command "licensor SPDX > LICENSE"
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
          "All essential rust tools"
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
          "zig"
          "zls"
        ];
      };
      gleam = mkWelcomeText {
        path = ./gleam;
        name = "Gleam template";
        description = ''A basic Gleam project'';
        buildTools = [
          "gleam"
          "erlang_27"
        ];
      };
      go = mkWelcomeText {
        path = ./go;
        name = "Go template";
        description = "A basic go project";
        buildTools = [
          "go"
          "gopls"
        ];
      };
      python = mkWelcomeText {
        path = ./python;
        name = "Python Template";
        description = ''
          A basic python project
        '';
        buildTools = [
          "python310"
        ];
      };
      haskell = mkWelcomeText {
        path = ./haskell;
        name = "Haskell Template";
        description = ''
          A basic haskell project with cabal
        '';
        buildTools = [
          "cabal"
          "ghc"
          "haskell-language-server"
        ];
      };
      flutter = mkWelcomeText {
        path = ./flutter;
        name = "Flutter Template";
        description = ''
          A flutter project template that comes bundled
        '';
      };
      nextjs = mkWelcomeText {
        path = ./nextjs;
        name = "NextJS Template";
        description = ''
          A basic NextJS application template with a package build.
        '';
        buildTools = [
          "nodejs"
          "pnpm"
        ];
      };
      c = mkWelcomeText {
        path = ./c;
        name = "C Template";
        description = ''
          A basic C application template with a package build.
          Lots of comments to help you configure it to your liking.
        '';
        buildTools = [
          "gcc"
        ];
      };
    };
  };
}
