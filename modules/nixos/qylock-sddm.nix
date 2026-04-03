{...}: {
  programs.qylock = {
    enable = true;
    theme = "minecraft"; # Quickshell lockscreen theme
    sddmTheme = "minecraft"; # optional: also sets services.displayManager.sddm.theme
    sddmThemeFonts = [ ../../fonts/minecraft.otf ];
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
