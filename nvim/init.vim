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

" " #############################################
" "  Theme configuration
" " #############################################
" colorscheme codeschool

" #############################################
"  Airline configuration
" #############################################
let g:airline_powerline_fonts = 1

" Remap number toggle shortcut
let g:NumberToggleTrigger="<F2>"

" Misc Setup
set splitbelow
set splitright
set cpoptions+=$
set pastetoggle=<F12>
set number
set numberwidth=1

" #############################################
"  NERDTree
" #############################################
augroup AuNERDTreeCmd
  autocmd!
augroup end

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" disable Background Color Erase (BCE) by clearing the t_ut terminal option
" set t_ut=

"set laststatus=0
set noshowmode
set noruler
set noshowcmd
set nobackup
set noswapfile
set nowrap

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

hi ColorColumn guibg=#2e373b ctermbg=234
execute "set colorcolumn=" . join(range(81,335), ',')

" Set split separator to Unicode box drawing character
" set fillchars="" " vert:│

" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=59

let g:airline_skip_empty_sections = 1

" Workaround for tmux navigator on NeoVim
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

let g:NERDTreeHijackNetrw = 0

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the screen

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

" Consistent sign column
hi clear SignColumn

" Place a dummy sign column
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 0

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Use deoplete (code autocomplete)
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#disable_auto_complete = 1

" Git gutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

set updatetime=100 "suggestion 250

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Under cursor search with Ag and FZFg
function! SearchCurrentWordWithAg() abort
  execute 'Ag' expand('<cword>')
endfunction

map <C-s> :call SearchCurrentWordWithAg()<CR>
map <C-f> :Ag<CR>

" Map write command
command! WQ wq
command! Wq wq
command! W w
command! Q q
command! Qa qa

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

" Mapping keys delay
set timeoutlen=1000 ttimeoutlen=0

" #############################################
"  Syntastic with Neomake Config
" #############################################
let g:syntastic_ruby_checkers = ["mri", "rubocop", "flog", "reek"]
let g:syntastic_scss_checkers = ["scss_lint"]
let g:syntastic_javascript_checkers = ["jshint"]

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0

let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '✗'
let g:syntastic_warning_symbol = '✗'

" Run NeoMake on read and write operations
autocmd! BufReadPost,BufWritePost * Neomake

" Disable inherited syntastic
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }

let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_verbose=0

let g:neomake_warning_sign = {
  \   'text': '✗',
  \   'texthl': 'WarningMsg',
  \ }

let g:neomake_error_sign = {
  \   'text': '✗',
  \   'texthl': 'ErrorMsg',
  \ }

" #############################################
"  Key Mapping
" #############################################
map <C-p> :FZF<CR>
map <C-n> :NERDTreeToggle<CR>

" #############################################
"  rspec.vim mapping
" #############################################

let test#strategy = "vtr"
let g:test#runner_commands = ["RSpec", "Minitest", "Mocha"]

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" #############################################
"  Using Dispatch or Tslim for dispatcher
" #############################################
let g:rspec_runner = 'os_x_iterm2'
let g:rspec_command = 'VtrSendCommand! rspec {spec}'

" #############################################
"  VTR (Vim Tmux Runner) and Vim Rspec Runner
" #############################################

let g:VtrUseVtrMaps = 0
map <Leader>ro :VtrOpenRunner<CR>
map <Leader>rk :VtrKillRunner<CR>
map <Leader>rf :VtrFocusRunner<CR>
map <Leader>rc :VtrClearRunner<CR>
map <Leader>rss :VtrSendSelectedToRunner<CR>
map <Leader>ra :VtrAttachToPane<CR>
map <leader>rr :VtrSendCommandToRunner<CR>

" #############################################
"  Neosnippet
" #############################################

let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#snippets_directory = '~/.config/nvim/plugged/vim-snippets/snippets'

" Plugin key-mappings.
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

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

" JSON Formatter
nmap =j :%!python -m json.tool<CR>

" Tab switcher
" nnoremap _ gT
" nnoremap + gt
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

" #############################################
"  Vim-Plug configuration
" #############################################
call plug#begin()

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'craigemery/vim-autotag'
Plug 'fishbullet/deoplete-ruby'
Plug 'gregsexton/gitv'
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'matze/vim-move'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'shougo/neosnippet-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'troydm/zoomwintab.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/matchit.zip'
Plug 'yssl/QFEnter'
Plug 'hwartig/vim-seeing-is-believing'
Plug 't9md/vim-ruby-xmpfilter'

call plug#end()
