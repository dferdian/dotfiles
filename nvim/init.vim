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
   call neoterm#open() " Opens the neoterm window
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
nnoremap <Leader>rk :call neoterm#close()<CR>
nnoremap <Leader>rc :call neoterm#clear()<CR>
nnoremap <Leader>rr :call neoterm#clear() \| call neoterm#exec(['!!', '', ''])<CR>

let g:neoterm_autoscroll = 1
let g:neoterm_size = 10
let g:neoterm_keep_term_open = 1
let g:neoterm_test_status_format = 1

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
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

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

" #############################################
"  Vim-Plug configuration
" #############################################
call plug#begin()

Plug 'Townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'brooth/far.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'hwartig/vim-seeing-is-believing'
Plug 'janko-m/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'kana/vim-textobj-user'
Plug 'kassio/neoterm'
Plug 'kchmck/vim-coffee-script'
Plug 'matze/vim-move'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'skwp/greplace.vim'
Plug 'slim-template/vim-slim'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'troydm/zoomwintab.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/matchit.zip'
Plug 'w0rp/ale'
Plug 'yssl/QFEnter'

call plug#end()
