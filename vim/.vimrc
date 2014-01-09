" Read the file as UTF-8.
scriptencoding utf-8

set nocompatible

" Use a different view in the netrw directory listing.
let g:netrw_liststyle=3 " or 1

syntax on

set showmatch

" Save on blur.
au FocusLost * :silent! wall

" Return to command mode on blur.
au FocusLost * call feedkeys("\<C-\>\<C-n>")

" Add jj to exit back to normal mode.
inoremap jj <ESC>

" General
set autochdir " always switch to the current file directory
set backspace=indent,eol,start " allow backspacing over these
set iskeyword+=_,$,@,%,# " none of these are word dividers
set noerrorbells " don't make noise

" Vim UI
set cursorline " highlight current line
set incsearch " BUT do highlight as you type you search phrase
set list " display unprintable characters
set listchars=tab:>·,trail:·,extends:>,precedes:< " show tabs and trailing; works with 'list'
set number " turn on line numbers
set numberwidth=5 " We are good up to 99999 lines
set ruler " display the cursor position in the status
set scrolloff=3 " Keep X lines (top/bottom) before the horizontal window border
set showtabline=2 " always show tabbar
set title " Show the filename in the window's titlebar
set nowrap " Don't wrap long lines

" Search
set ignorecase " case insensitive by default
set smartcase " if there are caps, go case-sensitive
set hlsearch " highlight search
hi Search ctermbg=0 ctermfg=none

" Automatic Indentation
set autoindent " turn on automatic indentation (copy the indentation of the previous line)

set shiftround " round indent to a multiple of 'shiftwidth'; e.g. when at 3 spaces and tabbed go to 4, not 5
set expandtab " no real tabs
set tabstop=4 " number of spaces that a <Tab> in the file counts for
set shiftwidth=4 " number of spaces to use for each step of (auto)indent 
set softtabstop=4 " number of spaces that a <Tab> counts for while performing editing operations

au WinLeave * set nocursorline
au WinEnter * set cursorline
set ic
set nopaste

if has("gui_macvim")
  " remove scroll bars and tool bar
  set guioptions-=T " remove toolbar

  " expand width in fullscreen
  set fuoptions=maxvert,maxhorz

  " hide tab bar
  "set showtabline=0
endif

" Change indent using arrow keys
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

"nmap <Up> kddpk
"nmap <Down> ddp
"vmap <Up> [egv
"vmap <Down> ]egv

" Execute macro q by pressing spacebar
nnoremap <Space> @q

" Remove trailing spaces on save for certain file types.
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e
autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.scss :%s/\s\+$//e

highlight BadWhitespace ctermbg=red guibg=red

" JavaScript
autocmd BufRead,BufNewFile *.js set expandtab
autocmd BufRead,BufNewFile *.js set tabstop=4
autocmd BufRead,BufNewFile *.js set softtabstop=4
autocmd BufRead,BufNewFile *.js set shiftwidth=4
autocmd BufRead,BufNewFile *.js set autoindent
autocmd BufRead,BufNewFile *.js match BadWhitespace /^\t\+/
autocmd BufRead,BufNewFile *.js match BadWhitespace /\s\+$/
autocmd         BufNewFile *.js set fileformat=unix
autocmd BufRead,BufNewFile *.js let b:comment_leader = '//'
autocmd BufWritePre *.js :%s/\s\+$//e

" Python, PEP-008
autocmd BufRead,BufNewFile *.py,*.pyw set expandtab
autocmd BufRead,BufNewFile *.py,*.pyw set textwidth=79
autocmd BufRead,BufNewFile *.py,*.pyw set tabstop=4
autocmd BufRead,BufNewFile *.py,*.pyw set softtabstop=4
autocmd BufRead,BufNewFile *.py,*.pyw set shiftwidth=4
autocmd BufRead,BufNewFile *.py,*.pyw set autoindent
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/
autocmd         BufNewFile *.py,*.pyw set fileformat=unix
autocmd BufRead,BufNewFile *.py,*.pyw let b:comment_leader = '#'
autocmd BufWritePre *.py :%s/\s\+$//e

" Move the directory for the backup file.
set backupdir=~/.vim/backup/

" Move the directory for the swap file.
set directory=~/.vim/swap/

if has("gui_running")
  colorscheme railscat

  if has("gui_macvim")
    set guifont=consolas:h16
  else
    " gVim Settings

    " Hide the gVim toolbar.
    set guioptions-=T

    " Show a maximum number of characters in the tabs.
    set guitablabel=%-0.20t%M

    " Make gVim behave a bit more like MacVim.
    " ctrl + w => Close Tab
    map <C-w> :q<cr>

    " alt + shift + ] => Next Tab
    map <A-}> gt

    " alt + shift + [ => Previous Tab
    map <A-{> gT

    " ctrl + a = Select All
    map <C-a> <esc>gg<S-v>G
  endif
endif
