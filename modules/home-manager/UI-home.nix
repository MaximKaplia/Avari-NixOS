# .nixfiles/modules/home-manager/UI-home.nix
{ config, lib, pkgs, ... }:

{

 home.packages = with pkgs; [
    # Cursors --------------------------
    capitaine-cursors
    # Icons -----------------------------
    papirus-icon-theme
    # GTK theme tools  ------------
    adw-gtk3
    nwg-look
    # Qt theme tools ---------------
    kdePackages.qt6ct
    libsForQt5.qt5ct
    # Notifications ------------------
    swaynotificationcenter # notification daemon
    libnotify # sends notifications
    # Screenshots ------------------
    #grim # taking screenshots
    #slurp # selecting screen regions
    wl-clipboard # clipboard
  ];

  #Screenshots
  programs.satty.enable = true;
  #Notification center
  services.swaync.enable = false;


  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    targets = {
        alacritty.enable = true;
        blender.enable = true;
        obsidian.enable = true;
        swaync.enable = true;
        mangohud.enable = true;
        btop.enable = true;
    };

  cursor = {
    package = pkgs.kdePackages.breeze;
    name = "breeze_cursors";
    size = 24;
  };

     fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "Caskaydia Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-sans;
        name = "Source Sans 3";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DeajaVu Serif";
    };
  };
};

 gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };


   # Qt configuration
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "qt6ct";
  };


 home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    GTK_USE_PORTAL = "1";
    #Screen Sharing on Niri
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "niri";
  };

}
