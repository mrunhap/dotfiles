{ config, pkgs, ...}:

{
  home.packages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.caffeine
    gnomeExtensions.pop-shell
  ];

  # gtk = {
  #   enable = true;

  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };

  #   theme = {
  #     name = "palenight";
  #     package = pkgs.palenight-theme;
  #   };

  #   cursorTheme = {
  #     name = "Numix-Cursor";
  #     package = pkgs.numix-cursor-theme;
  #   };

  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #   gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };
  # };

  # dconf.settings = {

  # };

  # home.sessionVariables.GTK_THEME = "palenight";
}
