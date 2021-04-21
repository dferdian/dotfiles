let mapleader = "\<Space>"

function! s:SourceConfigFilesIn()
  let directory_splat = '~/.config/nvim/files/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
        execute 'source' config_file
    endif
  endfor
endfunction

call s:SourceConfigFilesIn()

let g:python3_host_prog = '/usr/local/bin/python3'

" #############################################
"  Airline
" #############################################

let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1

" #############################################
"  ALE Lint
" #############################################

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_style_error = '•'
let g:ale_sign_style_warning = '•'
let g:ale_sign_info = 'ℹ'
let g:ale_fix_on_save = 1

" #############################################
"  vim-test
" #############################################

let test#strategy = "neoterm"
let g:test#runner_commands = ["RSpec", "Minitest", "Mocha"]

function! RunTest(cmd)
   :Topen " Opens the neoterm window
   call neoterm#normal('G') " Scroll to the end of the neoterm window
   exec a:cmd
endfunction

nmap <silent> <leader>t :call RunTest('TestNearest')<CR>
nmap <silent> <leader>T :call RunTest('TestFile')<CR>
nmap <silent> <leader>a :call RunTest('TestSuite')<CR>
nmap <silent> <leader>l :call RunTest('TestLast')<CR>
nmap <silent> <leader>g :call RunTest('TestVisit')<CR>

" #############################################
"  Seeing Is Believing
" #############################################

let g:xmpfilter_cmd = "seeing_is_believing"

" auto insert mark at appropriate spot.
autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby xmap <buffer> <F5> <Plug>(seeing_is_believing-run)
autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing_is_believing-run)

autocmd FileType ruby nmap <buffer> <F6> <Plug>(seeing_is_believing-mark)
autocmd FileType ruby xmap <buffer> <F6> <Plug>(seeing_is_believing-mark)
autocmd FileType ruby imap <buffer> <F6> <Plug>(seeing_is_believing-mark)

autocmd FileType ruby nmap <buffer> <F7> <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby xmap <buffer> <F7> <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby imap <buffer> <F7> <Plug>(seeing_is_believing-run_-x)

autocmd FileType ruby nmap <buffer> <F8> <Plug>(seeing-is-believing-mark-and-run)
autocmd FileType ruby nmap <buffer> <F8> <Plug>(seeing-is-believing-mark-and-run)
autocmd FileType ruby nmap <buffer> <F8> <Plug>(seeing-is-believing-mark-and-run)

autocmd FileType ruby nmap <buffer> <F9> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby xmap <buffer> <F9> <Plug>(seeing_is_believing-clean)
autocmd FileType ruby imap <buffer> <F9> <Plug>(seeing_is_believing-clean)

" #############################################
"  NEOTERM
" #############################################

nnoremap <Leader>ro :Topen<CR>
nnoremap <Leader>rk :Tclose<CR>
nnoremap <Leader>rc :Tclear<CR>
nnoremap <Leader>rr :Tclear \| call neoterm#exec({'cmd': ['!!', '', '']})<CR>

" Git commands
nnoremap <Leader>gl :Tclear \| call neoterm#exec({'cmd': ['git log', '', '']})<CR>
nnoremap <Leader>gn :Tclear \| call neoterm#exec({'cmd': ['git next', '', '']})<CR>
nnoremap <Leader>gp :Tclear \| call neoterm#exec({'cmd': ['git prev', '', '']})<CR>
nnoremap <Leader>gf :Tclear \| call neoterm#exec({'cmd': ['git first', '', '']})<CR>

" Git commands
nnoremap <Leader>po :PlantumlOpen<CR>
nnoremap <Leader>ps :PlantumlSave<CR>

let g:neoterm_autoscroll = 1
let g:neoterm_size = 25
let g:neoterm_keep_term_open = 1
let g:neoterm_test_status_format = 1
let g:neoterm_default_mod = 'botright'

command! Troutes :T rake routes

" #############################################
"  VIM Tabs Configuration
" #############################################

map <M-=> gt
map <M--> gT
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> :tablast<CR>

" Tabline customization
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? ' '. fnamemodify(bufname, ':t') . '  ' : '[No Name] ')

    if bufmodified
      let s .= '[~] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()

" Tabular
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" #############################################
"  Javascript and JSON Configuration
" #############################################

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" JSON Formatter
nmap =j :%!python -m json.tool<CR>

