{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # cli / system tools
    curl wget git vim neovim fastfetch btop home-manager

    # development
    nodejs pnpm mkcert nssTools

    # wayland desktop
    kitty rofi waybar swaybg swaynotificationcenter
    grim slurp wl-clipboard libnotify adwaita-icon-theme
    cava hyprshot hyprlock hypridle satty

    # file management
    nemo gvfs udiskie

    # music
    mpdris2
  ];
}
