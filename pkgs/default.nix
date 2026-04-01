#.nixfile/pkgs/default.nix
# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  superHot-sddm = pkgs.callPackage ./superHot-sddm.nix {};

  # Davinci Package
  davinci-aac-codec = pkgs.callPackage ./davinci-aac-codec.nix { };
  davinci-ffmpeg-encoder = pkgs.callPackage ./davinci-ffmpeg-encoder.nix { };
  davinci-resolve-ffmpeg = pkgs.callPackage ./davinci-resolve-studio.nix { };
}
