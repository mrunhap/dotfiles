{ config, pkgs, ... }:

{
  services.emacs.enable = true;

  home.packages = with pkgs; [
    tdlib
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: with epkgs; [
      # (treesit-grammars.with-grammars (p: builtins.attrValues p))

      # packages
      lsp-bridge
      gruber-darker-theme
      tabnine
      acm-terminal
      popon
      eldoc-box
      citre
      aggressive-indent
      go-mode
      flymake-go-staticcheck
      go-gen-test
      go-tag
      go-dlv
      go-fill-struct
      go-impl
      gotest
      nix-mode
      clojure-mode
      cider
      clj-refactor
      visual-fill-column
      wgrep
      urgrep
      go-translate
      fanyi
      restclient
      leetcode
      d2-mode
      ob-d2
      websocket
      async-await
      markdown-mode
      gptel
      gpt-commit
      tabnine
      envrc
      ox-gfm
      ob-restclient
      ob-go
      org-appear
      valign
      toc-org
      htmlize
      org-variable-pitch
      org-download
      org-present
      citar
      magit
      magit-delta
      diff-hl
      dirvish
      eat
      w3m
      nerd-icons
      nerd-icons-ibuffer
      nerd-icons-completion
      telega
      org-static-blog
      xeft
      git-modes
      markdown-mode
      markdown-toc
      protobuf-mode
      csv-mode
      dired-toggle-sudo
      elpa-mirror
      bind
      gcmh
      fullframe
      hide-mode-line
      pinyinlib
      ace-window
      popper
      window-numbering
      switchy-window
      ibuffer-vc
      isearch-mb
      vertico
      marginalia
      consult
      orderless
      embark
      embark-consult
      consult-yasnippet
      consult-dir
      consult-eglot
      solaire-mode
      default-text-scale
      minions
      meow
      anzu
      separedit
      iscroll
      vundo
      symbol-overlay
      hl-todo
      ligature
      avy
      corfu
      popon
      corfu-terminal
      yasnippet
      devdocs
      imenu-list
      paredit
      puni
      dumb-jump
      apheleia
      rime
    ];
  };
}