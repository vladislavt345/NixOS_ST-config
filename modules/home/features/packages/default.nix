{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # terminal
    kitty
    btop
    fastfetch
    yazi

    # launcher
    walker
    fuzzel

    # browsers
    firefox
    google-chrome
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # communication
    telegram-desktop
    discord

    # editors
    zed-editor
    vscode

    # productivity
    obsidian
    flameshot

    # other
    nekoray
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
