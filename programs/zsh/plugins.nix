
# hash for forcing it to fail and give you the right hash
# 0000000000000000000000000000000000000000000000000000
{
  name = "zsh-nix-shell";
  file = "nix-shell.plugin.zsh";
  src = fetchFromGitHub {
    owner = "chisui";
    repo = "zsh-nix-shell";
    rev = "v0.4.0";
    sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
  };
}
{
  name = "zsh-syntax-highlighting";
  src = fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "0.7.1";
    sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
  };
  file = "zsh-syntax-highlighting.zsh";
}
{
  name = "zsh-autosuggestions";
  src = fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "v0.7.0";
    sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
  };
  file = "zsh-autosuggestions.zsh";
}
{
  name = "zsh-history-substring-search";
  src = fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-history-substring-search";
    rev = "v1.0.2";
    sha256 = "Ptxik1r6anlP7QTqsN1S2Tli5lyRibkgGlVlwWZRG3k=";
  };
  file = "zsh-history-substring-search.zsh";
}
