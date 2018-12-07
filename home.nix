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
  home.packages = with pkgs; [ 
    # shell and terminal
    alacritty
    ncurses
    zsh 
    zsh-powerlevel9k
    nix-zsh-completions
    zsh-completions
    tmux
    exa
    ranger
    ripgrep
    fzf
    fd
    fpp

    #bat

    # version control
    git

    # wm / UI
    i3
    mpd_clientlib
    polybar
    rofi

    # scala
    sbt
    ammonite
    jetbrains.idea-community

    # rustlang
    rustup

    #editor
    neovim
    python36Packages.neovim

    # containers
    docker_compose
    minikube
    kubectl

    # cloud services
    awscli

    # Dev tools
    jq
    postman
    universal-ctags
    # TODO: add pgcli1.6 (currently installed manually)

    # misc
    languagetool
    slack
    zoom-us
    google-drive-ocamlfuse
    dropbox
    xorg.libxshmfence
    taskwarrior
    evince
    wirelesstools
  ];


  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    plugins = with pkgs.tmuxPlugins; [
      yank
      sidebar
      fzf-tmux-url
      fpp
    ];
    extraConfig = ''

unbind C-b
set -g prefix C-a
bind C-a send-prefix

set -g base-index 1
setw -g pane-base-index 1
set-option -g renumber-windows on

bind-key -T prefix | split-window -h
bind-key -T prefix - split-window

source-file "$HOME/.config/tmux-themepack/powerline/block/cyan.tmuxtheme"

set -g default-terminal "screen-255color"

set-window-option -g mode-keys vi

set-window-option -g clock-mode-style 24
    '';
    tmuxp.enable = true;
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
    loginExtra = ''
      if [ -n "''${DISPLAY_TASKS+set}" ]
      then
        task long
      fi
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
    ".config/tmux-themepack"
  ];
}
