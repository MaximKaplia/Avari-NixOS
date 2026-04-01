# .nixfiles/pkgs/davinci-ffmpeg-encoder.nix
{
  stdenv,
  fetchFromGitHub,
  cmake,
  ffmpeg,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ffmpeg-encoder-plugin";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "EdvinNilsson";
    repo = "ffmpeg_encoder_plugin";
    tag = "v${finalAttrs.version}";
    hash = "sha256-F4Q8YCXD5UldTwLbWK4nHacNPQ/B+4yLL96sq7xZurM=";
  };

  nativeBuildInputs = [cmake ffmpeg];
  buildInputs = [ffmpeg];
  runtimeDependencies = [ffmpeg];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
    cp ffmpeg_encoder_plugin.dvcp $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
    runHook postInstall
  '';
})
