{
  description = "dgang flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system}.default = let
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
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        d2
        nodejs
      ];
    };
  };
}
