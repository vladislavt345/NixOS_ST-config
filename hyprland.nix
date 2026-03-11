{ config, pkgs, ... }:

{
  # Hyprland config
  environment.etc."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  # Waybar config
  environment.etc."xdg/waybar/config.jsonc" = {
    source = ./waybar/config.jsonc;
  };
  environment.etc."xdg/waybar/style.css" = {
    source = ./waybar/style.css;
  };

  # Kitty config
  environment.etc."xdg/kitty/kitty.conf" = {
    source = ./kitty.conf;
  };

  # Symlinks to user home
  systemd.tmpfiles.rules = [
    "d /home/stryer/.config/hypr 0755 stryer users -"
    "L+ /home/stryer/.config/hypr/hyprland.conf - - - - /etc/hypr/hyprland.conf"

    "d /home/stryer/.config/waybar 0755 stryer users -"
    "L+ /home/stryer/.config/waybar/config.jsonc - - - - /etc/xdg/waybar/config.jsonc"
    "L+ /home/stryer/.config/waybar/style.css - - - - /etc/xdg/waybar/style.css"

    "d /home/stryer/.config/kitty 0755 stryer users -"
    "L+ /home/stryer/.config/kitty/kitty.conf - - - - /etc/xdg/kitty/kitty.conf"
  ];
}