" Show JSON quotes
set conceallevel=0

" #############################################
"  VIM HardMode
" #############################################

autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" #############################################
"  Git Gutter
" #############################################

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" #############################################
"  Find, Search and Replace
" #############################################

map <silent> <C-p> :FZF<CR>

set grepprg=ag
let g:grep_cmd_opts = '--line-numbers --noheading'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Under cursor search with Ag and FZF
function! SearchCurrentWordWithAg() abort
  execute 'Ag' expand('<cword>')
endfunction

map <C-s> :call SearchCurrentWordWithAg()<CR>
map <C-f> :Ag<CR>

" #############################################
" Misc Configuration
" #############################################

set splitbelow
set splitright
set cpoptions+=$
set pastetoggle=<F12>
set number
set numberwidth=1
set noshowmode
set noruler
set noshowcmd
set nobackup
set noswapfile
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter
set nocompatible
set ttyfast
set lazyredraw
set diffopt+=vertical
set hidden
set updatetime=250
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

hi clear SignColumn
set timeoutlen=1000 ttimeoutlen=0
set re=1
hi link xmlEndTag xmlTag

set undofile
set undodir=~/.config/nvim/undodir
set undolevels=1000
set undoreload=10000

" Place a dummy sign column
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

hi ColorColumn guibg=#2e373b ctermbg=234
execute "set colorcolumn=" . join(range(121,335), ',')

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" For conceal markers.
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" Override color scheme for split line
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=59

" #############################################
"  Misc Key Mapping
" #############################################

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Relative number toggle mapping
nnoremap <silent> <F2> :set relativenumber!<cr>

" Map write command
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa

" Move between split pane faster
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Markdown Preview
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_github=1

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" #############################################
"  NERDTree
" #############################################
augroup AuNERDTreeCmd
  autocmd!
augroup end

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:NERDTreeHijackNetrw = 0
map <silent> <C-n> :NERDTreeToggle<CR>

" #############################################
"  NeoVim Terminal Config
" #############################################

" https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

" tnoremap <Esc> <C-\><C-n>
" tnoremap <M-[> <Esc>
" tnoremap <C-v><Esc> <Esc>

" tnoremap <C-[> <C-\><C-n>

" Switching Windows

" Terminal mode:
" tnoremap <M-h> <c-\><c-n><c-w>h
" tnoremap <M-j> <c-\><c-n><c-w>j
" tnoremap <M-k> <c-\><c-n><c-w>k
" tnoremap <M-l> <c-\><c-n><c-w>l

" Insert mode:
" inoremap <M-h> <Esc><c-w>h
" inoremap <M-j> <Esc><c-w>j
" inoremap <M-k> <Esc><c-w>k
" inoremap <M-l> <Esc><c-w>l

" Visual mode:
" vnoremap <M-h> <Esc><c-w>h
" vnoremap <M-j> <Esc><c-w>j
" vnoremap <M-k> <Esc><c-w>k
" vnoremap <M-l> <Esc><c-w>l

" Normal mode:
" nnoremap <M-h> <c-w>h
" nnoremap <M-j> <c-w>j
" nnoremap <M-k> <c-w>k
" nnoremap <M-l> <c-w>l

" #############################################
"  PlantUML Cconfiguration - https://github.com/weirongxu/plantuml-previewer.vim
" #############################################

au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)

au FileType plantuml let g:plantuml_previewer#save_format = 'svg'

" #############################################
"  VIM Template
" #############################################

let g:tmpl_search_paths = ['~/.config/nvim/templates']

" #############################################
"  Vim-Plug configuration
" #############################################
call plug#begin()

Plug 'Townk/vim-autoclose'
Plug 'aanari/vim-tsx-pretty'
Plug 'airblade/vim-gitgutter'
Plug 'aklt/plantuml-syntax'
Plug 'brooth/far.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'hwartig/vim-seeing-is-believing'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'ianks/vim-tsx'
Plug 'janko-m/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'
Plug 'matze/vim-move'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree'
Plug 'skwp/greplace.vim'
Plug 'slim-template/vim-slim'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'takac/vim-hardtime'
Plug 'tibabit/vim-templates'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'troydm/zoomwintab.vim'
Plug 'tyru/open-browser.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/matchit.zip'
Plug 'w0rp/ale'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'yssl/QFEnter'

call plug#end()
