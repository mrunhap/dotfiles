{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.my.dev;

in {
  options.my.dev = {
    enable = mkEnableOption "dev";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      protobuf

      # tag system
      universal-ctags global cscope

      # FIXME https://github.com/nix-community/nixd/issues/357
      # nixd
      nixfmt

      gcc gdb ccls

      clojure leiningen jdk

      nodejs-slim typescript deno
      nodePackages.npm nodePackages.pnpm
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      sassc # compile scss/sass to css

      pyright ruff pipx pdm
      (python3.withPackages (ps:
        with ps; [
          pip conda ipython debugpy requests pytest numpy
          jupyterlab notebook jupytext
          pygments # for gtags

          # lsp-bridge for emacs
          epc orjson sexpdata six setuptools paramiko rapidfuzz
        ]))

      gopls gotools go-tools delve gogetdoc
      impl gotests gomodifytags reftools godef
      protoc-gen-go protoc-gen-go-grpc
      wire

      sbcl
    ];

    programs.go = {
      enable = true;
      goPath = ".go";
    };

    home.sessionVariables = {
      GO111MODULE = "auto";
      GOPROXY = "https://goproxy.io,direct";
      GTAGSOBJDIRPREFIX = "$HOME/.cache/gtags/";
      GTAGSCONF = "$HOME/.globalrc";
      GTAGSLABEL = "native-pygments";
    };

    home.sessionPath = [
      "$GOPATH/bin"
    ];

    home.file.".globalrc".source = ../../../static/globalrc;
    # https://github.com/NixOS/nixpkgs/issues/225730
    home.file.".config/pdm/config.toml".text = ''
[venv]
backend = "venv"
'';

  };
}
