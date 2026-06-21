{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/audio.nix
    ./modules/virtualisation.nix
    ./modules/desktop.nix
    ./modules/input.nix
    ./modules/gaming.nix
    ./modules/fonts.nix
    ./modules/packages.nix
    ./modules/services.nix
    ./modules/selfhosting.nix
  ];

  # nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    cores = 0;
    max-jobs = "auto";
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # global
  networking.hostName = "larpbook";
  networking.networkmanager.enable = true;
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT    = "en_AU.UTF-8";
    LC_MONETARY       = "en_AU.UTF-8";
    LC_NAME           = "en_AU.UTF-8";
    LC_NUMERIC        = "en_AU.UTF-8";
    LC_PAPER          = "en_AU.UTF-8";
    LC_TELEPHONE      = "en_AU.UTF-8";
    LC_TIME           = "en_AU.UTF-8";
  };

  # users
  users.users.lvsumi = {
    isNormalUser = true;
    description  = "lvsumi";
    extraGroups  = [ "networkmanager" "wheel" "input" "libvirtd" "kvm" ];
    shell        = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;
  system.stateVersion = "25.11";
}
