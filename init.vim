" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

" Essentials
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

" Lang supports
Plug 'sheerun/vim-polyglot'
let g:haskell_classic_highlighting = 1
" vim-polyglot uses latexbox instead of vimtex
let g:polyglot_disabled=['latex']
let g:rustfmt_autosave = 1
Plug 'racer-rust/vim-racer'
Plug 'ledger/vim-ledger'
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 1
Plug 'Konfekt/FastFold'
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:tex_fold_enabled = 1
Plug 'zhimsel/vim-stay'

" Snippets and completion
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Eye candies
Plug 'dracula/vim'
call plug#end()

" True colors
set termguicolors
colorscheme dracula


" Better split behaviour
set splitright
set splitbelow

set cpoptions+=J          " A sentence must be followed by two spaces
set autowriteall
set hidden
set ignorecase
set smartcase
set formatoptions=q,r,n,1
set noshowmode
set scrolloff=5

" Folding
set viewoptions=cursor,folds,slash,unix
set fillchars=fold:\ 

set updatetime=1000
set shell=/usr/bin/zsh


let g:mapleader="\<Space>"
let g:maplocalleader="\\"
nnoremap j gj
nnoremap k gk
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>bb :Buffers<CR>

" <C-[> is equivalent to <Esc> but easier to reach
tnoremap <C-[> <C-\><C-n>

" Allow saving of files when forget to sudo
cmap w!! w !sudo tee > /dev/null %

if executable('rg')
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Ggrep
        \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
  command! -bang Colors
        \ call fzf#vim#colors({'left': '15%', 'options:': '--reverse --margin 30%,0'}, <bang>0)
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
endif


augroup basic
  au!

  " Go to insert mode by default on terminal buffers
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif

  " Set textwidth for mutt buffers
  au BufRead /tmp/mutt-* setlocal textwidth=72

  " Basic stuffs for vim configs
  au Filetype vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

augroup haskell
  au!
  au Filetype haskell setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
augroup END

augroup rust
  au!
  au Filetype rust nnoremap <localleader>gd <Plug>(rust-def)
  au Filetype rust nnoremap <localleader>gs <Plug>(rust-def-split)
  au Filetype rust nnoremap <localleader>gv <Plug>(rust-def-vertical)
  au Filetype rust nnoremap <localleader>gx <Plug>(rust-doc)
augroup END

augroup yaml
  au!
  au Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
