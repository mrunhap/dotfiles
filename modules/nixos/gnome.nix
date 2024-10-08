{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  options.my.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf config.my.gnome.enable {
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
    # gnome system tray, with addindicator
    services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    programs.dconf.enable = true;

    home-manager.users.${user} = {
      my.gnome.enable = true;
      my.gtk.enable = true;
    };
  };
}
