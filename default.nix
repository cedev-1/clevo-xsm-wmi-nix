{ lib, stdenv, fetchFromGitHub, kernelDev, kernelVersion, kernelModDirVersion }:

stdenv.mkDerivation {
  pname = "clevo-xsm-wmi";
  version = "git";
  
  src = fetchFromGitHub {
    owner = "quitesimpleorg";
    repo = "clevo-xsm-wmi-preserved";
    rev = "master";
    hash = "sha256-f1b4E5LrIPCoHx45HhBelsiueioo65OfqFuMk6HczR0=";
  };
  
  hardeningDisable = [ "pic" ];
  
  buildPhase = ''
    make -C module KDIR=${kernelDev}/lib/modules/${kernelModDirVersion}/build KVER=${kernelVersion}
  '';
  
  installPhase = ''
    make -C module KDIR=${kernelDev}/lib/modules/${kernelModDirVersion}/build KVER=${kernelVersion} INSTALL_MOD_PATH=$out install
  '';
}
