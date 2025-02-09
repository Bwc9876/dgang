{
  description = "dgang flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flakelight,
  }:
    flakelight ./. {
      pname = "dgang";
      inherit inputs;
      formatters = {
        "*.nix" = "alejandra .";
        "*.{js,ts,astro,json,yml}" = "prettier --write .";
      };
      package = pkgs: let
        src = ./.;
      in
        pkgs.buildNpmPackage {
          name = "dgang";
          version = "0.1.0";
          inherit src;
          packageJSON = ./package.json;
          npmDeps = pkgs.importNpmLock {
            npmRoot = src;
          };
          npmConfigHook = pkgs.importNpmLock.npmConfigHook;
          installPhase = "cp -r dist/ $out";
          nativeBuildInputs = with pkgs; [d2];
          ASTRO_TELEMETRY_DISABLED = 1;
        };
      devShell = pkgs:
        pkgs.mkShell {
          packages = with pkgs; [
            d2
            nodejs
            nodePackages.prettier
            alejandra
          ];
        };
    };
}
