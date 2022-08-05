" Use Vim settings instead of Vi
set nocompatible

" General settings
syntax on
filetype on
filetype plugin on
filetype indent on
colorscheme slate
set re=0
set cursorline
set scrolloff=999
set title
set autoread
set wildmenu
set wildmode=longest,list,full
set splitright
set splitbelow

" Gutter settings
set number
set relativenumber
set numberwidth=5

" Line formatting
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch

" Status bar settings
set laststatus=2
set statusline=
set statusline+=%1*
set statusline+=\ 
set statusline+=%2*
set statusline+=%{StatuslineMode()} " mode
set statusline+=%1*
set statusline+=\ 
set statusline+=%F                  " file path
set statusline+=%2*
set statusline+=%m                  " modified flag
set statusline+=%1*
set statusline+=\ 
set statusline+=%=                  " right align
set statusline+=Buffer
set statusline+=\ 
set statusline+=%2*
set statusline+=%n                  " buffer number
set statusline+=%1*
set statusline+=,
set statusline+=\ 
set statusline+=Line
set statusline+=\ 
set statusline+=%2*
set statusline+=%l                  " line num
set statusline+=%1*
set statusline+=/
set statusline+=%2*
set statusline+=%L                  " total lines
set statusline+=%1*
set statusline+=,
set statusline+=\ 
set statusline+=Col
set statusline+=\ 
set statusline+=%2*
set statusline+=%c                  " column number
set statusline+=%1*
set statusline+=,
set statusline+=\ 
set statusline+=%2*
set statusline+=%p                  " percent
set statusline+=%1*
set statusline+=%%
set statusline+=\ 

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL    "
  elseif l:mode==?"v"
    return "VISUAL    "
  elseif l:mode==?"V"
    return "V·LINE    "
  elseif l:mode==#"\<C-V>"
    return "V·BLOCK   "
  elseif l:mode==?"i"
    return "INSERT    "
  elseif l:mode==#"R"
    return "REPLACE   "
  elseif l:mode==?"Rv"
    return "V·REPLACE "
  elseif l:mode==#"c"
    return "COMMAND   "
  elseif l:mode==?"s"
    return "SELECT    "
  elseif l:mode==#"t"
    return "TERMINAL  "
  elseif l:mode==#"!"
    return "SHELL     "
  endif
endfunction

hi User1 cterm=bold ctermbg=black ctermfg=lightgray guibg=black guifg=lightgray
hi User2 cterm=bold ctermbg=black ctermfg=red guibg=black guifg=red

