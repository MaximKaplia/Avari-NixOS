#.nixfiles/modules/nixos/sddm.nix
{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      ###compositor = "weston";
    };
    enableHidpi = true;
    extraPackages = with pkgs; [
      superHot-sddm
    ];
    #theme = #points to the actual themes directory
    theme = "SuperHotLogin";
    settings.Theme = {
      TypeWriterSpeed = 15; #ms
      MaxLoginAttempts = 3; 
      #CursorTheme = "breeze_cursors";
      #CursorSize = 24;
    };
  };

  environment.systemPackages = with pkgs; [
    superHot-sddm
    kdePackages.qtmultimedia # For video/GIF backgrounds (qt6)
  ];
  # reference - https://github.com/VoidKeishi/nixos-config/blob/main/modules%2Fsddm.nix#L1-L34
}
