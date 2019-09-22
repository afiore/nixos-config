{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "lenses-cli-${version}";
  version = "2.3.5";

  src = fetchFromGitHub {
    owner = "Landoop";
    repo = "lenses-go";
    rev = "${version}";
    sha256 = "04kh2sf7id3vqgbav164fqg16n6ngxl10r25qlk64fksqg3kmp1v";
  };

  modSha256 = "11d6lrrcyb6zwb9pqzgkp94xqqzzyf8pfq0n9wxy70d42llfnwh7";

  meta = with lib; {
    description = "Cli that utilizes the REST and WebSocket APIs of Lenses to communicate with Apache Kafka";
    homepage = https://docs.lenses.io/dev/lenses-cli/index.html;
    license = licenses.apache;
    platforms = platforms.linux ++ platforms.darwin;
  };
}
