{ fetchgit
, pkgs
}:

{
  tmuxThemepack = pkgs.tmuxPlugins.mkDerivation {
    pluginName = "tmux-themepack";
    src = fetchgit {
      url = "https://github.com/jimeh/tmux-themepack";
      rev = "1b1b8098419daacb92ca401ad6ee0ca6894a40ca";
      sha256 = "07nbfpghydwidvpd4xm0qzrw52nnkiv42h4ckpnzc19jf1k481ba";
    };
  };
}

