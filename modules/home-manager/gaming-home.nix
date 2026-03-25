# .nixfiles/modules/nixos/gaming-home.nix
{
  config,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };

  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      winetricks
    ];
  };

  programs.mangohud = {
    enable = true;
  };
}
