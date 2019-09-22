
self: super:
{
  lensesCli = with self; super.callPackage ./build.nix {};
}
