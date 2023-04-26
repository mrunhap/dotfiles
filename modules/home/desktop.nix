{ config, pkgs, ...}:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    lxgw-wenkai
    symbola
    sarasa-gothic
    source-han-serif
    roboto-mono
    ibm-plex
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    cardo
    #miss: monego wps-fonts bookerly latin-modern-mono
  ];
}