{...}: {
  programs.qylock = {
    enable = true;
    theme = "terraria"; # Quickshell lockscreen theme
    sddmTheme = "terraria"; # optional: also sets services.displayManager.sddm.theme
    sddmThemeFonts = [ ../../fonts/Andy-Bold.ttf ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    settings.Theme = { 
      CursorTheme = "breeze_cursors";
      CursorSize = 24;
    };
  };
}
