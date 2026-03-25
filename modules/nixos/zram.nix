# .nixfiles/modules/nixos/zram.nix
{ config, pkgs, ... }:

{

zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 50;
  };


}

