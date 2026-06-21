{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    corefonts
    vista-fonts
    font-awesome
    noto-fonts-color-emoji
  ];
}
