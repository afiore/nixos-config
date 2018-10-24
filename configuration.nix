# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan..
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams=["acpi_rev_override=1"];

  # consider enabling to get more recent stuff
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = ["nouveau"];

  hardware.bumblebee = {
    enable = true;
    driver = "nvidia";
  };

  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
     enableGoogleTalkPlugin = true;
    };
    packageOverrides = pkgs: rec {
      jre = pkgs.oraclejre8;
      neovim = (import ./vim.nix);
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "antanix"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  system.autoUpgrade.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     pciutils htop
     # utils:
     p7zip keepassxc openconnect oathToolkit
     # build tools
     binutils gcc gnumake openssl openssl.dev pkgconfig
     # dev
     git neovim
     # web
     wget curl firefoxWrapper google-chrome
     # x11
     xorg.xcursorthemes
     # fonts
     source-code-pro fontconfig-ultimate
     # scala
     sbt ammonite                                          
     # rustlang
     rustup cargo
     # window manager
     i3lock i3status xorg.xbacklight networkmanagerapplet xsel xclip maim
     # productivity
     slack zoom-us google-drive-ocamlfuse
     # shell
     rxvt_unicode_with-plugins urxvt_font_size urxvt_theme_switch
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    terminal = "xterm-256color";
    shortcut = "a";
    clock24 = true;
    extraTmuxConf = ''
set-option -g renumber-windows on
    '';
  };


  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [
    pkgs.vaapiIntel
    pkgs.libvdpau-va-gl
    pkgs.vaapiVdpau
    pkgs.intel-ocl
    pkgs.linuxPackages.nvidia_x11.out
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = ["modesetting"];

    libinput = {
      enable = true;
      naturalScrolling = true;
    };

    xkbOptions = "eurosign:e";

    layout = "gb";
    monitorSection = ''
      DisplaySize 406 228
    '';

    desktopManager = {
      xterm.enable = false;
      default = "none";
      plasma5.enable = true;
    };

    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
      };
    };

    displayManager.slim = {
      enable = true;
      defaultUser = "andrea";
    };

    dpi = 168;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ source-code-pro ];
    fontconfig.dpi = 168;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.andrea = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["wheel" "docker" "networkmanager"];
    shell = pkgs.zsh;
  };

  
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
