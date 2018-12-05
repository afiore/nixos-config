{ pkgs, ... }:

let
  polybar = pkgs.polybar.override {
    i3Support = true;
    wirelesstools = pkgs.wirelesstools;
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    mpd_clientlib = pkgs.mpd_clientlib;
  };
  dotfileDir = ./dotfiles;
  copyDir = path: {
    source = "${dotfileDir}/${path}";
    target = "./${path}";
    recursive = true;
  };
  copyDirs = base: paths: builtins.foldl' (h: p: h // { "${p}" = copyDir p; }) base paths;

in {
  home.packages = [ 
    # shell and terminal
    pkgs.alacritty
    pkgs.zsh 
    pkgs.zsh-powerlevel9k
    pkgs.nix-zsh-completions
    pkgs.zsh-completions
    pkgs.tmux
    pkgs.exa
    pkgs.ranger
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    pkgs.ncurses

    #pkgs.bat

    # version control
    pkgs.git

    # wm / UI
    pkgs.i3
    pkgs.mpd_clientlib
    polybar
    pkgs.rofi

    # scala
    pkgs.sbt
    pkgs.ammonite
    pkgs.jetbrains.idea-community

    # rustlang
    pkgs.rustup

    #editor
    pkgs.neovim
    pkgs.python36Packages.neovim

    # containers
    pkgs.docker_compose
    pkgs.minikube
    pkgs.kubectl

    # cloud services
    pkgs.awscli

    # Dev tools
    pkgs.jq
    pkgs.postman
    pkgs.universal-ctags
    # TODO: add pgcli1.6 (currently installed manually)

    # misc
    pkgs.languagetool
    pkgs.slack
    pkgs.zoom-us
    pkgs.google-drive-ocamlfuse
    pkgs.dropbox
    pkgs.xorg.libxshmfence
    pkgs.taskwarrior
    pkgs.evince
    pkgs.wirelesstools
  ];


  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    plugins = [];
    extraConfig = ''

unbind C-b
set -g prefix C-a
bind C-a send-prefix

set -g base-index 1
setw -g pane-base-index 1
set-option -g renumber-windows on

set -g default-terminal "screen-256color"

set-window-option -g mode-keys vi

set-window-option -g clock-mode-style 24
    '';
  };


  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      ignoreDups = true;
      share = true;
      save = 50000;
    };
    sessionVariables = {
      "TERM" = "xterm-256color";
      "EDITOR" = "${pkgs.neovim}/bin/nvim";
      "PAGER" = "bat";
      "TERMINAL" = "${pkgs.alacritty}/bin/alacritty";
      "FZF_DEFAULT_COMMAND" = "${pkgs.fd}/bin/fd --hidden --exclude .git";
      "FZF_CTRL_T_COMMAND" = "$FZF_DEFAULT_COMMAND";
    };
    initExtra = ''
      # set vi mode
      bindkey -v
      export KEYTIMEOUT=1
      # bindkey "^R" history-incremental-search-backward

      setopt autocd autopushd pushdignoredups

      # init prompt
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme

      # fzf setup

      source ${pkgs.fzf}/share/fzf/completion.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh

      export PATH=$PATH:$HOME/.cargo/bin
    '';
    shellAliases = {
      "vim" = "nvim";
      "cfgcd" = "cd ~/.config/nixpkgs";
      "cfgbh" = "home-manager -I nixpkgs=channel:nixpkgs-unstable build";
      "cfgsh" = "home-manager -I nixpkgs=channel:nixpkgs-unstable switch";
      "cfgt" = "sudo nixos-rebuild test";
      "cfgs" = "sudo nixos-rebuild switch";
      "cfgeh" = "cfgcd && $EDITOR home.nix";
      "cfge" = "cfgcd && $EDITOR configuration.nix";
      "l" = "exa --long --git --group --colour-scale";
      "i3cheatsheet" = "egrep ^bind ~/.config/i3/config | bat";
    };
    plugins = [
      {
        # will source nix-shell.plugin.zsh
        name = "zsh-colored-man-pages";
        file = "colored-man-pages.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "ael-code";
          repo = "zsh-colored-man-pages";
          rev = "master";
          sha256 = "158sbxrgk2j7ixdmhs63vjak5af8z75b1h1jsqa9h1ki3yrd5fk4";
        };
      }
    ];
  };
  

  programs.git = {
    enable = true;
    userName = "Andrea Fiore";
    userEmail = "andrea.giulio.fiore@gmail.com";
    aliases = {
      "st" = "status";
      "co" = "checkout";
      "br" = "branch";
    };
  };

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  manual.manpages.enable = true;

  home.stateVersion = "18.09";

  home.file = copyDirs {} [
    ".config/i3"
    ".config/polybar"
    ".config/alacritty"
    ".config/nvim"
    ".config/pgcli"
  ];
}
