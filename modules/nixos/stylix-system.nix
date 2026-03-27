#.nixfiles/modules/nixos/stylix-system.nix
{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Color Schemes -----------------------------------------------
    base16-schemes
  ];
  ##Fonts------------------------------------------------------------
  ###  fc-cache -fv to reload font cache
  fonts.packages = with pkgs; [
    nerd-fonts.departure-mono
    nerd-fonts.caskaydia-cove
  ];
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/terracotta-dark.yaml";

    targets = {
      # grub.enable = true;
      # grub.useWallpaper = true;
      plymouth.enable = true;
      nixos-icons.enable = true;
      console.enable = true;
    };
  };
}
