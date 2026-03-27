# .nixfiles/modules/nixos/packages.nix
{
  config,
  pkgs,
  ...
}: {
  # Install steam
  programs.steam.enable = true;

  # Enable flathub
  services.flatpak.enable = true;

  #Enable flathub repo
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  
  # Nvidia
  hardware.graphics.enable = true; # Opengl - can be omitted, comes with steam

  hardware.nvidia = {
    open = true;
    forceFullCompositionPipeline = false; #True if Tearing
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false; #may be unstable look into it
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  services.xserver.videoDrivers = ["nvidia"];

  # Boot
  boot.initrd.kernelModules = ["nvidia_drm" "nvidia_modeset" "nvidia" "nvidia_uvm"];
  boot.kernelParams = ["nvidia_drm.fbdev=1" "nvidia-drm.modeset=1"];

  environment.systemPackages = with pkgs; [
    protontricks
    protonup-qt
    vkbasalt
    winetricks
    wineWowPackages.stable
    ffmpeg-full # Video encoding/transcoding
    nvidia-vaapi-driver # VA-API/NVENC for OBS/Discord on NVIDIA
    cudaPackages.cudatoolkit # CUDA for advanced NVIDIA encoding/AI filters in OBS
    #libva-utils
    #vdpauinfo
    #vulkan-tools
    #vulkan-validation-layers
    #libvdpau-va-gl
    #egl-wayland
    #wgpu-utils
    #mesa
    #libglvnd
    #nvtop
    #nvitop
    #libGL
  ];

  # Open firewall ports for gaming + screen sharing/streaming
  networking.firewall = {
    allowedTCPPorts = [
      #80
      25565
      4445 # Minecraft
      4455 # OBS
      1935 # RTMPT
      443 # RTMPT/HTTPS
      27015
      27036 # Steam Remote Play / servers
      3478
      3479 # STUN/TURN for Discord/Steam P2P (screen sharing)
      5000
      5001 # Additional RTC for Discord video/audio
    ];
    allowedUDPPorts = [
      #80
      25565
      4445 # Minecraft
      1935 # RTMPT
      443 # RTMPT/HTTPS
      27015
      27031
      27036 # Steam
      3478
      3479 # STUN/TURN
      5000
      5001 # Discord RTC
    ];
  };
}
