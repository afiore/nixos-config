{ fetchurl
, pkgs
, stdenv
}:

{
  idea-community = pkgs.jetbrains.idea-community.overrideAttrs (old: rec {
    version = "2018.3.1";
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
      sha256 = "1zi4aib1h4jfn241gsg83jsqfj99fpbci4pkh8xarap6xrallyiq";
    };
  });
}


