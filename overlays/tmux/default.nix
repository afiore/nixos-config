
self: super:
{
  tmuxThemes = with self; super.callPackage ./themes.nix {};
}
