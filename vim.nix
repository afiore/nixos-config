with import <nixpkgs> {};

pkgs.neovim.override {
  vimAlias = true;
  configure = {
    customRC = ''
      syntax enable

      """ My settings:
      " tab with two spaces
      set nobackup
      set noswapfile
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
      set smartcase
      set autoindent
      set nostartofline
      set hlsearch      " highlight search terms
      set incsearch     " show search matches as you type

      set mouse=a
      set cmdheight=2

      set wildmenu
      set showcmd

      set number
      set ruler
      set backspace=indent,eol,start " Allows backspace on these character
      set clipboard=unnamedplus

      " Folding
      set foldmethod=syntax

      """ Keep all folds open when a file is opened
      set foldlevel=99

      """ Don't open folds with block motions
      " set foldopen-=block

      " Map esc to exit terminal mode
      :tnoremap <Esc> <C-\><C-n>

      filetype plugin on    " Enable filetype-specific plugins


      " Clean up artifacts in neovim, see https://github.com/neovim/neovim/issues/5990
      let $VTE_VERSION="100"

      " load vim plug
      source ~/.config/nvim/init.vim
    '';
  };
}
