## .nixfiles/modules/home-manager/alacritty.nix
{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = lib.mkForce "DepartureMono Nerd Font";
        };
        size = lib.mkForce 11.25;
      };
    };
  };
}
