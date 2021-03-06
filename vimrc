"""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug
call plug#begin('~/.vim/vim_plugins')

" Plugins
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'gorodinskiy/vim-coloresque'
Plug 'flazz/vim-colorschemes'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'othree/html5.vim'
Plug 'Yggdroot/indentLine'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'davidhalter/jedi-vim'
Plug 'mcagl/vim-licenses'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'Valloric/MatchTagAlways'
Plug 'scrooloose/nerdcommenter'
Plug 'alfredodeza/pytest.vim'
Plug 'vim-scripts/python_match.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'kshenoy/vim-signature'
Plug 'luochen1990/rainbow'
Plug 'honza/vim-snippets'
Plug 'rstacruz/sparkup'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-vinegar'
Plug 'gcmt/wildfire.vim'
Plug 'sukima/xmledit'
call plug#end()
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""

" Default file encoding
set encoding=utf8
set fileencoding=utf8

" Default whitespace managing
set ts=4 sts=4 sw=4 expandtab

" https://stackoverflow.com/questions/5774824/vim-how-to-set-filetype-for-none-extension-file-by
set modeline
set modelines=5

" Highlight column. PEP8 80 chars seems a little anacronistic...
set colorcolumn=101
"hi ColorColumn ctermbg=lightgrey guibg=lightgrey

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
autocmd FileType html,xml,htmldjango,javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType makefile setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType tex setlocal wm=3          " Automatically wrap at 3 columns from the window border

" Automatically remove trailing whitespace before saving
" http://stackoverflow.com/a/1618401/1651545
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,html,htmldjango,javascript,rst,markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Various settings
" http://stackoverflow.com/a/2559262/1651545
let mapleader=','                   " <leader> is the comma
set nowrap                          " Don't wrap lines
set scrolloff=2                     " 2 lines above/below cursor when scrolling
set showcmd                         " Shows the command at the bottom of the window
set showmatch                       " Show matching bracket
set matchtime=5                     " Show matching bracket for 0.5 seconds
" Match also < > for html, htmldjango and xml
autocmd FileType html,htmldjango,xml setlocal matchpairs+=<:>
set number                          " Use line numbers
set numberwidth=4                   " Minimum field width for line numbers
set hidden                          " Allow to hid modified buffers
" https://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list,full
set wildmenu
" https://mg.pov.lt/vim/vimrc
set suffixes+=.pyc
set wildignore+=*.pyc
" Better line wraps: http://www.bestofvim.com/tip/better-line-wraps/
set showbreak=↪

" NERDTreeToggle
"map <F9> :NERDTreeToggle<CR>
"map <F10> :NERDTreeFind<CR>

" airline things
set laststatus=2                    " Use 2 lines for the statusbar
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline_exclude_filenames=[]
let g:airline_exclude_filetypes=[]
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

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
let g:jedi#completions_enabled = 1
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 0
" https://github.com/davidhalter/jedi-vim/commit/ac1615c647da766534759ece8b253e3a6dd543ee
let g:jedi#smart_auto_mappings = 0

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Colorscheme
syntax enable
set background=dark
" solarized badwolf kolor
colorscheme desert256

" Tweak colors for gitgutter
hi GitGutterAdd ctermfg=green guifg=#00ff00 gui=bold
hi GitGutterChange ctermfg=yellow guifg=#ffff00 gui=bold
hi GitGutterDelete ctermfg=red guifg=#ff0000 gui=bold
hi GitGutterChangeDelete ctermfg=yellow guifg=#ffa500 gui=bold
nmap <leader>m <Plug>GitGutterPrevHunk
nmap <leader>. <Plug>GitGutterNextHunk

" Disable syntastic by default, except for a whitelist of formats
" see: https://github.com/scrooloose/syntastic/issues/101
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['python', 'sh'], 'passive_filetypes': [] }
" Use only tidy and no online service to check HTML
" https://github.com/scrooloose/syntastic/issues/485
let g:syntastic_html_checkers=['tidy']
" Disable annoying pep8 checks
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_sh_checkers=['shellcheck']

" Autoreload ~/.vimrc after saving it
" seen here: http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

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

map <F2> :bprevious<CR>
map <F3> :bnext<CR>
map <F4> :bdelete<CR>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" UltiSnips things
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]

" To avoid having personal data pushed to remote public repositories
:source ~/.vim/private_settings_do_not_commit.vim

" http://askubuntu.com/questions/2140/is-there-a-way-to-turn-gvim-into-fullscreen-mode
" http://www.windowslinuxosx.com/q/answers-how-can-i-open-gvim-in-full-screen-mode-in-gnome-264693.html
map <silent> <F12> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
set guioptions-=T guioptions-=m

" Trying to fix vim bad performance wrt scrolling when many big files are open
" https://stackoverflow.com/questions/307148/vim-scrolling-slowly
set ttyfast
set lazyredraw

" Disable ZZ
nnoremap ZZ <nop>

" Other remaps
" Selects last inserted text
noremap <leader>l `[v`]

" http://vim.wikia.com/wiki/Fix_syntax_highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Rainbow
" Disabled by default
let g:rainbow_active = 0
" Toggle it
noremap <leader>R <Esc>:RainbowToggle<CR>

" Move through windows with CTRL + arrows
nnoremap <silent> <C-left> <C-W>h
nnoremap <silent> <C-right> <C-W>l
nnoremap <silent> <C-up> <C-W>k
nnoremap <silent> <C-down> <C-W>j

" Use ripgrep with ack.vim
let g:ackprg = 'rg --column --no-heading --vimgrep'

" FZF options
" nmap <C-p> :FZF<CR>
" https://stackoverflow.com/a/51457124
silent! nmap <C-p> :GFiles<CR>
nmap <leader>f :Files<CR>
" This needs fugitive to work
nmap <leader>c :Commits<CR>

" vim-markdown-preview things
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_use_xdg_open=1
let vim_markdown_preview_pandoc=1
