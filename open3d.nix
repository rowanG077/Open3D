{ stdenv, lib, callPackage, clang, tree, cudnn, xorg, libGLU, SDL2, libcxx, libcxxabi, ninja
, libudev, python, ipywidgets, widgetsnbextension, notebook, numpy, cmake, nasm
, git, fetchFromGitHub, zlib, vulkan-loader, vulkan-headers, eigen, flann, nanoflann
, fmt, glew, glfw}:

let
  third-party = callPackage ./open3d-3rd-party.nix { };
in stdenv.mkDerivation {
  name = "open3d";

  src = ./.;

  # Hack in the original source for now.
  # once we have this working
  # cleanup and upstream.
  # src = fetchFromGitHub {
  #   owner = "intel-isl";
  #   repo = "Open3D";
  #   rev = "v0.12.0";
  #   sha256 = "0pzxc8j3fr9vk05zpymqznw5ycnvp2c4gh3c6ra359aqyjjfk3yj";
  #   fetchSubmodules = true;
  # };

  cmakeFlags = [
    "-DCPP_LIBRARY=${libcxx}/lib/libc++.so"
    "-DCPPABI_LIBRARY=${libcxxabi}/lib/libc++abi.so"

    "-DTHIRD_PARTY_DOWNLOAD_DIR=${third-party}"    
    "-DBUILD_FILAMENT_FROM_SOURCE=1"

    "-DVULKAN_INCLUDE_DIR=${vulkan-headers}/include/vulkan"
    "-DVULKAN_LIBRARY=${vulkan-loader.out}/lib/libvulkan.so"

    "-DNANOFLAN_INCLUDE_DIR=${nanoflann}/include"
    "-DUSE_SYSTEM_EIGEN3=1"
    "-DUSE_SYSTEM_FLANN=1"
    "-DUSE_SYSTEM_FMT=1"
    "-DUSE_SYSTEM_GLEW=1"
    "-DUSE_SYSTEM_GLFW=1"
  ];

  buildInputs = [
    cmake
    git
    cudnn
    clang
    eigen
    flann
    fmt
    glew
    glfw
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrandr
    xorg.libX11
    xorg.libXi
    xorg.libXext
    libGLU
    SDL2
    libcxx
    libcxxabi
    nasm
    # ninja
    libudev
    # py deps
    ipywidgets
    widgetsnbextension
    notebook
    numpy
  ];
}
