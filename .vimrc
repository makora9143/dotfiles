let $PATH = "~/.pyenv/shims:".$PATH
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/Users/makora/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/Users/makora/.vim'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('scrooloose/syntastic.git')
call dein#add('Shougo/neomru.vim')

if has('lua') && (( v:version == 703 && has('patch885')) || (v:version >= 704))
  call dein#add('Shougo/neocomplete')
else
  call dein#add('Shougo/neocomplcache')
endif
call dein#add('Shougo/vimfiler')
call dein#add('itchyny/lightline.vim')
call dein#add('Yggdroot/indentLine')
"call dein#add('chriskempson/base16-vim')
call dein#add('davidhalter/jedi-vim', {
      \ "autoload": {
      \  "filetypes": ["python"]
      \ }, 'lazy':1})
call dein#add("lambdalisue/vim-pyenv", {
      \ "depends": ['davidhalter/jedi-vim'],
      \ "autoload": {
      \ "filetypes": ["python"]
      \ }, 'lazy':1})
call dein#add('hdima/python-syntax', {
      \ "autoload": {
      \  "filetypes": ["python"]
      \ }, 'lazy':1})
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('freeo/vim-kalisi')
call dein#add('mattn/benchvimrc-vim.git')
call dein#add('Konfekt/FastFold')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

let python_highlight_all=1
let python_version_2=1
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

command W w
command Q q
command Wq wq

set fileformats=unix,dos
set ambiwidth=double
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set imdisable
autocmd FileType text setlocal textwidth=0

set ignorecase
set smartcase
set incsearch
set nohlsearch
set encoding=utf-8
set notitle
set scrolloff=8
set wildmenu
set wildmode=longest:full,full

set number
set noswapfile
set noundofile
set nobackup
set clipboard=unnamed
set mouse=a
set autoread
set tw=0

set laststatus=2
set showmatch
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set list
set listchars=trail:.
set timeoutlen=200

autocmd FileType python setlocal completeopt-=preview

au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "/Applications/Google Chrome.app"'
let g:tex_conceal=''

"------------------------------------
" VimFiler
"------------------------------------
let g:vimfiler_as_default_explorer = 1
nnoremap <silent><C-e> :VimFiler -buffer-name=explorer -split -winwidth=60 -toggle -no-quit<Cr>
autocmd! FileType vimfiler call s:my_vimfiler_settings()
function! s:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction


let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)


"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"


"------------------------------------
" jedi-vim
"------------------------------------
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"------------------------------------------
" insert mode cursol move
"------------------------------------------
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>


"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"inoremap <Esc> <Esc>


let &t_SI .= "\eP\e[6 q\e\\"
let &t_EI .= "\eP\e[2 q\e\\"

"-------------------------------------------
" neosnippet
"-------------------------------------------
imap <C-b> <Plug>(neosnippet_expand_or_jump)
smap <C-b> <Plug>(neosnippet_expand_or_jump)
xmap <C-b> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='/Users/makora/.vim/snippet'
"-------------------------------------------
" tab config
"-------------------------------------------
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"--------------------------------------
" lightline.vim
" color schemes
"---------------------------
let g:base16_shell_path = expand('~/.config/base16-shell')
"let base16colorspace=256
set t_Co=256
colorscheme kalisi
set background=dark
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' },
      \ 'active': {
      \    'left': [ [ 'mode', 'paste' ],
      \              [ 'pyenv' ],
      \              [ 'fugitive', 'gitgutter', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo',  'syntastic' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'pyenv': 'MyPyenv',
      \   'gitgutter': 'MyGitGutter',
      \ }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return "help"
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
"  return exists('*fugitive#head') ? fugitive#head() : ''
  if exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
  endif
endfunction

function! MyPyenv()
 " return '⌘ '.pyenv#info#preset('long')
  if &filetype == 'python'
    return pyenv#info#format('⌘ %sv %{(|)}iv')
  else
    return ''
  endif
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
  endif
  endfor
  return join(ret, ' ')
endfunction

syntax on
