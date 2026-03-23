# .nixfiles/modules/nixos/EasyEffects.nix
{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [


    # Clean lsp-plugins (has hundreds of desktop files)
    (pkgs.symlinkJoin {
      name = "lsp-plugins-${pkgs.lsp-plugins.version}";
      paths = [ pkgs.lsp-plugins ];
      postBuild = ''
        rm -f $out/share/applications/in.lsp_plug.lsp_plugins*.desktop
      '';
    })
    calf  # Keep original calf (only has 1 desktop file)
    easyeffects
  ];
}
