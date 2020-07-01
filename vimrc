" This is Gary Bernhardt's edited by Maximilien Cuony .vimrc file
" vim:set ts=2 sts=2 sw=2 expandtab:

" Boostrap autoload
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=" "
set nu
set foldcolumn=2
set autoindent
set foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
set background=dark
":color ir_black
color archman

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

function! RandomHexString(...)
    let random_string = system('cat /dev/urandom | tr -dc "0-9a-f" | head -c '.shellescape(a))
    return random_string
endfunction

function! RandomString(...)
    let random_string = system('cat /dev/urandom | tr -dc "0-9A-z" | head -c '.shellescape(a))
    return random_string
endfunction

command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5sum')

command! -nargs=1 RandomHexString :normal a<c-r>=RandomHexString(<f-args>)<cr>
command! -nargs=1 RandomString :normal a<c-r>=RandomString(<f-args>)<cr>

command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>
""colorscheme desert

" Bootstrap autoreload
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/millermedeiros/vim-statline.git'
Plug 'https://github.com/tpope/vim-fugitive'
let g:statline_fugitive = 1
let g:fugitive_gitlab_domains = ['https://git.arcanite.ch', 'https://git.polylan.ch']
Plug 'https://github.com/junegunn/gv.vim'
Plug 'https://github.com/vim-syntastic/syntastic.git'
let g:syntastic_auto_loc_list=0
let g:syntastic_enable_loc_list=0
let g:syntastic_enable_highlighting=1
let g:syntastic_error_symbol='✗→'
let g:syntastic_style_error_symbol='✗→'
let g:syntastic_warning_symbol='⚠→'
let g:syntastic_style_warning_symbol='⚠→'
let g:syntastic_aggregate_errors=1
let g:Powerline_symbols = 'unicode'

let g:syntastic_python_checkers=['flake8', 'pyflakes', 'pep8', 'py3kwarn']
let g:syntastic_python_checker_args='--ignore=E501'
let g:syntastic_python_flake8_post_args='--ignore=E501,E128'
let g:syntastic_python_pep8_post_args='--ignore=E501,E128'
let g:syntastic_check_on_open=1

Plug 'https://github.com/gioele/vim-autoswap'
Plug 'https://github.com/airblade/vim-gitgutter'
let g:gitgutter_eager = 0 " only update on read/write
let g:gitgutter_sign_column_always = 0
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://github.com/saltstack/salt-vim'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/itchyny/lightline.vim'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'filename', 'readonly', 'modified' ],
      \             [ 'gitdiff' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'gitversion' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component_expand': {
      \   'gitdiff': 'lightline#gitdiff#get',
      \ },
      \ 'component_type': {
      \   'gitdiff': 'middle',
      \ },
      \ }
Plug 'https://github.com/preservim/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

Plug 'https://github.com/mcchrish/nnn.vim'
nnoremap <leader>nn :NnnPicker '%:p:h'<CR>

let g:nnn#action = {
  \ '<c-t>': 'tab-split',
  \ '<c-x>': 'split',
  \ '<c-v>': 'vsplit' }


Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/Konfekt/FastFold'
nmap zuz <Plug>(FastFoldUpate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']


Plug 'https://github.com/majutsushi/tagbar'
let g:tagbar_autofocus=1
map <c-t> :TagbarToggle<CR>

Plug 'https://github.com/ap/vim-css-color'

Plug 'https://github.com/vifm/vifm.vim'

call plug#end()

set clipboard=unnamedplus
set mouse=a
set encoding=UTF-8
set autoread
set modifiable


" CursorLine
" hi Cursor gui=reverse guibg=NONE guifg=NONE
" hi CursorLine gui=reverse cterm=reverse
nnoremap <leader>ct :set cursorline!<CR>

" Folding
" set foldnestmax=2
" set foldmethod=indent

set nofoldenable
set splitbelow
set splitright
set relativenumber

" Custom shortcuts
" Search in files
nnoremap <C-F> :Ag<CR>
" Git status
nnoremap <C-c> :15Gstatus<CR>
" Search file name
nnoremap <C-G> :Files<CR>
" Search git file name
nnoremap <C-X> :GFiles<CR>
" Search buffers
nnoremap <C-B> :Buffers<CR>
" Open Flake8 error
nnoremap <C-E> :Errors<CR>
" Force write as unix type (/n instead of /r/n)
nnoremap <C-s> :w! ++ff=unix<CR>
" Force quit
nnoremap <C-q> :q!<CR>
" Split diff
nnoremap <C-d> :Gdiffsplit<CR>
" Buffer 

"" F1-12 Shortcuts
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
nnoremap <F3> :GV<CR>
nnoremap <F5> :Git add %<CR>
nnoremap <F6> :Gcommit<CR>
nnoremap <F7> :SyntasticCheck<CR>
nnoremap <F8> :SyntasticReset<CR>

" Fold / unfold with space
" nnoremap <space> za
" vnoremap <space> zf

nnoremap <leader>dl <HOME>d$
nnoremap <c-left> :bprevious<CR>
nnoremap <c-right> :bnext<CR>

nnoremap <Return> o<ESC>
nnoremap <BS> O<ESC>

" nnoremap <C-X> %!xxd<CR>
