{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "jamesAtIntegratnIO";
    userEmail = "james@integratn.io";
    aliases = {
      st = "status";
    };
    extraConfig = {
      global = {
        autoSetupRemote = true;
      };
    };
  };
}
