{
  description = "A very basic flake";

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
    packages.${system}.default = pkgs.buildNpmPackage {
      name = "dgang";
      version = "0.1.0";
      src = ./.;
      packageJSON = ./package.json;
      npmDepsHash = "sha256-AWSrIstiQhz2wPb3T7Vn0uvpJ5EQf5uyHl0pA3Bntnk=";
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
