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
      augroup OpenAllFoldsOnFileOpen
          autocmd!
          autocmd BufRead * normal zR
      augroup END

      """ Don't open folds with block motions
      set foldopen-=block

      " Map esc to exit terminal mode
      :tnoremap <Esc> <C-\><C-n>


      filetype plugin on    " Enable filetype-specific plugins

      " vim-colors-solarized

      " airline settings

      set background=dark
      colorscheme solarized

      let g:airline_theme = 'solarized'
      let g:airline_solarized_bg='dark'
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1

      " gitgutter settings
      let g:gitgutter_max_signs = 2000

      " vim-multiple-cursors settings
      nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
      vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>

      " ctrl-p settings
      let g:ctrlp_max_files = 100000
      let g:ctrlp_max_depth = 40

      " Clean up artifacts in neovim, see https://github.com/neovim/neovim/issues/5990
      let $VTE_VERSION="100"

      " load vim plug
      source ~/.config/nvim/init.vim
    '';

    vam.knownPlugins = pkgs.vimPlugins; # optional
    vam.pluginDictionaries = [
      {
        names = [
          "airline"
          "alchemist-vim"
          "ctrlp"
          "fugitive"
          "surround"
          "Solarized"
          "multiple-cursors"
          "syntastic"
          "gitgutter"
          "vim-airline-themes"
          "vim-nix"
        ];
      }
    ];
  };
}
