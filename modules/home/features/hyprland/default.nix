{ config, pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper pkgs.bibata-cursors ];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/theme.conf".source = ./themes/transparent-bw.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./themes/hyprpaper.conf;
  xdg.configFile."hypr/wallpaper.png".source = ./themes/wallpaper.png;
}
