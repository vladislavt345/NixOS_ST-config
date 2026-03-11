{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "z" ];
    };
  };

  users.users.stryer.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  programs.zsh.interactiveShellInit = ''
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  '';
}
