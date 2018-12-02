" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Editing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-markdown'

" VCS
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'


" UI

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'universal-ctags/ctags'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'chrisbra/Colorizer'

" Autocompletion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'


" Language support 
"
" Rust
Plug 'rust-lang/rust.vim'
Plug 'LnL7/vim-nix'
Plug 'racer-rust/vim-racer'
Plug 'Shougo/echodoc.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Elm
Plug 'elmcast/elm-vim'

" themes

Plug 'junegunn/seoul256.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" FZF

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

map <C-p> :Files<CR>

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
        
endif

" Rust configuration

let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1


autocmd BufReadPost *.rs setlocal filetype=rust
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F1> :call LanguageClient#textDocument_rename()<CR>


let g:ale_sign_column_always = 1
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1


" NCM2
" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")


" CTags support

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" Look and feel
let g:airline_theme='angr'
colorscheme seoul256
