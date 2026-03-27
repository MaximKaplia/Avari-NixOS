#.nixfiles/overlays/default.nix
# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    blender =
      (prev.blender.override {
        cudaSupport = true;
      }).overrideAttrs (oldAttrs: {
        version = "5.0.1";
        src = final.fetchzip {
          url = "https://download.blender.org/source/blender-5.0.1.tar.xz";
          hash = "sha256-fNnQRfGfNc7rbk8npkcYtoAqRjJc6MaV4mqtSJxd0EM=";
        };
      });
    obs-studio = prev.obs-studio.override {
      cudaSupport = true;
      browserSupport = true;
      scriptingSupport = true;
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system; # was final.system
      config.allowUnfree = true;
    };
  };

  # Adds the emacs overlay - reference how to enable overlays (also has to be enabled in home.nix)
  # emacs = inputs.emacs-overlay.overlays.default;

}
