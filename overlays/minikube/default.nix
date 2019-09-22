
self: super:
{
  minikubeLatest = with self; super.callPackage ./0-35-0.nix {
    inherit (darwin.apple_sdk.frameworks) vmnet;
  };
}
