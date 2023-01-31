{ config, pkgs, inputs, nixgl, ... }:

{
  imports = [
    (import ../modules/app.nix)
    (import ../modules/emacs.nix)
    (import ../modules/fonts.nix)
    (import ../modules/git.nix)
    (import ../modules/programming.nix)
    (import ../modules/syncthing.nix)
    (import ../modules/terminal.nix)
    (import ../modules/zsh.nix)
    # (import ../modules/dropbox.nix)
  ];

  programs = {
  };

  home.sessionVariables = {
    GTK_IM_MODULE="fcitx5";
    XMODIFIERS="@im=fcitx5";
    QT_IM_MODULE="fcitx5";
  };
  home.file.".config/fcitx5/config".source = ../modules/files/fcitx5_config;
  home.file.".config/fcitx5/profile".source = ../modules/files/fcitx5_profile;

  home = {
    # See https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#Setting_keyboard_layout
    keyboard = {
      variant = "dvorak";
      options = [ "grp:caps_toggle" ];
    };

    packages = with pkgs; [
      (import nixgl { inherit pkgs; }).nixGLIntel
                                     #.nixVulkanIntel
    ];
  };
}
