
self: super:
{
  minikubeLatest = with self; super.callPackage ./0-34-1.nix {
    inherit (darwin.apple_sdk.frameworks) vmnet;
  };
}
