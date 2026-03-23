## .nixfiles/modules/home-manager/alacritty.nix
{ config, lib, pkgs, ... }:

{
 # programs.alacritty = {
    #enable = true;
    #settings = {
      #font = {
        #normal = { family = "DepartureMono Nerd Font"; };
        #size = 11.25;
      #};
    #};
  #;

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
