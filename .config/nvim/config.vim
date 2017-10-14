"" Theme
color dracula

set guifont=UbuntuMono\ Nerd\ Font\ Regular\ 11
set encoding=utf-8

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__', '\.so$', '\.o$']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

"" NERDTree syntax highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>

"" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"" Ale
let g:ale_linters = {'javascript': ['eslint', 'flow']}
let g:ale_linters = {'c': [ 'gcc', 'clang' ] }
let _c_compiler_options = '-I/usr/local/include '.
  \ '-I/usr/include/x86_64-linux-gnu '.
  \ '-I/usr/include '.
  \ '-I/usr/include/gtk-3.0 '.
  \ '-I/usr/include/at-spi2-atk/2.0 '.
  \ '-I/usr/include/at-spi-2.0 '.
  \ '-I/usr/include/dbus-1.0 '.
  \ '-I/usr/lib/x86_64-linux-gnu/dbus-1.0/include '.
  \ '-I/usr/include/gtk-3.0 '.
  \ '-I/usr/include/gio-unix-2.0/ '.
  \ '-I/usr/include/mirclient '.
  \ '-I/usr/include/mircore '.
  \ '-I/usr/include/mircookie '.
  \ '-I/usr/include/cairo '.
  \ '-I/usr/include/pango-1.0 '.
  \ '-I/usr/include/harfbuzz '.
  \ '-I/usr/include/pango-1.0 '.
  \ '-I/usr/include/atk-1.0 '.
  \ '-I/usr/include/cairo '.
  \ '-I/usr/include/pixman-1 '.
  \ '-I/usr/include/freetype2 '.
  \ '-I/usr/include/libpng16 '.
  \ '-I/usr/include/gdk-pixbuf-2.0 '.
  \ '-I/usr/include/libpng16 '.
  \ '-I/usr/include/glib-2.0 '.
  \ '-I/usr/lib/x86_64-linux-gnu/glib-2.0/include'

let g:ale_c_gcc_options = '-Wall '.
  \ '-Wextra '.
  \ '-Werror '.
  \ '-Wno-long-long '.
  \ '-Wno-variadic-macros '.
  \ '-Wno-unused-parameter '.
  \ '-fexceptions '.
  \ '-std=c99 '.
  \ _c_compiler_options

let g:ale_c_clang_options = '-Wall '.
  \ '-Wextra '.
  \ '-Werror '.
  \ '-Wno-long-long '.
  \ '-Wno-variadic-macros '.
  \ '-Wno-unused-parameter '.
  \ '-fexceptions '.
  \ '-DNDEBUG '.
  \ '-std=c11 '. 
  \ '-x c ' . 
  \ '-I/usr/lib/llvm-4.0/lib/clang/4.0.1/include '.
  \ _c_compiler_options

let g:ale_fix_on_save=1
let g:ale_fixers = {
  \ 'javascript': [ 'eslint', 'prettier_eslint', 'remove_trailing_lines' ],
  \ 'typescript': [ 'prettier', 'remove_trailing_lines' ],
  \ 'c': [ 'clang-format', 'remove_trailing_lines' ],
  \ 'cpp': [ 'clang-format', 'remove_trailing_lines' ],
  \ 'h': [ 'clang-format', 'remove_trailing_lines' ],
  \ 'hpp': [ 'clang-format', 'remove_trailing_lines' ],
\}

"" shortcut
nmap <F8> <Plug>(ale_fix)
nmap <leader>ad <Plug>(ale_detail)
nmap <leader>af <Plug>(ale_fix)
nmap <leader>al <Plug>(ale_lint)
nmap <leader>an <Plug>(ale_next)
nmap <leader>ap <Plug>(ale_previous)

" airline 
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = '✗'
let g:airline#extensions#ale#warning_symbol = '⚠'
" error/warning sign & message
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"" tern
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_request_timeout = 1
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#ternjs#filetypes = [
  \ 'jsx',
  \ 'javascript.jsx',
  \ 'vue',
  \ '...'
\]
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1

let g:deoplete#sources = {}
let g:deoplete#sources['javascript'] = ['file', 'buffer', 'ultisnips', 'ternjs']
let g:deoplete#file#enable_buffer_path = 1

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni',
  \ 'javascriptcomplete#CompleteJS'
\]

call deoplete#custom#source('ultisnips', 'rank', 1000)
call deoplete#custom#source('_', 'matchers', ['matcher_head'])
call deoplete#custom#source('_', 'sorters', ['sorter_word'])

" Ycm
let g:ycm_filetype_whitelist = { 'cpp' : 1, 'c' : 1, 'h' : 1, 'hpp' : 1 }
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

"" Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"" vim-airline
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

"" vim-jsx
let g:jsx_ext_required = 1

"" Tiny Mode
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

"" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType c,cpp,h,hpp let b:deoplete_disable_auto_complete=1
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end
