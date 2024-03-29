{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  server = home-manager.lib.homeManagerConfiguration {
    inherit (nixpkgs) lib;
    inherit pkgs;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ./home.nix
      ./server.nix
      ./editor
      ./develop
      ./shell
      ./syncthing
      {
        home.username = "root";
        home.homeDirectory = "/root";
        programs.ssh.enable = true;
      }
    ];
  };

  pacman = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs;};
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
