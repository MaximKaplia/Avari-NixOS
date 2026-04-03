# .nixfiles/pkgs/qylock-sddm.nix
{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gst_all_1,
  kdePackages,
  
}: 
  stdenvNoCC.mkDerivation rec {
    pname = "superHot-sddm";
    version = "";

    src = fetchFromGitHub {
      owner = "0larszl0";
      repo = "SuperHotLogin";
      rev = "b15202c1acc9b8de73f81c903ca892c07291501c";
      sha256 = "sha256-JwP0ND11O3b8OXqfFuh7q5nz06C/pkXxTVO82nwR2Vg=";
    };

    dontWrapQtApps = true;

    # Use kdePackages (Qt6) just like astronaut theme does
    propagatedBuildInputs = with kdePackages; [
    qtmultimedia
    qtdeclarative
    qtsvg
  ] ++ (with gst_all_1; [
    gst-plugins-good
    gst-libav
    #gst-plugins-base
    #gst-plugins-bad
    #gst-plugins-ugly
  ]);

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/SuperHotLogin

      runHook postInstall
    '';
  }
