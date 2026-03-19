{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.fira-code              # для редакторов (Zed, VSCode)
    pkgs.nerd-fonts._0xproto    # для терминала (kitty)
  ];

  fonts.fontconfig.enable = true;
}
