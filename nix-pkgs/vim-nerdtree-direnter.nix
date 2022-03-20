{ pkgs, fetchFromGitHub }:

pkgs.vimUtils.buildVimPlugin {
  pname = "vim-nerdtree-direnter";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "nopik";
    repo = "vim-nerdtree-direnter";
    rev = "9988e2b2b2134310c635030b79adb5bc915e1595";
    sha256 = "3UiNNHVQj2jkS1/xrk0js+MVPkbQGjQyWn2s7DKRGBw=";
  };
}
