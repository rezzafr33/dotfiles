" Airline {{{ "
  " extensions
  let g:airline_extensions = ['branch', 'hunks', 'coc']
  let g:airline#extensions#coc#enabled = 1

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

    " powerline symbols {{{ "
      let g:airline_left_sep = ''
      let g:airline_left_alt_sep = ''
      let g:airline_right_sep = ''
      let g:airline_right_alt_sep = ''
      let g:airline_symbols.branch = ''
      let g:airline_symbols.readonly = ''
      let g:airline_symbols.linenr = ''
    " }}} "
  endif

  " airline {{{ "
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#ale#error_symbol = ''
    let g:airline#extensions#ale#warning_symbol = ''
    let g:airline#extensions#coc#warning_symbol = ''
    let g:airline#extensions#coc#error_symbol = ''
    let g:airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
    let g:airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#tmuxline#snapshot_file = "~/.tmux/tmux-statusline-colors.conf"
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline_powerline_fonts = 1
  " }}} "

  " coc {{{ "
    let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
  " }}} "

  " custom {{{ "
  " }}} "
" }}} Airline "

" COC {{{ "
  " Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode {{{ "
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    
    let g:coc_snippet_next = '<tab>'
  " }}} "

  " Setup Prettier command
    command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

  " Use <c-space>for trigger completion
    inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm complete
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` to navigate diagnostics {{{ "
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)
  " }}} "

  " Remap keys for gotos {{{ "
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
  " }}} "

  " Use K to show documentation in preview window {{{ "
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
  " }}} "

  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')
" }}} COC "

" Color {{{ "
  set background=dark
  colorscheme gruvbox
  " MatchParen {{{ "
    hi MatchParen guifg=red ctermfg=red guibg=none ctermbg=none cterm=italic,underline gui=italic,underline
    augroup matchup_matchparen_highlight
      autocmd!
      autocmd ColorScheme * hi MatchParen guifg=red ctermfg=red guibg=none ctermbg=none cterm=italic,underline gui=italic,underline
    augroup END
  " }}} "
" }}} Color "

" Denite {{{ "
  call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--follow', '--glob', '!.git'])
  call denite#custom#var('buffer', 'date_format', '')
  let s:denite_options = {'default' : {
        \ 'auto_resize': 1,
        \ 'prompt': '  ',
        \ 'direction': 'rightbelow',
        \ 'winminheight': '10',
        \ 'highlight_mode_insert': 'Visual',
        \ 'highlight_mode_normal': 'Visual',
        \ 'prompt_highlight': 'Function',
        \ 'highlight_matched_char': 'Function',
        \ 'highlight_matched_range': 'Normal'
        \ }}
  " Loop through denite options and enable them
  function! s:profile(opts) abort
    for l:fname in keys(a:opts)
      for l:dopt in keys(a:opts[l:fname])
        call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
      endfor
    endfor
  endfunction

  call s:profile(s:denite_options)
" }}} Denite "

" Echodoc {{{ "
  let g:echodoc#enable_at_startup = 1
" }}} Echodoc "

" Font {{{ "
  set guifont=FuraCode\ Nerd\ Font\ Mono\ Medium\ 13
  set encoding=utf-8
" }}} Font "

" FZF {{{ "
  set wildmode=list:longest,list:full
  set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
  let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

  " With preview {{{ "
    command! -bang -nargs=? -complete=dir Files
          \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout', 'reverse']} ,'right:50%:hidden', '?'), <bang>0)
  " }}} With preview "

  " FloatingFZF {{{ "
    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    function! FloatingFZF()
      let buf = nvim_create_buf(v:false, v:true)
      call setbufvar(buf, '&signcolumn', 'no')

      let height = float2nr(&lines - (&lines * 3 / 10))
      let width = float2nr(&columns - (&columns * 3 / 10))
      let col = float2nr((&columns - width) / 2)

      let opts = {
            \ 'relative': 'editor',
            \ 'row': 1,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height
            \ }

      call nvim_open_win(buf, v:true, opts)
    endfunction
  " }}} FloatingFZF "

  nnoremap <silent> <leader>t :Tags<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  nnoremap <silent> <leader>e :Files<CR>

  " The Silver Searcher {{{ "
    if executable('ag')
      let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
      set grepprg=ag\ --nogroup\ --nocolor
    endif
  " }}} "

  " ripgrep {{{ "
    if executable('rg')
      let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
      set grepprg=rg\ --vimgrep
      command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
    endif
  " }}} "
" }}} FZF "

" Grep {{{ "
  let Grep_Default_Options = '-IR'
  let Grep_Skip_Files = '*.log *.db'
  let Grep_Skip_Dirs = '.git node_modules'
  nnoremap <silent> <leader>f :Rgrep<CR>
" }}} Grep "

" JsonC {{{ "
  autocmd FileType json syntax match Comment +\/\/.\+$+
" }}} JsonC "

" Tsx {{{ "
  au BufNewFile,BufRead *.ts setlocal filetype=typescript
  au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" }}} Tsx

" NERDTree {{{ "
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

  "" NERDTree syntax highlighting {{{ "
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
  " }}} "
" }}} NERDTree "

" Tiny Mode {{{ "
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
" }}} Tiny Mode "

" Tmux Navigator {{{ "
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" }}} Tmux Navigator "

" Term {{{ "
  augroup TerminalStuff
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END
" }}} Term "
