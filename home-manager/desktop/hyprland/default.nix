{
  lib,
  config,
  pkgs,
  flake-inputs,
  ...
}: {
  imports = [
    ./ags.nix
    ../../wezterm

    # https://github.com/gmodena/nix-flatpak#infinte-recusion-in-home-manager-imports
    flake-inputs.hyprlock.homeManagerModules.hyprlock
    flake-inputs.hypridle.homeManagerModules.hypridle
  ];

  # A notification daemon
  services.dunst.enable = true;

  # launcher
  programs.bemenu.enable = true;

  home.file.".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
  home.file.".local/share/icons/Bibata-Modern-Ice".source = ./Bibata-Modern-Ice;

  home.packages = with pkgs; [
    # clipboard for wayland, also needed by other tools like hyprpicker
    # to paste color to clipboard
    # provide command: wl-copy, wl-paste
    wl-clipboard

    # switch to application or run it
    wlrctl

    # screenshot
    grim slurp

    hyprpaper
    hyprpicker
    hyprcursor

    # voice control
    pavucontrol

    # network manager on tray
    networkmanagerapplet

    # bluetooth manager
    blueberry

    # cursor theme for x
    bibata-cursors
  ];


  programs.hyprlock = {
    enable = true;
    general.disable_loading_bar = true;
    backgrounds = [{
      monitor = "";
      path = "$HOME/Pictures/wall.png";
      color = "rgba(25, 20, 20, 1.0)";
      blur_passes = 1;
      blur_size = 0;
      brightness = 0.8;
    }];
    labels = [{
      monitor = "";
      text = ''$TIME Hi <i><span foreground="##ff2222">$USER</span></i> :)'';
      font_size = 70;
      position = {
        x = 0;
        y = 80;
      };
      valign = "center";
      halign = "center";
    }];
  };
  services.hypridle = {
    enable = true;
    beforeSleepCmd = "loginctl lock-session";
    afterSleepCmd = "hyprctl dispatch dpms on";
    ignoreDbusInhibit = true;
    lockCmd = "pidof hyprlock || hyprlock";
    listeners = [
      {
        timeout = 300;
        onTimeout = "loginctl lock-session";
      }
      {
        timeout = 1800;
        onTimeout = "systemctl suspend";
      }
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        # Fix cursor don't show with Nvidia card
        "WLR_NO_HARDWARE_CURSORS,1"

        # hyprcursor
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,32"
        "XCURSOR_THEME,Bibata-Modern-Ice"
        "XCURSOR_SIZE,32"
      ];

      exec-once = [
        "hyprctl setcursor Bibata-Modern-Ice 32"

        # status bar
        "ags -b hypr"
        "nm-applet --indicator"

        # input method
        "fcitx5 -d"

        # auto mount usb
        "udiskie &"

        # wallpaper
        "hyprpaper"

        # others
        "hypridle"
        "emacs --daemon"
      ];

      monitor = [
        "DP-2,3840x2160@144,1440x0,1.5,bitdepth,10"
        "DP-3,3840x2160,0x0,1.5,transform,1"
        "HDMI-A-2,preferred,1440x2440,auto,transform,3"
        "HDMI-A-1,disable"
      ];

      workspace = [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:HDMI-A-2"
        "10, monitor:HDMI-A-2"
      ];

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "pavucontrol")
        (f "bluetooth")
        (f "nm-connection-editor")
        (f "org.gnome.Settings")
        (f "org.gnome.design.Palette")
        (f "Color Picker")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gnome")
        (f "qbittorrent")
        (f "com.github.Aylur.ags")
        "noblur,^(?!emacs$|wezterm|fuzzel$).*$"
      ] ++ [
        "float, title:(emacs-run-launcher)"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "dvorak";
        follow_mouse = 1;
        repeat_rate = 60;
        repeat_delay = 150;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };
      };

      gestures = {
        workspace_swipe = "on";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        layers_hog_keyboard_focus = true;
        disable_splash_rendering = true;
      };

      decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      };

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        mvw = binding "SUPER SHIFT" "movewindow";
        arr = [1 2 3 4 5 6 7 8 9];
      in
        [
          # launcher
          "SUPER, D, exec, bemenu-run -i --fn 'Sarasa Gothic SC 20'"

          # application (hyprctl clients | grep class)
          "SUPER, Return, exec, wlrctl window focus org.wezfurlong.wezterm || wezterm"
          "SUPER, B, exec, wlrctl window focus firefox || firefox"
          "SUPER, E, exec, wlrctl window focus emacs || emacs"

          # lock screen
          "SUPER, L, exec, hyprlock --immediate -q"

          # screenshot
          "SUPER_SHIFT, 4, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          " , Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          # hyprland
          "ALT, Tab, focuscurrentorlast"
          "SUPER, Q, killactive"
          "SUPER, F, togglefloating"
          "SUPER, G, fullscreen"
          "SUPER, O, fakefullscreen"
          "SUPER, P, togglesplit"

          (mvw "h" "l")
          (mvw "s" "r")
          (mvw "t" "u")
          (mvw "n" "d")
          (mvfocus "h" "l")
          (mvfocus "s" "r")
          (mvfocus "t" "u")
          (mvfocus "n" "d")
          (ws "left" "e-1")
          (ws "right" "e+1")
          (mvtows "left" "e-1")
          (mvtows "right" "e+1")
          (resizeactive "n" "0 -20")
          (resizeactive "t" "0 20")
          (resizeactive "s" "20 0")
          (resizeactive "h" "-20 0")
          (mvactive "n" "0 -20")
          (mvactive "t" "0 20")
          (mvactive "s" "20 0")
          (mvactive "h" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];
    };
  };
}