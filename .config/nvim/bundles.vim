"{{{ User Interface
"{{{ Icons
Plug 'ryanoasis/vim-devicons'
"}}}
"{{{themes
Plug 'gruvbox-material/vim', { 'as': 'gruvbox-material' }
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/vim-color-forest-night'
"}}}
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'macthecadillac/lightline-gitdiff'
Plug 'maximbaz/lightline-ale'
Plug 'albertomontesg/lightline-asyncrun'
Plug 'tricktux/vim-pomodoro'
Plug 'sainnhe/artify.vim'
Plug 'sainnhe/tmuxline.vim', { 'on': [ 'Tmuxline', 'TmuxlineSnapshot' ] }
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
"}}}

" Completion {{{ "
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-denite'
Plug 'Shougo/echodoc.vim'
" }}} "

" Util {{{ "
Plug 'Shougo/denite.nvim' 
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree' | Plug 'tiagofumo/vim-nerdtree-syntax-highlight' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'unkiwii/vim-nerdtree-sync'
Plug 'tpope/vim-eunuch'
Plug 'vim-scripts/grep.vim'
Plug 'vim-scripts/tinymode.vim'
Plug 'lambdalisue/suda.vim'
Plug 'editorconfig/editorconfig-vim'
" }}} "

" Git {{{ "
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
" }}} "

" Snippet {{{ "
Plug 'honza/vim-snippets'
" }}} "

" Editing {{{ "
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'andymass/vim-matchup'
Plug 'easymotion/vim-easymotion'
" }}} "

" Syntax {{{ "
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/vim-jsx-improve'
Plug 'sheerun/vim-polyglot'
" }}} "
