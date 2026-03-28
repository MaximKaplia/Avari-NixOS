## .nixfiles/modules/home-manager/packages-home.nix
{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
      userSettings = {
        # Nix LSP settings
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [ "alejandra" ];
            };

            "options" = {
            "nixos" = {
            "expr" = "(builtins.getFlake \"/home/avari/.nixfiles\").nixosConfigurations.avari.options";
               };
               "home_manager" = {
                 "expr" = "(builtins.getFlake \"/home/avari/.nixfiles\").homeConfigurations.avari.options";
               };
             };
          };
        };
      };
      };
    };

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
      btop-rocm
      ungit
# Nix Formatting ---------------
      nixd
      alejandra
#Nix Search TV ------------------
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
