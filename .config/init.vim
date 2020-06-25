set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" General settings{{{
let mapleader=" "
let maplocalleader=" "


" Don't try to be vi compatible
set nocompatible

" Mouse support
set mouse=a
" Interactive search and replace
set inccommand=nosplit
" Replace selected globally with confirmation
nnoremap <Leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>k y :%s/<C-r>"//gc<Left><Left><Left>
" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" Security
set modelines=0

" Show line numbers
set rnu
set nu



" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell
set cursorline

" Encoding
set encoding=utf-8

" Whitespace
 set wrap
 set textwidth=79
 set formatoptions=tcqrn1
 set tabstop=2
 set shiftwidth=2
 set softtabstop=2
 set expandtab
 set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
" nnoremap j gj
" nnoremap k gk

" Allow hidden buffers
set hidden

" Allow local vimrc
set exrc
set secure

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set smartindent
set showmatch
set wildmenu
set wildmode=full
map \<space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
" map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
" map <leader>l :set list!<CR> " Toggle tabs and EOL


set updatetime=1500
set timeoutlen=150

let g:saving_at_every_edit = 0
function! ToggleSaveEveryEdit()
  if g:saving_at_every_edit == 0
    let g:saving_at_every_edit = 1
    augroup SaveAtEveryEdit
      au TextChanged,TextChangedI <buffer> silent write
    augroup END 
  else
    let g:saving_at_every_edit = 0
    " delete group
    au! SaveAtEveryEdit
  endif
endfunction
" Helps force plugins to load correctly when it is turned back on below
filetype off
"}}}

call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'

Plug 'kassio/neoterm'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'pangloss/vim-javascript', {'for':['javascript', 'jsx', 'vue', 'html']}
Plug 'posva/vim-vue', {'for':['javascript', 'jsx', 'vue', 'html']}

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ryanoasis/vim-devicons' 
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'machakann/vim-highlightedyank'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'drewtempelmeyer/palenight.vim'

Plug 'vimwiki/vimwiki'

Plug 'wakatime/vim-wakatime'
call plug#end()

"
"}}}
" Git{{{
nnoremap <silent> <leader>gu :GitGutterToggle<cr>
nnoremap <silent> <leader>g :G<cr>
nnoremap <silent> <leader>gp :Gpull<cr>
nnoremap <silent> <leader>gm :Gpull origin master<cr>"}}}
" Startify
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_bookmarks = [ { 'v' : '~/.vimrc'} ]
let g:startify_session_autoload = 1

" Indent Guids{{{
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 5 
let g:indent_guides_start_level = 3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg='#495469' ctermbg=black
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#614444' ctermbg=darkgrey

" asdlkfhas
"   asdfgasdgf
"   asdfasdg
"     sdgfasdg
"     asdf
"   sdfgsdfg
" asld;kfhasdk

"}}}
" Folding{{{
augroup filetype_vim
  autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END"}}}
" Fuzzy Find{{{
let g:fzf_preview_window = 'right:55%'"}}}
" NeoTerm{{{
let g:neoterm_size = 14
nnoremap <silent> <leader>rl :vertical botright Ttoggle<cr><C-w>l
nnoremap <silent> <leader>rj :botright Ttoggle<cr><C-w>j
" REPL
nnoremap <silent> <leader>rw :TREPLSendLine<cr>
vnoremap <silent> <leader>rw :TREPLSendSelection<cr>

function! s:copy_results(lines)
  let joined_lines = join(a:lines, "\n")
  if len(a:lines) > 1
    let joined_lines .= "\n"
  endif
  let @* = joined_lines
endfunction
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-o': function('s:copy_results'),
  \ }
"}}}

" COC{{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.  set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

