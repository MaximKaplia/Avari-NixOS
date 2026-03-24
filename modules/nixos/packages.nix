# .nixfiles/modules/nixos/packages.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      bitwarden-desktop
      obs-studio
      qbittorrent
      lutris
      winetricks
      mangohud
      alsa-scarlett-gui
      # KDE ----------------------------
      kdePackages.dolphin
      kdePackages.ark
      kdePackages.gwenview
      kdePackages.filelight
      ### ------------------------------
      rofi
      fuzzel
      swaylock
      swaybg
      waybar
      xwayland-satellite
      # System -----------------------
      ntfs3g
      mission-center
      nh
      # Creation ---------------------
      blender
  ];

  # Install firefox
    programs.firefox.enable = true;

    # Install steam
    programs.steam.enable = true;

  #Flake path for nh  - nix helper
      environment.sessionVariables = {
      NH_FLAKE = "/home/avari/.nixfiles";
    };


    # Fix Dolphin not recognizing apps
    # This creates the symlink WITHOUT installing plasma-workspace as a package
  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";


    # Davinci AMD - Laptop
    environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      mesa.opencl # Enables Rusticl (OpenCL) support
      ];
    };
}

