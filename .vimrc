set nocompatible           " Vim defaults rather than vi ones. Keep at top.
filetype plugin indent on  " Enable filetype-specific settings.
syntax on                  " Enable syntax highlighting.
set backspace=2            " Make the backspace behave as most applications.
set autoindent             " Use current indent for new lines.
set display=lastline       " Show as much of the line as will fit.
set wildmenu               " Better tab completion in the commandline.
set wildmode=list:longest  " List all matches and complete to the longest match.
set showcmd                " Show (partial) command in bottom-right.
set expandtab              " Use spaces instead of tabs for indentation.
set smarttab               " Backspace removes 'shiftwidth' worth of spaces.
set number                 " Show line numbers.
set nowrap                 " Don't wrap long lines.
set laststatus=2           " Always show the statusline.
set ruler                  " Show the ruler in the statusline.
set textwidth=80           " Wrap at n characters.
set incsearch              " Jump to search match while typing.
set hlsearch               " Highlight the last used search pattern.
set nrformats-=octal       " Remove octal support from 'nrformats'.
set tabstop=2              " Size of a Tab character.
set shiftwidth=2          " Use same value as 'tabstop'.
set softtabstop=2         " Use same value as 'shiftwidth'.
set encoding=utf-8         " Set encoding
color smyck                " Colorscheme see https://github.com/hukl/Smyck-Color-Scheme
set list listchars=tab:»·,trail:·" Show trailing spaces and highlight hard tabs

" Go to the last cursor location when opening a file.
augroup jump
  autocmd BufReadPost *
    \  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \| exe 'normal! g`"'
    \| endif
augroup end

" Clean trailing whitespace.
fun! s:trim_whitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
command! TrimWhitespace call s:trim_whitespace()

" Highlight characters behind the 80 chars margin
:au BufWinEnter * let w:m2=matchadd('ColumnMargin', '\%>80v.\+', -1)

" Directories for swp files
set backupdir=~/.vim/backups
set directory=~/.vim/backups

" make uses real tabs
au FileType make set noexpandtab

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
