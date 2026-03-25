# .nixfiles/modules/nixos/bootloader.nix
{
  config,
  pkgs,
  ...
}: let
  fallout =
    pkgs.fetchFromGitHub
    {
      owner = "shvchk";
      repo = "fallout-grub-theme";
      rev = "80734103d0b48d724f0928e8082b6755bd3b2078";
      sha256 = "sha256-7kvLfD6Nz4cEMrmCA9yq4enyqVyqiTkVZV5y4RyUatU=";
    };
in {
  # Bootloader

  # Use the GRUB 2 boot loader.
  boot.loader = {
    timeout = 5;

    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;
      theme = fallout;
      efiSupport = true;
      # efiInstallAsRemovable = true; # if variables doesn't work Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = ["nodev"];
      extraEntriesBeforeNixOS = false;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };

  # Systemd Boot
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # Boot Splash (covers boot log)----------------------------
  boot.plymouth.enable = false;
}
