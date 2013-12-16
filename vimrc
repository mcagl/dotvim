"""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle things
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'matze/vim-move'
Bundle 'mileszs/ack.vim'
Bundle 'mjbrownie/vim-htmldjango_omnicomplete'
Bundle 'python_match.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/MatchTagAlways'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Yggdroot/indentLine'
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

" GVIM font
if has("gui_running")
    set guifont=Inconsolata\ for\ Powerline\ 11
endif

" Turn on filetype detection
filetype on

" Filetype indentation
filetype plugin indent on

" Define filetype for every file with these extensions
autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

" Take care of django files
autocmd BufNewFile,BufRead *.html call s:FThtmldjango()
autocmd BufNewFile,BufRead *.py call s:FTpydjango()

func! s:FThtmldjango()
  let n = 1
  while n < 30 && n < line("$")
    if getline(n) =~ '.*{%.*'
      set ft=htmldjango
      return
    endif
    let n = n + 1
  endwhile
  set ft=html
endfunc

func! s:FTpydjango()
  let n = 1
  while n < 30 && n < line("$")
    if getline(n) =~ '.*django.*'
      set ft=python.django
      return
    endif
    let n = n + 1
  endwhile
  set ft=python
endfunc

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

" airline things
set laststatus=2                    " Use 2 lines for the statusbar
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_exclude_filenames=[]
let g:airline_exclude_filetypes=[]

" Add the following snippet to your vimrc to escape insert mode immediately
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" Python-mode things
" Disable pylint
let g:pymode_lint = 0
" Disable pylint checking every save
let g:pymode_lint_write = 0
" Set key 'R' for run python code
let g:pymode_run_key = 'R'
" Disable loading the documentation plugin
let g:pymode_doc = 0
" Rope plugin (disable it)
let g:pymode_rope = 0
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime","django"]
let g:pymode_rope_auto_project = 0
" Enable python folding but default to unfolded
let g:pymode_folding = 1
autocmd FileType python,python.django setlocal foldlevel=99
" Disable docstring popup (hopefully...)
" Found here: https://github.com/davidhalter/jedi-vim#i-dont-want-the-docstring-window-to-popup-during-completion
autocmd FileType python,python.django setlocal completeopt-=preview

" jedi-vim things
" By default you get a window that displays the function definition you're currently in.
" If you don't want that:
"let g:jedi#show_call_signatures = 0
"let g:jedi#use_tabs_not_buffers = 0
" Defaults to 1, here to recall in case I want to disable it
"let g:jedi#popup_on_dot = 0

" Colorscheme
set background=dark
" The colorscheme is commented because I didn't decide yet
"let g:solarized_termcolors=256          " Compatibility with terminal emulators
" ZenBurn tweaking
let g:zenburn_high_Contrast = 1
let g:zenburn_force_dark_Background = 1
colorscheme zenburn

" Tweak colors for gitgutter
hi GitGutterAdd guifg=#00ff00 gui=bold
hi GitGutterChange guifg=#ffff00 gui=bold
hi GitGutterDelete guifg=#ff0000 gui=bold
hi GitGutterChangeDelete guifg=#ffa500 gui=bold

" htmldjango-omnicomplete stuff
au FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
let g:htmldjangocomplete_html_flavour = 'html401s'
au FileType htmldjango inoremap {% {% %}<left><left><left>
au FileType htmldjango inoremap {{ {{ }}<left><left><left>

" Gundo configuration
nnoremap <leader>u :GundoToggle<CR>

" Disable syntastic by default, except for a whitelist of formats
" see: https://github.com/scrooloose/syntastic/issues/101
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['python'], 'passive_filetypes': [] }
" Use only tidy and no online service to check HTML
" https://github.com/scrooloose/syntastic/issues/485
let g:syntastic_html_checkers=['tidy']
" Disable annoying pep8 checks
let g:syntastic_python_checkers=['pyflakes']

" Autoreload ~/.vimrc after saving it
" seen here: http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Better line wraps
" seen here: http://www.bestofvim.com/tip/better-line-wraps/
set showbreak=↪

" vim-move
let g:move_key_modifier = 'C'

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'htmldjango': 1,
    \}
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen

" Ctrl-P tweaking
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|o|png|jpg|tar|gz|bz2|xz|zip|rar)$',
  \ }

" YouCompleteMe things
" http://valloric.github.io/YouCompleteMe/
let g:ycm_filetype_whitelist = { 'python': 1, 'python.django': 1, 'html': 1, 'htmldjango': 1, 'javascript': 1, 'sh': 1, 'vim': 1 }

" Use ag with ack.vim, which is waaaaayyyy faster
let g:ackprg = 'ag --nogroup --nocolor --column'

" MiniBufExpl remappings
" F2 go to the previous buffer, F3 go to the next buffer
" F4 go to the previous active buffer, F5 closes active buffer
map <F2> :MBEbp<CR>
map <F3> :MBEbn<CR>
map <F5> :MBEbd<CR>

" Useful standard plugins
:source /usr/share/vim/vim74/macros/matchit.vim      " Smartly match for XML/HTML/XHTML tags
