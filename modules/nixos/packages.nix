# .nixfiles/modules/nixos/packages.nix
{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    qbittorrent
    gparted
    colmapWithCuda
    alsa-scarlett-gui
    # KDE ----------------------------
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.filelight
    kdePackages.kdialog
    ### ------------------------------
    rofi
    swaylock
    swaybg
    waybar
    unstable.xwayland-satellite
    # System -----------------------
    nh
    # Audio --------------------------
    playerctl
    # Creation ---------------------
    blender
    #Audio -------------------------
    pulseaudio
    pavucontrol
  ];

  # Install firefox
  programs.firefox.enable = true;

  #Flake path for nh  - nix helper
  environment.sessionVariables = {
    NH_FLAKE = "/home/avari/.nixfiles";
  };

  # Fix Dolphin not recognizing apps
  # This creates the symlink WITHOUT installing plasma-workspace as a package
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
