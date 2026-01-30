{
  description = "nixy managed packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-a1bab9e4.url = "github:NixOS/nixpkgs/a1bab9e494f5f4939442a57a58d0449a109593fe";
    nixpkgs-bce5fe2b.url = "github:NixOS/nixpkgs/bce5fe2bb998488d8e7e7856315f90496723793c";
    gke-gcloud-auth-plugin.url = "path:./packages/gke-gcloud-auth-plugin";
    github-nix-community-neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    github-max-sixty-worktrunk.url = "github:max-sixty/worktrunk";
  };

  outputs = { self, nixpkgs, github-max-sixty-worktrunk, github-nix-community-neovim-nightly-overlay, gke-gcloud-auth-plugin, nixpkgs-a1bab9e4, nixpkgs-bce5fe2b }@inputs:
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
          jujutsu = pkgs.jujutsu;
          kubectx = pkgs.kubectx;
          kubernetes-helm = pkgs.kubernetes-helm;
          nix-direnv = pkgs.nix-direnv;
          python3 = pkgs.python3;
          ripgrep = pkgs.ripgrep;
          rustfmt = pkgs.rustfmt;
          starship = pkgs.starship;
          terminal-notifier = pkgs.terminal-notifier;
          terraform = pkgs.terraform;
          uv = pkgs.uv;
          vhs = pkgs.vhs;
          zellij = pkgs.zellij;
          zplug = pkgs.zplug;
          buf = inputs.nixpkgs-a1bab9e4.legacyPackages.${system}.buf;
          nodejs = inputs.nixpkgs-bce5fe2b.legacyPackages.${system}.nodejs_24;
          gke-gcloud-auth-plugin = inputs.gke-gcloud-auth-plugin.packages.${system}.default;
          neovim = inputs.github-nix-community-neovim-nightly-overlay.packages.${system}.neovim;
          worktrunk = inputs.github-max-sixty-worktrunk.packages.${system}.worktrunk;

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
              jujutsu
              kubectx
              kubernetes-helm
              nix-direnv
              python3
              ripgrep
              rustfmt
              starship
              terminal-notifier
              terraform
              uv
              vhs
              zellij
              zplug
              buf
              nodejs
              gke-gcloud-auth-plugin
              neovim
              worktrunk
            ];
            extraOutputsToInstall = [ "man" "doc" "info" ];
          };
        });
    };
}
