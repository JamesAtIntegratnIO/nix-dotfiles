{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "jamesAtIntegratnIO";
    userEmail = "james@integratn.io";
    aliases = {
      st = "status";
      branches = "for-each-ref --sort=-committerdate refs/heads/ --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'";
    };
    extraConfig = {
      global = {
        autoSetupRemote = true;
        init = {
          defaultBranch = "main";
        }
      };
    };
  };
}
