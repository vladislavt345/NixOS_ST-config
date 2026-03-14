{ config, pkgs, ... }:

{
  programs.niri.enable = true;
  services.gnome.gcr-ssh-agent.enable = false;
  environment.systemPackages = [ pkgs.swaybg pkgs.bibata-cursors ];
}
