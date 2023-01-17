{ lib, inputs, nixpkgs, home-manager, nixgl, emacs-overlay, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ emacs-overlay.overlay ];
    config.allowUnfree = true;
  };
in
{
  server = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs; };
    modules = [
      ./home.nix
      ./server.nix
      {
        home.username = "root";
        home.homeDirectory = "/root";
      }
    ];
  };

  pacman = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = { inherit inputs nixgl; };
    modules = [
      ./home.nix
      ./pacman.nix
      {
        home.username = "liubo";
        home.homeDirectory = "/home/liubo";
      }
    ];
  };
}