{
  description = "nixy managed packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in rec {
          delta = pkgs.delta;
          starship = pkgs.starship;

          default = pkgs.buildEnv {
            name = "nixy-env";
            paths = [
              delta
              starship
            ];
            extraOutputsToInstall = [ "man" "doc" "info" ];
          };
        });
    };
}
