let
  pkgs = import <nixpkgs> {};
  open3d = pkgs.python38Packages.callPackage ./open3d.nix { };
in
pkgs.mkShell {
  name = "hello-2.1.1";
  buildInputs = [ open3d ];
}
