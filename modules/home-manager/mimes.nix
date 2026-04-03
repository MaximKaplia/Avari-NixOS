#.nixfiles/modules/home-manager/mimes.nix
{...}: {
  # Enable XDG MIME handling
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = "org.kde.kate.desktop";
      "text/x-csrs" = "org.kde.kate.desktop";

      "text/nix" = "codium.desktop";
      #"text/x-c" = "codium.desktop";
      "text/x-c++" = "codium.desktop";
      "text/x-python" = "codium.desktop";
      "text/x-java" = "codium.desktop";
      "text/javascript" = "codium.desktop";
      "text/x-cmake" = "codium.desktop";
      "text/markdown" = "codium.desktop";
      "application/x-shellscript" = "codium.desktop";
      "application/x-docbook+xml" = "codium.desktop";
      "application/x-yaml" = "codium.desktop";
      "application/json" = "codium.desktop";
      "application/xml" = "codium.desktop";

      "applications/pdf" = "firefox.desktop";
      "image/*" = "org.kde.gwenview.desktop";
      "audio/*" = "org.kde.haruna.desktop";
      "audio/mpeg" = "org.kde.haruna.desktop";
      "audio/flac" = "org.kde.haruna.desktop";
      "video/png" = "org.kde.haruna.desktop";
      "video/jpg" = "org.kde.haruna.desktop";
      "video/*" = "org.kde.haruna.desktop";
      "video/mp4" = "org.kde.haruna.desktop";
      "scene/blend" = "blender.desktop";
      "application/x-bittorrent" = "org.qbittorrent.qBittorrent.desktop";
      "inode/directory" = "org.kde.dolphin.desktop";
    };
  };
}
