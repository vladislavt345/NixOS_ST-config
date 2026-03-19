{ config, pkgs, ... }:

{
  imports = [
    ./features/hyprland
    ./features/kitty
    ./features/waybar
    ./features/zsh
  ];

  home.username = "stryer";
  home.homeDirectory = "/home/stryer";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
