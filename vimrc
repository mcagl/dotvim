" pathogen.vim invoking
call pathogen#infect()
call pathogen#helptags()

" Default file encoding
set encoding=utf8
set fileencoding=utf8

" Default whitespace managing
set ts=4 sts=4 sw=4 expandtab

" Use vim things, don't stick with old vi ones
set nocompatible

" Keep backup of files
set backup

" Use mouse
set mouse=a

" Syntax highlighting
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch    " Highlight search
    set incsearch   " Search as you type
endif

" Turn on filetype detection
filetype on

" Filetype indentation
filetype plugin indent on

" Define filetype for every file with these extensions
autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

" Set whitespace managing for every filetype, overriding standard
" Configure vim to be PEP8 compliant when editing Python code
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType html,xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType makefile setlocal ts=4 sts=4 sw=4 noexpandtab

" Automatically remove trailing whitespace before saving
" http://stackoverflow.com/a/1618401/1651545
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Various settings
" http://stackoverflow.com/a/2559262/1651545
set nowrap                          " Don't wrap lines
set scrolloff=2                     " 2 lines above/below cursor when scrolling
set showmatch                       " Show matching bracket
set matchtime=5                     " Show matching bracket for 0.5 seconds
autocmd FileType html,xml setlocal matchpairs+=<:>      " Match also < > for html and xml
set cursorline                      " Highlight cursor line
set number                          " Use line numbers
set numberwidth=4                   " Minimum field width for line numbers

" Various remapped shortcuts
" F2 go to the previous buffer, F3 go to the next buffer
" F4 go to the previous active buffer, F5 closes active buffer
map <F2> :bp<CR>
map <F3> :bn<CR>
map <F4> :b#<CR>
map <F5> :bd<CR>
" NERDTreeToggle
map <F9> :NERDTreeToggle<CR>
map <F10> :NERDTreeFind<CR>

" Move through windows with CTRL + arrows

" PowerLine things
let g:Powerline_symbols = 'fancy'
set laststatus=2                    " Use 2 lines for the statusbar

" Colorscheme
set background=dark
" The colorscheme is commented because I didn't decide yet
"colorscheme ir_black