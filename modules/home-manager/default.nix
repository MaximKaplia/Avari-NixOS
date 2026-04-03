{
  # List your module files here
  # my-module = import ./my-module.nix;
  imports = [
    ./git.nix
    ./yazi.nix
    ./UI-home.nix
    ./mimes.nix
    ./packages-home.nix
    ./gaming-home.nix
    ./configs-home.nix
    ./lazyvim.nix
  ];
}
