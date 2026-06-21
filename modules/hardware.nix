{ pkgs, ... }:
{
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver vulkan-loader intel-compute-runtime ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };
  services.thermald.enable = true;
  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };
}
