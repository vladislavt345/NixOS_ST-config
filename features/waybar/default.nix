{ config, pkgs, ... }:

{
  environment.etc."xdg/waybar/config.jsonc" = {
    source = ./config.jsonc;
  };

  environment.etc."xdg/waybar/style.css" = {
    source = ./style.css;
  };

  systemd.tmpfiles.rules = [
    "d /home/stryer/.config/waybar 0755 stryer users -"
    "L+ /home/stryer/.config/waybar/config.jsonc - - - - /etc/xdg/waybar/config.jsonc"
    "L+ /home/stryer/.config/waybar/style.css - - - - /etc/xdg/waybar/style.css"
  ];
}
