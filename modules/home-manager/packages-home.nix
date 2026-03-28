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

# Fish shell ----------------------------------------------------------------------
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -U fish_greeting
      fastfetch
      # Bobthefish theme configuration
      set -g theme_nerd_fonts yes
      set -g theme_color_scheme dark
      set -g default_user Avari \udb84\udd05
      set -g theme_display_user

      # Prompt options
      set -g theme_display_jobs_verbose no

      # Virtual environment options
      set -g theme_display_nix yes

      # Right prompt
      set -g theme_display_date yes
      set -g theme_display_cmd_duration yes

      # Color Scheme

      ###set -g theme_color_scheme base16

    '';

    plugins = [
      # oh-my-fish plugins are stored in their own repositories, which
      # makes them simple to import into home-manager.
      {
        name = "theme-bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "c5efbe05aed81b201454c0ae1190ba91ea1970ac";
          sha256 = "1m98g825zjr3l2jr7gqh7glabaqrm0by9l2z5l4a9spjggixsrfp";
        };
      }
    ];
  };
  # ----------------------------------------------------------------------------------

  # Disable bobthefish greeting with an empty function
  home.file.".config/fish/functions/fish_greeting.fish".text = ''
    function fish_greeting
        # Empty function - disables the greeting
    end
  '';

  # Authentication agent service
  services.polkit-gnome.enable = true;
  services.gnome-keyring.enable = true;

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
