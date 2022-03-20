{ config, pkgs, ... }:
let vim-nerdtree-direnter = pkgs.callPackage ./nix-pkgs/vim-nerdtree-direnter.nix { };
in {
  news.display = "silent";
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "james";
  home.homeDirectory = "/home/james";
  # Packages to install
  home.packages = [
    pkgs.tmux
    pkgs.python3
    pkgs.nodejs
    pkgs.bottom
    pkgs.gotools
    pkgs.gopls
    pkgs.go-outline
    pkgs.golangci-lint
    pkgs.powerline-fonts
    pkgs.google-cloud-sdk
    pkgs.aws
    pkgs.vimPlugins.dracula-vim
  ];
  
  # Allow fonts installed in home.packages to be discovered and 
  # auto installed
  fonts.fontconfig = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Git Config
    git = {
      enable = true;
      userName = "jamesAtIntegratnIO";
      userEmail = "james@integratn.io";
      aliases = {
        st = "status";
      };
    };
    go = {
      enable = true;
      packages = {
      };
    };
    # VIM CONFIG
    vim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.vim-go
        vim-nerdtree-direnter
        pkgs.vimPlugins.dracula-vim
        pkgs.vimPlugins.nerdtree
        pkgs.vimPlugins.nerdtree-git-plugin
        pkgs.vimPlugins.fzf-vim 
        pkgs.vimPlugins.vim-lsp
      ];
      settings = {
        number = true;
        background = "dark";
        mouse = "a";
        expandtab = true;

      };
      extraConfig = ''
        set termguicolors
        syntax on
        set showtabline=1
        set tabpagemax=8
	nnoremap <leader>n :NERDTreeFocus<CR>
	nnoremap <C-n> :NERDTree<CR>
	nnoremap <C-t> :NERDTreeToggle<CR>
        nnoremap <C-f> :NERDTreeFind<CR>
        let NERDTreeMapOpenInTab='\r'
	" Start NERDTree and put the cursor back in the other window.
	autocmd VimEnter * NERDTree | wincmd p
	" Exit Vim if NERDTree is the only window remaining in the only tab.
	autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      '';
    };
    # ZSH CONFIG
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
      };
    
      localVariables = {
        
      };
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      sessionVariables = {
        GIT_SSH="/usr/bin/ssh";
        GPG_TTY="$(tty)";
        SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)";

      };
      initExtraFirst = "gpgconf --launch gpg-agent";
    };
    direnv = {
      enable = true;
    };
    powerline-go = {
      enable = true;
      settings = {
        hostname-only-if-ssh = true;
        mode = "compatible";
      };
      modules = ["host" "ssh" "cwd" "gitlite" "jobs" "exit"];
      modulesRight = ["duration"];
    };
  };
  # SERVICES
  services = { 
    lorri = {
      enable = true;
    };
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 60;
      maxCacheTtl = 120;
      enableSshSupport = true;
      extraConfig = "ttyname =$GPG_TTY";
    };
  };

}
