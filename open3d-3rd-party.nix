{ stdenv, lib, git, tree, unzip, fetchurl, fetchFromGitHub }:
stdenv.mkDerivation {
  name = "open3d-3rd-party";

  srcs = [
    (fetchurl {
      url = "https://anaconda.org/intel/mkl-include/2020.1/download/linux-64/mkl-include-2020.1-intel_217.tar.bz2";
      name = "mkl-include";
      sha256 = "0qgb757q0xskbavazf6zyfjma7i14b3344dr27c854dac7rfgi60";
    })
    (fetchurl {
      url = "https://anaconda.org/intel/mkl-static/2020.1/download/linux-64/mkl-static-2020.1-intel_217.tar.bz2";
      name = "mkl-static";
      sha256 = "0n9xrs6w9850g8k8n0xfqv53xwh00xl1pzbhgkz6g2awi7x61zj4";
    })
    (fetchurl {
      url = "https://github.com/intel-isl/Open3D/releases/download/v0.10.0/linux-merged-mkl-static-2020.1-intel_217.zip";
      name = "mkl-merged";
      sha256 = "0r00hsb4sxp1z0wzk0mnq5vqhli67jwyryp5vfg4fm65i46jnz02";
    })
    (fetchFromGitHub {
      owner = "wjakob";
      repo = "tbb";
      rev = "141b0e310e1fb552bdca887542c9c1a8544d6503";
      sha256 = "0v7dlpfcpmd7b6ha29k4lwgyki6ikbpcqr5z2rmynba1lzspykzl";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "assimp";
      repo = "assimp";
      rev = "v5.0.1";
      sha256 = "0qwbnw30yw9ddkgdx7f7xx78lsfj6s2nxkb8jp3l73ndaxkcwqkh";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "intel-isl";
      repo = "filament";
      rev = "13ad8e25289cb173a4f8e71e85cb4e0d026eacdc";
      sha256 = "1pq7cfws4k8havcb589mw8smwgl3hnkw7ignrmw8n0s2wp2zjgnv";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "junha-l";
      repo = "faiss";
      rev = "954ada2cc1106bd8f20c0f99bff615e36c0053b1";
      sha256 = "0csz159ld544ds8fc0wfn7b4kivz6x8gygs7di6dlqfwdbrg6qbz";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "philbinj";
      repo = "fastann";
      rev = "1f65a4d1f683ff53d933505014eb45b051a875b3";
      sha256 = "1ywr8hh12yjdg2qmb847y6j1k8xnkgzanf82ra6305pkap83pf58";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "nvmd";
      repo = "libkdtree";
      rev = "c83b033f498ae8eaa0459e280e54e96b517e401f";
      sha256 = "0nycgrnwf1yr2gmrd9xlpms37v9kz2h955j9znp22yssasbs54f3";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "mariusmuja";
      repo = "flann";
      rev = "1d04523268c388dabf1c0865d69e1b638c8c7d9d";
      sha256 = "1s726xxqdacg4a8qhp2mdyw76nxln43l0nn1bgaahj3qm4ay4p47";
      fetchSubmodules = true;
    })
    (fetchFromGitHub {
      owner = "xianyi";
      repo = "OpenBLAS";
      rev = "v0.3.10";
      sha256 = "174id98ga82bhz2v7sy9yj6pqy0h0088p3mkdikip69p9rh3d17b";
      fetchSubmodules = true;
    })
  ];

  phases = [ "installPhase" ];
  
  installPhase = ''
    mkdir $out
    echo $srcs
    set -- $srcs
    cp $1 $out/mkl-include-2020.1-intel_217.tar.bz2
    shift
    cp $1 $out/mkl-static-2020.1-intel_217.tar.bz2
    shift
    cp $1 $out/linux-merged-mkl-static-2020.1-intel_217.zip
    shift
    cp -r $1 $out/tbb
    shift
    cp -r $1 $out/assimp
    shift
    cp -r $1 $out/filament
    shift
    cp -r $1 $out/faiss
    shift
    cp -r $1 $out/fastann
    shift
    cp -r $1 $out/libkdtree
    shift
    cp -r $1 $out/flann
    shift
    cp -r $1 $out/openblas
  '';
}
