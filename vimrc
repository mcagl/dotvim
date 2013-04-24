"""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle things
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'airblade/vim-gitgutter'
Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
Bundle 'fholgado/minibufexpl.vim'
"Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'lilydjwg/colorizer'
Bundle 'Lokaltog/vim-powerline'
Bundle 'majutsushi/tagbar'
"Bundle 'mcagl/snipmate.vim'
Bundle 'mileszs/ack.vim'
Bundle 'mjbrownie/vim-htmldjango_omnicomplete'
"Bundle 'msanders/snipmate.vim'
Bundle 'python_match.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'jnurmine/Zenburn'
Bundle 'altercation/vim-colors-solarized'
""""""""""""""""""""""""""""""""""""""""""""""""

" Default file encoding
set encoding=utf8
set fileencoding=utf8

" Default whitespace managing
set ts=4 sts=4 sw=4 expandtab

" Keep backup of files in a hidden subdirectory under $VIMRUNTIME
set backup
set backupdir=$HOME/.vim/.backup_files
set directory=$HOME/.vim/.swp_files

" Use mouse
set mouse=a

" Set to 256 colors
set t_Co=256

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
autocmd FileType python,python.django setlocal ts=4 sts=4 sw=4 expandtab cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType html,xml,htmldjango setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType makefile setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType tex setlocal wm=3          " Automatically wrap at 3 columns from the window border
" Make vim autoformat mails on the fly everytime a line changes
" autocmd FileType mail setlocal formatoptions+=a

" Automatically remove trailing whitespace before saving
" http://stackoverflow.com/a/1618401/1651545
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,html,htmldjango autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Various settings
" http://stackoverflow.com/a/2559262/1651545
set nowrap                          " Don't wrap lines
set scrolloff=2                     " 2 lines above/below cursor when scrolling
set showmatch                       " Show matching bracket
set matchtime=5                     " Show matching bracket for 0.5 seconds
" Match also < > for html, htmldjango and xml
autocmd FileType html,htmldjango,xml setlocal matchpairs+=<:>
set cursorline                      " Highlight cursor line
set number                          " Use line numbers
set numberwidth=4                   " Minimum field width for line numbers
set hidden                          " Allow to hid modified buffers

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
nnoremap <silent> <C-left> <C-W>h
nnoremap <silent> <C-right> <C-W>l
nnoremap <silent> <C-up> <C-W>k
nnoremap <silent> <C-down> <C-W>j

" http://vim.wikia.com/wiki/Switching_case_of_characters
" Visually select text then press ~ to convert the text to
" UPPER CASE, then to lower case, then to Title Case.
" Keep pressing ~ until you get the case you want.
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

" PowerLine things
let g:Powerline_symbols = 'fancy'
set laststatus=2                    " Use 2 lines for the statusbar

" Python-mode things
" Disable pylint checking every save
let g:pymode_lint_write = 0
" Set key 'R' for run python code
let g:pymode_run_key = 'R'
" Rope plugin (disable it)
let g:pymode_rope = 0
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime","django"]
let g:pymode_rope_auto_project = 0
" Enable python folding but default to unfolded
let g:pymode_folding = 1
autocmd FileType python,python.django setlocal foldlevel=99

" Colorscheme
set background=dark
" The colorscheme is commented because I didn't decide yet
"let g:solarized_termcolors=256          " Compatibility with terminal emulators
" ZenBurn tweaking
let g:zenburn_high_Contrast = 1
let g:zenburn_force_dark_Background = 1
colorscheme zenburn

" htmldjango-omnicomplete stuff
au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
let g:htmldjangocomplete_html_flavour = 'html401s'
au FileType htmldjango inoremap {% {% %}<left><left><left>
au FileType htmldjango inoremap {{ {{ }}<left><left><left>

" Tagbar plugin configuration
nmap <F8> :TagbarToggle<CR>

" SuperTab configuration
let g:SuperTabDefaultCompletionType = "context"

" Gundo configuration
nnoremap <leader>u :GundoToggle<CR>

" Disable syntastic by default, except for a whitelist of formats
" see: https://github.com/scrooloose/syntastic/issues/101
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['python'], 'passive_filetypes': [] }
" Use only tidy and no online service to check HTML
" https://github.com/scrooloose/syntastic/issues/485
let g:syntastic_html_checkers=['tidy']

" Colorizer
nmap <leader>tc <Plug>Colorizer

" Snipmate
ino <silent> <leader><leader> <c-r>=TriggerSnippet()<cr>
snor <silent> <leader><leader> <esc>i<right><c-r>=TriggerSnippet()<cr>

" LaTeX-suite
"let g:tex_flavor='latex'
"" Disable folding
"" http://stackoverflow.com/questions/3322453/how-can-i-disable-code-folding-in-vim-with-vim-latex
"autocmd Filetype tex setlocal nofoldenable

" Autoreload ~/.vimrc after saving it
" seen here: http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Better line wraps
" seen here: http://www.bestofvim.com/tip/better-line-wraps/
set showbreak=↪

" Useful standard plugins
:source /usr/share/vim/vim73/macros/matchit.vim      " Smartly match for XML/HTML/XHTML tags
