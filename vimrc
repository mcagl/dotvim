"""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle things
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
set rtp+=~/.vim/bundle/neobundle.vim

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Bundles
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'fholgado/minibufexpl.vim'
NeoBundle 'gcmt/wildfire.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'JarrodCTaylor/vim-python-test-runner'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'python_match.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'rstacruz/sparkup'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'sukima/xmledit'
NeoBundle 'tommcdo/vim-exchange'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jnurmine/Zenburn'
filetype plugin indent on
NeoBundleCheck
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
" https://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu

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

" Jedi things
" Disable docstring popup (hopefully...)
" Found here: https://github.com/davidhalter/jedi-vim#i-dont-want-the-docstring-window-to-popup-during-completion
autocmd FileType python,python.django setlocal completeopt-=preview
let g:jedi#popup_on_dot = 0
" https://github.com/Shougo/neocomplete.vim/issues/18
let g:jedi#completions_enabled = 1
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
"let g:jedi#auto_vim_configuration = 0
" http://kozo2.hatenablog.com/entry/2014/01/22/050714
"let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Colorscheme
set background=dark
" ZenBurn tweaking
"let g:zenburn_high_Contrast = 1
"let g:zenburn_force_dark_Background = 1
"colorscheme zenburn
" Solarized
syntax enable
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized

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
"let g:ycm_filetype_whitelist = { 'python': 1, 'python.django': 1, 'html': 1, 'htmldjango': 1, 'javascript': 1, 'sh': 1, 'vim': 1 }

" MiniBufExpl remappings
" F2 go to the previous buffer, F3 go to the next buffer
" F4 go to the previous active buffer, F5 closes active buffer
map <F2> :MBEbp<CR>
map <F3> :MBEbn<CR>
map <F5> :MBEbd<CR>

" vim-python-test-runner things
nnoremap<Leader>da :DjangoTestApp<CR>
nnoremap<Leader>df :DjangoTestFile<CR>
nnoremap<Leader>dc :DjangoTestClass<CR>
nnoremap<Leader>dm :DjangoTestMethod<CR>
nnoremap<Leader>nf :NosetestFile<CR>
nnoremap<Leader>nc :NosetestClass<CR>
nnoremap<Leader>nm :NosetestMethod<CR>
nnoremap<Leader>rr :RerunLastTests<CR>

" Neocomplete things
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,htmldjango,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python,python.django setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
let g:neocomplete#enable_auto_select = 0

" Neosnippets things
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Useful standard plugins
:source /usr/share/vim/vim74/macros/matchit.vim      " Smartly match for XML/HTML/XHTML tags

" http://askubuntu.com/questions/2140/is-there-a-way-to-turn-gvim-into-fullscreen-mode
" http://www.windowslinuxosx.com/q/answers-how-can-i-open-gvim-in-full-screen-mode-in-gnome-264693.html
map <silent> <F12> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
set guioptions-=T guioptions-=m
