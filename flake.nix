{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        rendercanvas = pkgs.python3Packages.buildPythonPackage {
          pname = "rendercanvas";
          version = "v2.2.1";
          format = "pyproject";
          nativeBuildInputs = with pkgs.python3Packages; [
            flit-core
            sniffio
          ];
          src = pkgs.fetchFromGitHub {
            owner = "pygfx";
            repo = "rendercanvas";
            rev = "v2.2.1";
            sha256 = "sha256-Wtil5SKMnL3SkbqWHU3hHKz73D+ZQtQUG06mSb6JE08=";
          };
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            just
            poetry
            python3
            python313Packages.wgpu-py
            rendercanvas
          ];
        };
      }
    );
}
