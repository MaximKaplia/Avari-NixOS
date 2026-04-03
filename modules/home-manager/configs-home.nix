#.nixfiles/modules/home-manager/configs-home.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  base = "/home/avari/.nixfiles/configs";
  mkLink = path: config.lib.file.mkOutOfStoreSymlink "${base}/${path}";
in {
  home.file = {
    #files
    ".config/niri/config.kdl".source = mkLink "niri/config.kdl";
    #".config/niri/niri-modules/pop-animations.kdl".source = mkLink "niri/niri-modules/pop-animations.kdl";
    
     # symlink the entire niri-modules folder
    ".config/niri/niri-modules".source = mkLink "niri/niri-modules";
  };
}
