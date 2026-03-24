# .nixfiles/modules/nixos/UI-packages.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # QT themes ----------------------
    kdePackages.breeze
    libsForQt5.breeze-icons
    kdePackages.breeze-icons
    kdePackages.qtsvg
    libsForQt5.qt5.qtsvg
    kdePackages.kio-extras
    kdePackages.kio
    kdePackages.kded
    kdePackages.kde-gtk-config
    kdePackages.kservice
    kdePackages.kcmutils
    kdePackages.ffmpegthumbs
    ffmpegthumbnailer
    # Portals --------------------------
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
  ];

  environment.pathsToLink = [
    "/share/themes"
    "/share/icons"
    "/share/qt5ct"
    "/share/qt6ct"
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde # for QT file picker
      xdg-desktop-portal-gnome # For screen sharing
      xdg-desktop-portal-gtk # Fallback
    ];

    configPackages = [pkgs.kdePackages.xdg-desktop-portal-kde];

    config = {
      common = {
        default = "kde";
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };

      # Niri-specific overrides
      niri = {
        default = [
          "kde" # Keep KDE for most things
          "gnome" # Add GNOME as fallback
        ];
        # Use GNOME for screen sharing
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
      };
    };
  };
}
