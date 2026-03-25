#.nixfiles/modules/nixos/sddm.nix
{
  pkgs,
  inputs,
  ...
}: let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura"; # Change to pixel_sakura
    # Optional: Customize further
    # themeConfig = {
    #   Background = "path/to/your/custom/background.png";
    #   Font = "Your Font Name";
    #   FontSize = "11";
    # };
  };
in {
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      compositor = "weston";
    };
    enableHidpi = true;
    extraPackages = with pkgs; [
      custom-sddm-astronaut
    ];

    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        CursorTheme = "breeze_cursors";
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    custom-sddm-astronaut
    kdePackages.qtmultimedia # For video/GIF backgrounds
  ];
  # reference - https://github.com/VoidKeishi/nixos-config/blob/main/modules%2Fsddm.nix#L1-L34
}
