"----------------------------------------
" Installation of vundle and plugins
"----------------------------------------
" Following lines of code will install vundle plugin if it is not already
" installed. After vundle is inatlled, all the plugins listed below will 
" be installed automatically
let firstTime=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle 
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    let firstTime=1
endif
"Bundle config.
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"------------------
" Code Completions Plugins
"------------------
Bundle 'garbas/vim-snipmate'
Bundle 'ervandew/supertab'
Bundle 'mattn/zencoding-vim'
Bundle 'Raimondi/delimitMate'
"------ snipmate dependencies -------
Bundle 'honza/snipmate-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
" OmnicppComplete for c++ completion using omnicomplete
Bundle "vim-scripts/OmniCppComplete"
"-----------------
" Other Usuful Plugins
"-----------------
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

"----------------------------------------
" Syntax or Indent Supports
"----------------------------------------
"------- backend ---------
Bundle '2072/PHP-Indenting-for-VIm'
Bundle 'tpope/vim-rails'
Bundle 'lepture/vim-jinja'

"------- frontend ----------
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'nono/jquery.vim'
Bundle 'wavded/vim-stylus'

"--------------
" Color Schemes
"--------------
Bundle 'vim-scripts/xoria256.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rickharris/vim-monokai'

"If this is first time installing vundle, install all plugins as well 
if firstTime
    echo "Installing Bundles..."
    echo ""
    :BundleInstall
endif

"------------------------------------------------"
"           My vim Configuration
"------------------------------------------------"           
" enable filetype detection for specific plugin and indent
filetype plugin indent on     " required!

" enable syntax hightlight
syntax on

" color scheme
colorscheme xoria256 

" display line numbers
set nu
set ruler

" Indentation Setup
set expandtab  
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent
set smarttab
set smartindent

autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" enable mouse cursor
""set mouse=a

" JQuery syntax support
autocmd Syntax javascript set syntax=jquery

" html(css) indent support
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" Auto Complete Setup
" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=15
" Omni Completion Setup.
" set omnifunc for all languages supported by syntax highlighting
set ofu=syntaxcomplete#Complete

"------------------------------------------------"
"           Plugin Settings
"------------------------------------------------"           

"--------Auto Completion Settings-------
" DelimitMate
" enable expand_cr option
let delimitMate_expand_cr = 1

" SuperTab
let g:SuperTabCrMapping = 0 " disable it to avoide compatibility issue with DelimitMate
let g:SuperTabDefultCompletionType = 'context'
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-x><c-n>") |
    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    \ endif

"------------------------------------------

" Indent Guide
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey   ctermbg=232
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey ctermbg=233
let g:indent_guides_guide_size = 1

" Keybindings for Plugin toggle
nmap <F6> :NERDTreeToggle<cr>
nmap <F7> :IndentGuidesToggle<cr>

"------------------------------------------------"
"                  Useful Functions
"------------------------------------------------"           
" update ctags used for omniCppComplete.(requires Exuberant Ctags 5.7+)
" brew install ctags-exuberant (required)
function! UpdateTags()
    execute ":!ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
    execute ":redraw!"
    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
nnoremap <F10> :call UpdateTags()
