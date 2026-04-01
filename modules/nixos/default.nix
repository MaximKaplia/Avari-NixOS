# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./sddm.nix
    ./bootloader.nix
    ./noctalia.nix
    ./packages.nix
    ./UI-packages.nix
    ./stylix-system.nix
    ./EasyEffects.nix
    ./mounts.nix
  ];
}
