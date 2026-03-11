{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.hyprpaper
    pkgs.bibata-cursors
  ];

  # Hyprland config
  environment.etc."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  # Theme config
  environment.etc."hypr/theme.conf" = {
    source = ./themes/transparent-bw.conf;
  };

  # Hyprpaper config
  environment.etc."hypr/hyprpaper.conf" = {
    source = ./themes/hyprpaper.conf;
  };

  # Wallpaper
  environment.etc."hypr/wallpaper.png" = {
    source = ./themes/wallpaper.png;
  };

  # Symlinks into user home
  systemd.tmpfiles.rules = [
    "d /home/stryer/.config/hypr 0755 stryer users -"
    "L+ /home/stryer/.config/hypr/hyprland.conf - - - - /etc/hypr/hyprland.conf"
    "L+ /home/stryer/.config/hypr/theme.conf - - - - /etc/hypr/theme.conf"
    "L+ /home/stryer/.config/hypr/hyprpaper.conf - - - - /etc/hypr/hyprpaper.conf"
    "L+ /home/stryer/.config/hypr/wallpaper.png - - - - /etc/hypr/wallpaper.png"
  ];
}
