{ pkgs, ... }:

{
  home.packages = [ 
    pkgs.git
    pkgs.zsh 
    pkgs.zsh-powerlevel9k
    pkgs.nix-zsh-completions
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
      "EDITOR" = "vim";
    };
    initExtra = "source ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme";
    shellAliases = {
      "cfgcd" = "cd ~/.config/nixpkgs";
      "cfgbh" = "home-manager build";
      "cfgsh" = "home-manager build";
      "cfgt" = "sudo nixos-rebuild test";
      "cfgs" = "sudo nixos-rebuild switch";
    };
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

  #xsession = {
  #  enable = true;

  #  #pointerCursor = {
  #  #  name = "Vanilla-DMZ";
  #  #  size = 64;
  #  #};
  #};
}

