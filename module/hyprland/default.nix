{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Add Hyprland Cachix
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # Basic session requirements
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    kitty
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    mako
  ];

  # Enable required services
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Configure keyboard layout for Hyprland
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
}