{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Avari";
        email = "avarifanter@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