let g:coc_global_extensions = [
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh() 
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>" 
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" let g:coc_snippet_next = '<tab>'
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"}}}
let g:coc_explorer_global_presets = {
\   '.vim': {
\      'root-uri': '~/.vim',
\   },
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 50,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

nmap <space>es :CocCommand explorer<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>

" Commentary{{{
xmap mc  <Plug>Commentary
nmap mc  <Plug>Commentary
omap mc  <Plug>Commentary
nmap mcm <Plug>CommentaryLine"}}}

" Color scheme (terminal){{{

set t_Co=256
set background=dark
set termguicolors
colorscheme palenight
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1

highlight LineNr guifg=#55805b
highlight CursorLine guibg=#292d3e
highlight CursorLineNr guifg=#a6ad47
highlight Normal guibg=#151926
highlight NormalFloat guibg=#2f3552
highlight Folded guibg=#151926

" good ones:
" OceanicNext
" solarized8_flat
" hybrid-material
" space-vim-dark
"
"}}}

" Highlight yank{{{
let g:highlightedyank_highlight_duration = 700"}}}

" vimwiki{{{
" ----------------------------------------------------------------------------

" call dein#add('vimwiki/vimwiki', {'rev':'dev'})
let g:vimwiki_list = [{
            \ 'auto_export': 0,
            \ 'auto_header' : 1,
            \ 'automatic_nested_syntaxes':1,
            \ 'path_html': '$HOME/vimwiki_html',
            \ 'path': '$HOME/vimwiki',
            \ 'template_path': '',
            \ 'template_default':'GitHub',
            \ 'template_ext':'.html5',
            \ 'css_name': 'templates/template.css',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'custom_wiki2html': '$HOME/vimwiki/wiki2html.sh',
            \ 'autotags': 1,
            \ 'list_margin': 0,
            \ 'links_space_char' : '_',
            \}, {
            \ 'auto_export': 0,
            \ 'auto_header' : 1,
            \ 'automatic_nested_syntaxes':1,
            \ 'path_html': '$HOME/uni',
            \ 'path': '$HOME/uni',
            \ 'template_path': '',
            \ 'template_default':'GitHub',
            \ 'template_ext':'.html5',
            \ 'css_name': 'templates/template.css',
            \ 'syntax': 'markdown',
            \ 'ext':'.md',
            \ 'custom_wiki2html': '$HOME/vimwiki/wiki2html.sh',
            \ 'autotags': 1,
            \ 'list_margin': 0,
            \ 'links_space_char' : '_',
            \ }]
let g:vimwiki_folding='expr'
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_hl_headers = 1

nnoremap <silent> <Leader>wp :Files ~/vimwiki<cr>
"}}}


" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------
"
" nnoremap <silent> <C-r> :source ~/.vimrc<cr>

inoremap jk <esc>
inoremap jo <esc>o
inoremap ji <esc>O
inoremap jl <esc>A
inoremap jh <esc>^i

nnoremap <Leader>ss :call ToggleSaveEveryEdit()<cr>

nnoremap <Leader>bs :Buffers<cr>
noremap <Leader>bd :bdelete<cr>
nnoremap <Leader>p :GFiles<cr>
nnoremap <C-P> :Files<cr>
nnoremap <Leader>ag :Ag<cr>

nnoremap <UP> :resize -2<cr>
nnoremap <DOWN> :resize +2<cr>
nnoremap <LEFT> :vertical resize +2<cr>
nnoremap <RIGHT> :vertical resize -2<cr>

" Remove execute mode mapping
nnoremap Q <nop> 
" Quicker window movement {{{
tnoremap <C-w>h <C-\><C-N><C-w>h
" tnoremap <C-J> <C-\><C-N><C-w>j
" tnoremap <C-K> <C-\><C-N><C-w>k
tnoremap <C-w>l <C-\><C-N><C-w>l
tnoremap jk <C-\><C-N><C-w>l
inoremap <C-w>h <C-\><C-N><C-w>h
inoremap <C-w>j <C-\><C-N><C-w>j
inoremap <C-w>k <C-\><C-N><C-w>k
inoremap <C-w>l <C-\><C-N><C-w>l
"}}}

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>

xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv


" ----------------------------------------------------------------------------
" Sneak lines
" ----------------------------------------------------------------------------
let g:sneak#label = 1
