{
  description = "nixy managed packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    gke-gcloud-auth-plugin.url = "path:./packages/gke-gcloud-auth-plugin";
    github-nix-community-neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, github-nix-community-neovim-nightly-overlay, gke-gcloud-auth-plugin }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in rec {
          atuin = pkgs.atuin;
          awscli = pkgs.awscli;
          bash = pkgs.bash;
          bat = pkgs.bat;
          bun = pkgs.bun;
          cargo = pkgs.cargo;
          clippy = pkgs.clippy;
          delta = pkgs.delta;
          direnv = pkgs.direnv;
          entr = pkgs.entr;
          eza = pkgs.eza;
          fd = pkgs.fd;
          fzf = pkgs.fzf;
          gh = pkgs.gh;
          glow = pkgs.glow;
          graphite-cli = pkgs.graphite-cli;
          kubectx = pkgs.kubectx;
          kubernetes-helm = pkgs.kubernetes-helm;
          nix-direnv = pkgs.nix-direnv;
          nodejs = pkgs.nodejs;
          python3 = pkgs.python3;
          ripgrep = pkgs.ripgrep;
          rustfmt = pkgs.rustfmt;
          starship = pkgs.starship;
          terminal-notifier = pkgs.terminal-notifier;
          uv = pkgs.uv;
          vhs = pkgs.vhs;
          zellij = pkgs.zellij;
          zplug = pkgs.zplug;
          gke-gcloud-auth-plugin = inputs.gke-gcloud-auth-plugin.packages.${system}.default;
          neovim = inputs.github-nix-community-neovim-nightly-overlay.packages.${system}.neovim;

          default = pkgs.buildEnv {
            name = "nixy-env";
            paths = [
              atuin
              awscli
              bash
              bat
              bun
              cargo
              clippy
              delta
              direnv
              entr
              eza
              fd
              fzf
              gh
              glow
              graphite-cli
              kubectx
              kubernetes-helm
              nix-direnv
              nodejs
              python3
              ripgrep
              rustfmt
              starship
              terminal-notifier
              uv
              vhs
              zellij
              zplug
              gke-gcloud-auth-plugin
              neovim
            ];
            extraOutputsToInstall = [ "man" "doc" "info" ];
          };
        });
    };
}
