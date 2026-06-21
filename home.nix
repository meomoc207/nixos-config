{ config, pkgs, ... }:

{
  home.username = "lvsumi";
  home.homeDirectory = "/home/lvsumi";
  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ vscode networkmanagerapplet spice-vdagent adwaita-icon-theme vesktop ];

  gtk = {
  enable = true;
  gtk4.theme = null;
  theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  qt = {
  enable = true;
  platformTheme.name = "adwaita";
  style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "meomoc207";
      user.email = "vinnynghiem207@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
      ls          = "ls -alh --color=always --group-directories-first";
      grep        = "grep --color=auto";
      rm          = "rm -I --preserve-root";
      cp          = "cp -i";
      mv          = "mv -i";
      mkdir       = "mkdir -p";
      performance = "powerprofilesctl set performance";
      balanced    = "powerprofilesctl set balanced";
      power-saver = "powerprofilesctl set power-saver";
      rebuild-system = "sudo nixos-rebuild switch --flake ~/.config/nixos#larpbook";
      rebuild-home   = "home-manager switch --flake ~/.config/nixos#lvsumi";
      update-system  = "sudo nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#larpbook";
      update-home    = "sudo nix flake update --flake ~/.config/nixos && home-manager switch --flake ~/.config/nixos#lvsumi";
      update-all     = "sudo nix flake update --flake ~/.config/nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#larpbook && home-manager switch --flake ~/.config/nixos#lvsumi";
    };
    functions = {
      fish_greeting.body = "fastfetch";
    };
  };

  home.sessionVariables = {
    SDL_IM_MODULE        = "fcitx";
    GLFW_IM_MODULE       = "ibus";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
