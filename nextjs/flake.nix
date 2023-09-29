{
  description = ''
    Run 'nix develop' to have a dev shell that has everything this project needs.
    Run `nix build` to build this project.
    Run `nix run` to run this project.
  '';

  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pname = "<same as package.json name>";
        version = "0.1.0";
        buildInputs = with pkgs; [
          nodejs_20
          openssl
          nodePackages_latest.pnpm
        ];
        nativeBuildInputs = buildInputs;
        npmDepsHash = "<prefetch-npm-deps package-lock.json>";
      in
      {
        devShell = pkgs.mkShell {
          inherit buildInputs;
          shellHook = ''
            #!/usr/bin/env bash
          '';
        };
        packages.default = pkgs.buildNpmPackage {
          inherit pname version buildInputs npmDepsHash nativeBuildInputs;
          src = ./.;
          postInstall = ''
            mkdir -p $out/bin
            exe="$out/bin/${pname}"
            lib="$out/lib/node_modules/${pname}"
            cp -r ./.next $lib
            touch $exe
            chmod +x $exe
            echo "
                #!/usr/bin/env bash
                cd $lib
                ${pkgs.nodePackages_latest.pnpm}/bin/pnpm run start" > $exe
          '';
        };
      });
}


