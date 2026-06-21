{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  hardware.opentabletdriver.enable = true;
  environment.systemPackages = with pkgs; [
    protontricks
    protonup-qt
  ];
}
