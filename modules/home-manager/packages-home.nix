## .nixfiles/modules/home-manager/packages-home.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      userSettings = {
        # Nix LSP settings
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
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
        "nix.hiddenLanguageServerErrors" = [
          "unknown node type for definition"
          "Request textDocument/definition failed"
          "textDocument/definition"
          "definition failed"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    haruna
    mpv
    sqlite
    vesktop
    obsidian
    aseprite
    rofi
    obs-cmd
    #copyq # clipboard manager
    # Terminal -----------------------
    alacritty
    kitty
    fastfetch
    oxipng
    tree
    vim
    cmake
    ninja
    yt-dlp
    python315
    wget
    ungit
    neovim
    # Autocompletion -----------------
    unstable.alejandra
    unstable.nixd
    #Nix Search TV -------------------
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
