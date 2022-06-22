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

"" Status line full path for filename
function LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)+1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

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
"Plug 'https://github.com/junegunn/gv.vim'
Plug 'https://github.com/Legrems/gv.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

Plug 'https://github.com/vim-python/python-syntax'
let g:python_highlight_all=1

Plug 'https://github.com/gioele/vim-autoswap'
Plug 'https://github.com/airblade/vim-gitgutter'
let g:gitgutter_eager = 0 " only update on read/write
let g:gitgutter_sign_column_always = 0
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'
let g:fzf_commits_log_options = '--format="%C(yellow)%h%d %s %C(cyan)(%aN) %C(black)%C(bold)%cr"'

let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_git_status_preview_command =
    \ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || " .
    \ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || " .
    \ g:fzf_preview_command

Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://github.com/saltstack/salt-vim'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/itchyny/lightline.vim'
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename', 'readonly', 'modified' ],
      \             [ 'gitdiff' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'gitbranch' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'gitversion' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename',
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
nnoremap <leader>nn :NnnPicker -de '%:p:h'<CR>

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

Plug 'https://github.com/gregsexton/gitv', {'on': ['Gitv']}

Plug 'stevearc/vim-arduino'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'posva/vim-vue'

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']


Plug 'godlygeek/tabular'

Plug 'plasticboy/vim-markdown'

"Plug 'pwntester/octo.vim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

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
set foldnestmax=10
set foldmethod=indent

set nofoldenable
set splitbelow
set splitright
set relativenumber

" Custom shortcuts
"-------------------------------------------------------------------------------------------|
"  Modes     | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
" [nore]map  |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
" n[nore]map |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
" n[orem]ap! |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
" i[nore]map |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
" c[nore]map |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
" v[nore]map |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
" x[nore]map |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
" s[nore]map |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
" o[nore]map |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
" t[nore]map |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
" l[nore]map |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
"-------------------------------------------------------------------------------------------"
" Search in files
nnoremap <C-F> :Ag<CR>
"nnoremap <C-F> :CocCommand fzf-preview.ProjectGrep<space>
" Git status
" Old layout in the bottom
"nnoremap <C-c> :15Gstatus<CR>
" New layout vertical
nnoremap <C-c> :vertical topleft Git <bar> vertical resize 50<CR>
" Search file name
"nnoremap <C-G> :Files<CR>
" Ignore ignored files => all files
"nnoremap <C-G> :CocCommand fzf-preview.DirectoryFiles --no-ignore-vcs<CR>
nnoremap <C-G> :CocCommand fzf-preview.ProjectFiles<CR>
" Search git file name
"nnoremap <C-X> :GFiles<CR>
"nnoremap <C-X> :CocCommand fzf-preview.DirectoryFiles<CR>
nnoremap <C-X> :CocCommand fzf-preview.GitFiles<CR>
" Search buffers
"nnoremap <C-B> :Buffers<CR>
nnoremap <C-B> :CocCommand fzf-preview.Buffers<CR>
" Open Flake8 error
nnoremap <C-E> :Errors<CR>
" Force write as unix type (/n instead of /r/n)
nnoremap <C-s> :w! ++ff=unix<CR>
" Force quit
nnoremap <C-q> :q!<CR>
" Split diff
" nnoremap <C-d> :Gdiffsplit<CR>
nnoremap <C-d> :tab Git diff %<CR>
nnoremap <C-p> :tab Git diff<CR>
" Using git-delta
" Buffer 

"" F1-12 Shortcuts
nnoremap <F1> :tabprevious<CR>
nnoremap <F2> :tabnext<CR>
nnoremap <F3> :GV<CR>
nnoremap <F4> :tab Git show -
nnoremap <F5> :Git rebase -i HEAD~
nnoremap <F7> :SyntasticCheck<CR>
nnoremap <F8> :SyntasticReset<CR>

" Fold / unfold with space
nnoremap <space> za
vnoremap <space> zf

nnoremap <leader>dl <HOME>d$
nnoremap <c-left> :bprevious<CR>
nnoremap <c-right> :bnext<CR>

nnoremap <Return> o<ESC>
nnoremap <BS> O<ESC>

nnoremap <leader>/ <cmd>Telescope search_history<CR>
"nnoremap <leader>ch <cmd>Telescope command_history<CR>
nnoremap <leader>ch <cmd>CocCommand fzf-preview.CommandPalette<CR>
"nnoremap <leader>gc <cmd>Telescope git_commits<CR>
nnoremap <leader>gc <cmd>CocCommand fzf-preview.GitLogs<CR>
"nnoremap <leader>gb <cmd>Telescope git_branches<CR>
nnoremap <leader>gb <cmd>CocCommand fzf-preview.GitBranches<CR>
"nnoremap <leader>gss <cmd>Telescope git_status<CR>
nnoremap <leader>gss <cmd>CocCommand fzf-preview.GitStatus<CR>
"nnoremap <leader>gsc <cmd>Telescope git_stash<CR>
nnoremap <leader>gsc <cmd>CocCommand fzf-preview.GitStashes<CR>

nnoremap <leader>iss <cmd>! glab issue list<CR>

" Copy into temp file
vmap <leader>y :w! /tmp/vimtmp<CR>
" Read from temp file
nmap <leader>p :r! cat /tmp/vimtmp<CR>

" Copy filename + line number into clipboard
nmap <leader>oo :call setreg('+', expand("%:h") . "/" . expand("%:t") . "#L" . line("."))<CR>


nmap <leader>xx :%!xxd<CR>
