#.nixfiles/modules/home-manager/mimes.nix
{...}: {
  # Enable XDG MIME handling
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;

      # Default apps for double-clicking
      defaultApplications = {
        "inode/directory" = [
          "dolphin.desktop"
          "org.kde.dolphin.desktop"
        ];
        "text/plain" = [
          "org.kde.kate.desktop"
        ];
      };

      # Additional apps in "Open With" menu
      associations = {
        added = {
          "text/plain" = [
            "org.kde.kate.desktop"
          ];

          "inode/directory" = [
            "dolphin.desktop"
            "org.kde.dolphin.desktop"
          ];
        };
      };
    };
  };
}
