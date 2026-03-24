{
  pkgs,
  inputs,
  ...
}: {
  # install package
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];
}
