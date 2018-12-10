{ fetchgit
, pkgs
}:

{
  tmuxThemepack = pkgs.tmuxPlugins.mkDerivation {
    pluginName = "tmux-themepack";
    src = fetchgit {
      url = "https://github.com/jimeh/tmux-themepack";
      rev = "126150da5e89b262fec94dd7b3d8bcd0966646a9";
      sha256 = "0dwgpfjz4bbmizmr7fh73rhl121dmaq9s4pb9p9f3ccjlkm0i14d";
    };
  };
}

