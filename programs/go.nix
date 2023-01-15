{...}: {
  programs.go = {
    enable = true;
    goPath = "go";
    goBin = "go/bin";
    # packages = {
    #   "golang.org/x/tools" = builtins.fetchGit "https://go.googlesource.com/tools";
    #   "github.com/stamblerre/gocode" = builtins.fetchGit "https://github.com/stamblerre/gocode";
    #   "github.com/ramya-rao-a/go-outline" = builtins.fetchGit "https://github.com/ramya-rao-a/go-outline";
    #   "github.com/golangci/golangci-lint" = builtins.fetchGit "https://github.com/golangci/golangci-lint";
    # };
  };
}
