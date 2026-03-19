{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "vladislavt345";
    userEmail = "vladislavt30515@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
