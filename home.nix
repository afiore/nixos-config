{ pkgs, ... }:

{
  home.packages = [ 
    # shell and terminal
    pkgs.alacritty
    pkgs.zsh 
    pkgs.zsh-powerlevel9k
    pkgs.nix-zsh-completions
    pkgs.zsh-completions
    pkgs.tmux

    # version control
    pkgs.git

    # wm / UI
    pkgs.i3
    pkgs.polybar

    # scala
    pkgs.sbt
    pkgs.ammonite

    # rustlang
    pkgs.rustup

    #editor
    pkgs.python36Packages.neovim
    pkgs.evince

    # Dev tools
    pkgs.jq
    pkgs.docker_compose
    pkgs.postman
    pkgs.awscli
    pkgs.ripgrep
    pkgs.exa
    pkgs.universal-ctags
    pkgs.ranger
    pkgs.pgcli

    # productivity
    pkgs.slack
    pkgs.zoom-us
    pkgs.google-drive-ocamlfuse
    pkgs.dropbox
  ];

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
      "EDITOR" = "nvim";
    };
    initExtra = ''
      # set vi mode
      bindkey -v
      export KEYTIMEOUT=1
      bindkey "^R" history-incremental-search-backward

      setopt autocd autopushd pushdignoredups

      # init prompt
      source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme


      export PATH=$PATH:$HOME/.cargo/bin

      # set default terminal i3
      export TERMINAL=alacritty
    '';
    shellAliases = {
      "cfgcd" = "cd ~/.config/nixpkgs";
      "cfgbh" = "home-manager -I nixpkgs=channel:nixpkgs-unstable build";
      "cfgsh" = "home-manager -I nixpkgs=channel:nixpkgs-unstable switch";
      "cfgt" = "sudo nixos-rebuild test";
      "cfgs" = "sudo nixos-rebuild switch";
      "cfgeh" = "cfgcd && $EDITOR home.nix";
      "cfge" = "cfgcd && $EDITOR configuration.nix";
      "l" = "exa --long --git --group --colour-scale";
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
  #  signing = {
  #    key = "me@yrashk.com";
  #    signByDefault = true;
  #  };
  };

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  manual.manpages.enable = true;

  home.stateVersion = "18.09";


  #xsession = {
  #  enable = true;
  #  command = "${pkgs.i3}/bin/i3";

  #  #pointerCursor = {
  #  #  name = "Vanilla-DMZ";
  #  #  size = 64;
  #  #};
  #};
}

