{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # cli / system tools
    curl wget git vim neovim fastfetch btop home-manager

    # development
    nodejs pnpm mkcert nssTools zellij python3

    # wayland desktop
    kitty rofi waybar swaybg swaynotificationcenter
    grim slurp wl-clipboard libnotify adwaita-icon-theme
    cava hyprshot hyprlock hypridle satty

    # file management
    nemo gvfs udiskie

    # gaming
    osu-lazer-bin
  ];
}
