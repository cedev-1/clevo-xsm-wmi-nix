{
  description = "clevo-xsm-wmi driver package";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.default = 
      pkgs.callPackage ./default.nix {
        kernelDev = pkgs.linuxPackages.kernel.dev;
        kernelVersion = pkgs.linuxPackages.kernel.version;
        kernelModDirVersion = pkgs.linuxPackages.kernel.modDirVersion;
      };
    
    overlays.default = final: prev: {
      clevo-xsm-wmi = 
        final.callPackage ./default.nix {
          kernelDev = final.linuxPackages.kernel.dev;
          kernelVersion = final.linuxPackages.kernel.version;
          kernelModDirVersion = final.linuxPackages.kernel.modDirVersion;
        };
    };
  };
}
