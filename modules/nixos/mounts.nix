#.nixfiles/modules/nixos/mounts.nix
{
  pkgs,
  inputs,
  ...
}: {
  # Enable NTFS support
  boot.supportedFilesystems = ["ntfs"];

  # Install ntfs-3g for better NTFS support
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  # Cache SSD - ext4 partition
  fileSystems."/mnt/Cache SSD" = {
    device = "/dev/disk/by-uuid/9cd54c1d-1694-4f19-9364-462c368cddbe";
    fsType = "ext4";
    options = [
      "defaults"
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
      "noatime" # Reduces writes, good for SSDs
      "discard" # Enable TRIM for SSD
    ];
  };

  # Old Hard Drive - NTFS partition (sdb2)
  fileSystems."/mnt/Old Hard" = {
    device = "/dev/disk/by-uuid/6E006E48006E16FD";
    fsType = "ntfs-3g";
    options = [
      "defaults"
      "users"
      "nofail"
      "exec"
      "uid=1000"
      "gid=100"
      "fmask=113"
      "dmask=002"
      "windows_names"
      "locale=en_US.UTF-8"
    ];
  };

  # AvaFootage - NTFS partition (sda2)
  fileSystems."/mnt/AvaFootage" = {
    device = "/dev/disk/by-uuid/B250048150044F13";
    fsType = "ntfs-3g";
    options = [
    "rw"
    "uid=1000"
    "gid=100"
    "umask=022"
    "windows_names"
    "nofail"
    "users"
    "exec"
    ];
  };

  # Optional: Linux SSD (if you want to mount it)
  fileSystems."/mnt/Linux SSD" = {
    device = "/dev/disk/by-uuid/f2f59e33-fc42-47c7-a6ec-31dd918de440";
    fsType = "btrfs";
    options = [
      "defaults"
      "users"
      "nofail"
      "exec"
      "compress=zstd" # btrfs compression
      "noatime" # Reduces writes
    ];
  };
}
