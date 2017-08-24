set encoding=utf8
"set guifont=Fira\ Mono\ Regular\ for\  Nerd\ Font\ Complete:10

" color scheme
" colorscheme default "monokai
set background=dark
colorscheme solarized

" Mouse support
set mouse=a

" Set clipboard support
set clipboard=unnamedplus

" Splits
set splitbelow
set splitright

"" Close buffer
noremap <leader>cc :bd!<CR>

" NERDTree
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.so$', '\.o$']
let g:NERDTreeWinSize = 30

" Default FZF command
let $FZF_DEFAULT_COMMAND = 'ag -U --hidden --ignore={.git,node_modules} -g ""'

" Paste in new line
nmap <S-p> :pu<CR>

" Ctags
set tags+=~/.config/nvim/tags/**/*.tags

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" AsyncRun
noremap <F8> :call asyncrun#quickfix_toggle(8)<cr>

" Tiny Mode
call tinymode#EnterMap("winsize", "<C-W>+", "+")
call tinymode#EnterMap("winsize", "<C-W>-", "-")
call tinymode#EnterMap("winsize", "<C-W>>", ">")
call tinymode#EnterMap("winsize", "<C-W><", "<")
call tinymode#Map("winsize", "+", "wincmd +")
call tinymode#Map("winsize", "-", "wincmd -")
call tinymode#Map("winsize", ">", "wincmd >")
call tinymode#Map("winsize", "<", "wincmd <")
call tinymode#ModeArg("winsize", "owncount", 1)
call tinymode#Map("winsize", "+", "[N]wincmd +")
call tinymode#Map("winsize", "-", "[N]wincmd -")
call tinymode#ModeMsg("winsize", "Change window size +/-")

" Incremental number
function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <c-m> :call Incr()<CR>

au! completion_preview_close

" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsUsePythonVersion = 2
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni',
  \ 'javascriptcomplete#CompleteJS'
\]
set completeopt=longest,menuone,preview
"set completeopt-=preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['file', 'ultisnips', 'ternjs']
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
autocmd FileType javascript,javascript.jsx let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-space>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Jsx
let g:jsx_ext_required = 0

" Use deoplete.
let g:tern_request_timeout = 1
"let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#depths = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#include_keywords = 1

" Fixmyjs
let g:fixmyjs_use_local = 1
let g:fixmyjs_rc_filename = ['.eslintrc', '.eslintrc.json', '.eslintrc.js']

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_phpcs_args = '--standard="WordPress"'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_cpp_checkers = ['clang_check']
"let g:syntastic_c_no_include_search = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_java_javac_classpath = '/home/jefri/Development/android-sdk/platforms/android-25/*.jar'

" vim android
let g:android_sdk_path='/home/jefri/Development/android-sdk'

" vim-flow
let g:flow#autoclose=1

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'distinguished'
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

" dasht
let g:dasht_filetype_docsets = {}
let g:dasht_filetype_docsets['blade'] = ['html', 'php']
let g:dasht_filetype_docsets['java'] = ['^spring_', 'hibernate']
let g:dasht_filetype_docsets['c'] = ['^c$', 'glib', 'gdk3', 'gtk3', 'libgda', 'pango', 'gobject', 'gio']
let g:dasht_filetype_docsets['cpp'] = ['^c$', 'glib', 'gdk3', 'gtk3', 'libgda', 'pango', 'gobject', 'gio']
let g:dasht_filetype_docsets['javascript'] = ['react', 'react_native']
let g:dasht_filetype_docsets['javascript.jsx'] = ['react', 'react_native']

" search related docsets
nnoremap <silent> gz :call Dasht([expand('<cWORD>'), expand('<cword>')])<Return>
" search ALL the docsets
nnoremap <silent> gZ :call Dasht([expand('<cWORD>'), expand('<cword>')], '!')<Return>
" search related docsets
vnoremap <silent> gz y:<C-U>call Dasht(getreg(0))<Return>
" search ALL the docsets
vnoremap <silent> gZ y:<C-U>call Dasht(getreg(0), '!')<Return>

" autocmd group
augroup vimrc
  autocmd!
  autocmd FileType javascript,javascript.jsx setlocal tabstop=2 shiftwidth=2 expandtab softtabstop=2
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType qf setlocal wrap
  autocmd FileType java setlocal omnifunc=javacomplete#Complete "vim javacomplete2
  autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

