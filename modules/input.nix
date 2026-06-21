{ pkgs, ... }:
{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-unikey
      qt6Packages.fcitx5-configtool
      fcitx5-gtk
    ];
  };
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
  };
}
