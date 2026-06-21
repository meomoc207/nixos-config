{ pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "mitigations=off" ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };
}
