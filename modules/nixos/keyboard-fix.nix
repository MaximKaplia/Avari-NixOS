# .nixfiles/modules/nixos/keyboard-fix.nix
{...}: {
  #75% keyboard identified as mac keyboard, which disables fn keys
  boot.kernelParams = ["hid_apple.fnmode=2"];
}
