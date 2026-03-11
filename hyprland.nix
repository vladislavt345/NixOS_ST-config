{ config, pkgs, ... }:

{
  # Place hyprland.conf into /etc/hypr/hyprland.conf
  environment.etc."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  # Symlink from user's home to /etc/hypr/hyprland.conf
  systemd.tmpfiles.rules = [
    "d /home/stryer/.config/hypr 0755 stryer users -"
    "L+ /home/stryer/.config/hypr/hyprland.conf - - - - /etc/hypr/hyprland.conf"
  ];
}
