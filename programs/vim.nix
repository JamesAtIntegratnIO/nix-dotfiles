{pkgs, ...}: {
  programs.vim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-go
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
}
