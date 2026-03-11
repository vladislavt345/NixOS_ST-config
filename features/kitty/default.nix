{ config, pkgs, ... }:

{
  environment.etc."xdg/kitty/kitty.conf" = {
    source = ./kitty.conf;
  };

  systemd.tmpfiles.rules = [
    "d /home/stryer/.config/kitty 0755 stryer users -"
    "L+ /home/stryer/.config/kitty/kitty.conf - - - - /etc/xdg/kitty/kitty.conf"
  ];
}
