{
  lib,
  inputs,
  outputs,
  nixpkgs,
  home-manager,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  north = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs pkgs;};
    modules = [
      ./configuration.nix
      ./north
      ./nvidia
      ./fcitx5
      ./vsftpd
      ./desktop/hyprland.nix
      ./game
      # ./proxy
      ./virt

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        # see https://github.com/gmodena/nix-flatpak#notes-on-homemanager
        home-manager.extraSpecialArgs.flake-inputs = inputs;
        home-manager.users.mrunhap = {
          imports = [
            ./home.nix
            ../home-manager/browser
            ../home-manager/editor
            ../home-manager/font
            ../home-manager/develop
          ];
          home.username = "mrunhap";
          home.homeDirectory = "/home/mrunhap";
        };
      }
    ];
  };
}
