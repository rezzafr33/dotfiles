" Ruby rvm {{{ "
  let g:ruby_host_prog = 'rvm system do neovim-ruby-host'
" }}}"

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
  let g:NERDTreeHighlightCursorline = 1

  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
  nnoremap <silent> <F2> :NERDTreeFind<CR>
  noremap <F3> :NERDTreeToggle<CR>

  "" NERDTree syntax highlighting {{{ "
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
  " }}} "

  "" NERDTree sync with currently opened file {{{ "
  let g:nerdtree_sync_cursorline = 1
  " }}} "

  "https://github.com/junegunn/fzf/issues/453#issuecomment-583834210
  autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
  autocmd BufWinEnter * call PreventBuffersInNERDTree()

  function! PreventBuffersInNERDTree()
    if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
      \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
      \ && &buftype == '' && !exists('g:launching_fzf')
      let bufnum = bufnr('%')
      close
      exe 'b ' . bufnum
      NERDTree
    endif
    if exists('g:launching_fzf') | unlet g:launching_fzf | endif
  endfunction

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

" User Interface
"{{{lightline.vim
"{{{functions
function! PomodoroStatus() abort"{{{
  if pomo#remaining_time() <=# '0'
    return "\ue001"
  else
    return "\ue003 ".pomo#remaining_time()
  endif
endfunction"}}}
function! CocCurrentFunction()"{{{
  return get(b:, 'coc_current_function', '')
endfunction"}}}
function! Devicons_Filetype()"{{{
  " return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction"}}}
function! Devicons_Fileformat()"{{{
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction"}}}
function! Artify_active_tab_num(n) abort"{{{
  return Artify(a:n, 'bold')." \ue0bb"
endfunction"}}}
function! Tab_num(n) abort"{{{
  return a:n." \ue0bb"
endfunction"}}}
function! Gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return gitbranch#name()." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
function! Artify_inactive_tab_num(n) abort"{{{
  return Artify(a:n, 'double_struck')." \ue0bb"
endfunction"}}}
function! Artify_lightline_tab_filename(s) abort"{{{
  return Artify(lightline#tab#filename(a:s), 'monospace')
endfunction"}}}
function! Artify_lightline_mode() abort"{{{
  return Artify(lightline#mode(), 'monospace')
endfunction"}}}
function! Artify_line_percent() abort"{{{
  return Artify(string((100*line('.'))/line('$')), 'bold')
endfunction"}}}
function! Artify_line_num() abort"{{{
  return Artify(string(line('.')), 'bold')
endfunction"}}}
function! Artify_col_num() abort"{{{
  return Artify(string(getcurpos()[2]), 'bold')
endfunction"}}}
function! Artify_gitbranch() abort"{{{
  if gitbranch#name() !=# ''
    return Artify(gitbranch#name(), 'monospace')." \ue725"
  else
    return "\ue61b"
  endif
endfunction"}}}
"}}}
augroup lightlineCustom
  autocmd!
  autocmd BufWritePost * call lightline_gitdiff#query_git() | call lightline#update()
augroup END
let g:lightline = {}
let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf529"
let g:lightline#ale#indicator_errors = "\uf00d"
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline_gitdiff#indicator_added = '+'
let g:lightline_gitdiff#indicator_deleted = '-'
let g:lightline_gitdiff#indicator_modified = '*'
let g:lightline_gitdiff#min_winwidth = '70'
let g:lightline#asyncrun#indicator_none = ''
let g:lightline#asyncrun#indicator_run = 'Running...'
let g:lightlineArtify = 1
if g:lightlineArtify == 1
  let g:lightline.active = {
        \ 'left': [ [ 'artify_mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'artify_lineinfo' ],
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'artify_lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'artify_gitbranch' ],
        \ [ 'gitstatus' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'artify_activetabnum', 'artify_filename', 'modified' ],
        \ 'inactive': [ 'artify_inactivetabnum', 'filename', 'modified' ] }
else
  let g:lightline.active = {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'filename', 'modified', 'fileformat', 'devicons_filetype' ] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'pomodoro' ],
        \           [ 'asyncrun_status', 'coc_status' ] ]
        \ }
  let g:lightline.inactive = {
        \ 'left': [ [ 'filename' , 'modified', 'fileformat', 'devicons_filetype' ]],
        \ 'right': [ [ 'lineinfo' ] ]
        \ }
  let g:lightline.tabline = {
        \ 'left': [ [ 'vim_logo', 'tabs' ] ],
        \ 'right': [ [ 'gitbranch' ],
        \ [ 'gitstatus' ] ]
        \ }
  let g:lightline.tab = {
        \ 'active': [ 'tabnum', 'filename', 'modified' ],
        \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
endif
let g:lightline.tab_component = {
      \ }
let g:lightline.tab_component_function = {
      \ 'artify_activetabnum': 'Artify_active_tab_num',
      \ 'artify_inactivetabnum': 'Artify_inactive_tab_num',
      \ 'artify_filename': 'Artify_lightline_tab_filename',
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'Tab_num'
      \ }
let g:lightline.component = {
      \ 'artify_gitbranch' : '%{Artify_gitbranch()}',
      \ 'artify_mode': '%{Artify_lightline_mode()}',
      \ 'artify_lineinfo': "%2{Artify_line_percent()}\uf295 %3{Artify_line_num()}:%-2{Artify_col_num()}",
      \ 'gitstatus' : '%{lightline_gitdiff#get_status()}',
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue7c5",
      \ 'pomodoro': '%{PomodoroStatus()}',
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'percent': '%2p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%2p%% %3l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}'
      \ }
let g:lightline.component_function = {
      \ 'gitbranch': 'Gitbranch',
      \ 'devicons_filetype': 'Devicons_Filetype',
      \ 'devicons_fileformat': 'Devicons_Fileformat',
      \ 'coc_status': 'coc#status',
      \ 'coc_currentfunction': 'CocCurrentFunction'
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'asyncrun_status': 'lightline#asyncrun#status'
      \ }
let g:lightline.component_type = {
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error'
      \ }
let g:lightline.component_visible_condition = {
      \ 'gitstatus': 'lightline_gitdiff#get_status() !=# ""'
      \ }
"}}}
"{{{tmuxline.vim
if g:vimIsInTmux == 1
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '%R',
        \'c'    : [ '#{sysstat_mem} #[fg=blue]\ufa51#{upload_speed}' ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : [ "#[fg=blue]#{download_speed} \uf6d9 #{sysstat_cpu}" ],
        \'y'    : [ '%a' ],
        \'z'    : '#H #{prefix_highlight}'
        \}
  let g:tmuxline_separators = {
        \ 'left' : "\ue0bc",
        \ 'left_alt': "\ue0bd",
        \ 'right' : "\ue0ba",
        \ 'right_alt' : "\ue0bd",
        \ 'space' : ' '}
endif
"}}}
"{{{colorscheme
let g:vimColorScheme = 'Gruvbox Material Dark'
let g:colorSchemeList = {}
let g:colorSchemeList['Forest Night'] = [
      \   'set background=dark',
      \   'let g:forest_night_enable_italic = 1',
      \   'let g:forest_night_disable_italic_comment = 1',
      \   'colorscheme forest-night',
      \   'call SwitchLightlineColorScheme("forest_night")'
      \   ]
let g:colorSchemeList['Gruvbox Material Dark'] = [
      \   'set background=dark',
      \   "let g:gruvbox_material_background = 'medium'",
      \   "let g:gruvbox_material_visual = 'grey background'",
      \   'let g:gruvbox_material_enable_italic = 1',
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
let g:colorSchemeList['Gruvbox Material Light'] = [
      \   'set background=light',
      \   "let g:gruvbox_material_background = 'soft'",
      \   "let g:gruvbox_material_visual = 'green background'",
      \   'let g:gruvbox_material_enable_italic = 1',
      \   'let g:gruvbox_material_disable_italic_comment = 1',
      \   'colorscheme gruvbox-material',
      \   'call SwitchLightlineColorScheme("gruvbox_material")'
      \   ]
let g:colorSchemeList['Edge Dark'] = [
      \   'set background=dark',
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge")'
      \   ]
let g:colorSchemeList['Edge Light'] = [
      \   'set background=light',
      \   'let g:edge_disable_italic_comment = 1',
      \   'let g:edge_enable_italic = 1',
      \   'colorscheme edge',
      \   'call SwitchLightlineColorScheme("edge")'
      \   ]
let g:colorSchemeList['Sonokai Shusia'] = [
      \   "let g:sonokai_style = 'shusia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Andromeda'] = [
      \   "let g:sonokai_style = 'andromeda'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Atlantis'] = [
      \   "let g:sonokai_style = 'atlantis'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
let g:colorSchemeList['Sonokai Maia'] = [
      \   "let g:sonokai_style = 'maia'",
      \   'let g:sonokai_disable_italic_comment = 1',
      \   'let g:sonokai_enable_italic = 1',
      \   'colorscheme sonokai',
      \   'call SwitchLightlineColorScheme("sonokai")'
      \   ]
"{{{Functions
function SwitchLightlineColorScheme(lightlineName) abort
  execute join(['source', globpath(&runtimepath, join(['autoload/lightline/colorscheme/', a:lightlineName, '.vim'], ''), 0, 1)[0]], ' ')
  let g:lightline.colorscheme = a:lightlineName
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
function SwitchColorScheme(name) abort
  for l:item in g:colorSchemeList[a:name]
    execute l:item
  endfor
endfunction
function! s:Colo(a, l, p)
  return keys(g:colorSchemeList)
endfunction
command! -bar -nargs=? -complete=customlist,<sid>Colo Colo call SwitchColorScheme(<f-args>)
call SwitchColorScheme(g:vimColorScheme)
"}}}
"}}}
"{{{vim-hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']  " ['virtual', 'sign_column', 'background', 'foreground', 'foregroundfull']
let g:Hexokinase_ftAutoload = ['html', 'css', 'javascript', 'vim', 'colortemplate', 'json', 'yaml', 'toml']  " ['*']
let g:Hexokinase_refreshEvents = ['BufWritePost']
let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba']  " ['full_hex', 'triple_hex', 'rgb', 'rgba', 'colour_names']
nnoremap <silent> <leader><space>H :<c-u>HexokinaseToggle<cr>
"}}}

"{{{pomodoro.vim
let g:Pomodoro_Status = 0
function! Toggle_Pomodoro()
  if g:Pomodoro_Status == 0
    let g:Pomodoro_Status = 1
    execute 'PomodoroStart'
  elseif g:Pomodoro_Status == 1
    let g:Pomodoro_Status = 0
    execute 'PomodoroStop'
  endif
endfunction
let g:pomodoro_time_work = 25
let g:pomodoro_time_slack = 5
nnoremap <silent> <leader><space>P :<c-u>call Toggle_Pomodoro()<cr>
"}}}

