{
  description = "Flake file to create Dotnet projects";

  inputs = {

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nixpkgs.url = "nixpkgs/nixos-22.11";

    # 22.05 works:  
    # nixpkgs.url = "nixpkgs/nixos-22.05";

    # Unstable doesn't work
    # nixpkgs.url = "nixpkgs/nixos-unstable"

  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (with dotnetCorePackages; combinePackages [
              dotnet-sdk
              dotnetPackages.Nuget
            ])
          ];
        };
      });
}
