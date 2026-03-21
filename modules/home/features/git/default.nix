{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    ignores = [
      # AI assistants
      ".claude/"
      ".gemini/"
      ".codex/"
      ".aider*"
      ".cursor/"
      ".continue/"
      # Editor junk
      ".idea/"
      ".vscode/"
      "*.swp"
      ".DS_Store"
    ];
    settings = {
      user.name = "vladislavt345";
      user.email = "vladislavt30515@gmail.com";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
