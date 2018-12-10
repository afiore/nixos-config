{ fetchurl
, pkgs
, stdenv
}:

{
  idea-community = pkgs.jetbrains.idea-community.overrideAttrs (old: rec {
    version = "2018.3";
    src = fetchurl {
      url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
      sha256 = "01ccz5ksbv8xh8mnk3zxqpia8zgayy8bcgmbwqibrykz47y6r7yy"; 
    };
  });
}


