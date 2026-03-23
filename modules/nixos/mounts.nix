{ pkgs, inputs, ... }:
{

  fileSystems."/mnt/Archive" = {
    device = "/dev/disk/by-uuid/fdb6e762-9fef-4aa2-a812-83aa96ab8720";
    fsType = "ext4";
    options = [ "defaults"
    "users" # Allows any user to mount and unmount
     "nofail" # Prevent system from failing if this drive doesn't mount
     "exec" # Permit execution of binaries and other executable files
     "noatime"  # Optional: noatime reduces writes
     ];
  };

}
