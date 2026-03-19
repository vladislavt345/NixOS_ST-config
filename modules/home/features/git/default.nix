{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "vladislavt345";
      user.email = "vladislavt30515@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
