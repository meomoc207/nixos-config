{ ... }:
{
  services.power-profiles-daemon.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.irqbalance.enable = true;
  services.mpd = {
  enable = true;
  musicDirectory = "/home/lvsumi/Music";
  settings = {
    audio_output = [
       {
         type = "pipewire";
         name = "PipeWire Output";
       }
     ];
   };
 };
}
