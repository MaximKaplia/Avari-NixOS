# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./keyboard-fix.nix
    # ./sddm.nix # - my sddm
    ./qylock-sddm.nix # qylock flake sddm
    ./bootloader.nix
    ./zram.nix
    ./noctalia.nix
    ./packages.nix
    ./gaming.nix
    ./UI-packages.nix
    ./stylix-system.nix
    ./EasyEffects.nix
    ./davinci-resolve.nix
    ./mounts.nix
  ];
}
