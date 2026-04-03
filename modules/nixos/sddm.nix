#.nixfiles/modules/nixos/sddm.nix
{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      #compositor = "weston";
    };
    enableHidpi = true;
    extraPackages = with pkgs; [
      superHot-sddm
    ];
    
    theme = "SuperHotLogin"; #points to the actual themes directory
    settings.Theme = {
      TypeWriterSpeed = 15;
      MaxLoginAttempts = 3; 
      CursorTheme = "breeze_cursors";
      CursorSize = 24;
    };
  };

  environment.systemPackages = with pkgs; [
    superHot-sddm
  ];
}