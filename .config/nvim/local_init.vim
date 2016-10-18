" Mouse support
set mouse=a

" Splits
set splitbelow
set splitright

" Paste in new line
nmap <S-p> :pu<CR>

" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_java_javac_classpath = '/home/jefri/android/android-sdk/platforms/android-24/*.jar'

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

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|(bower_components|node_modules|build)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_use_ultisnips_completer = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_key_list_select_completion = ['<Down>', '<Enter>']
let g:ycm_error_symbol = 'e>'
let g:ycm_warning_symbol = 'w>'
let g:ycm_seed_identifiers_with_syntax = 1

" Syntastic
let g:syntastic_auto_loc_list=0
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_phpcs_args = '--standard="WordPress-Extra"'

" vim-javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

" vim-flow
let g:flow#autoclose=1

" color scheme
colorscheme monokai

" vim android
let g:android_sdk_path='/home/jefri/android/android-sdk/'

" vim javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
