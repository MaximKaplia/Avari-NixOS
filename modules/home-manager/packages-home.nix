## .nixfiles/modules/home-manager/packages-home.nix
{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
      haruna
      mpv
      sqlite
      vesktop
      obsidian
      rofi
      rofimoji
      copyq # clipboard manager
     # Terminal -----------------------
      alacritty
      fastfetch
      oxipng
      tree
      vim
      cmake
      ninja
      yt-dlp
      python315
      wget
      btop
      ungit
      #Nix Search TV
      (pkgs.writeShellApplication {
    name = "ns";
    runtimeInputs = with pkgs; [
      fzf
      nix-search-tv
    ];
    text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    checkPhase = "";
  })
  ];
}
