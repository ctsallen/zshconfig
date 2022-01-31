" Setup some basic options for VIM
syntax on
set ruler
set number
set mouse+=a " prevent mouse from copying numbers
set showmatch
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]
set linebreak

" Handle vim swapfiles but putting them all in one location
set directory^=$HOME/.vim/swap//

" Handle persistent undo file
set undodir^=$HOME/.vim/undo//

" Handle the conversion between tabs and spaces and handle tab features
set smartindent
set tabstop=4
set softtabstop=4
set expandtab
set autoindent

" Handle searching so that it is case-sensitive by default
set ignorecase
set smartcase
set hlsearch
set nowrapscan
set incsearch

" Handle copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" Handle moving through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" indent/unindent with tab/shift-tab
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Persistent undo even after you close a file and re-open it
set undofile

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣

" Make it obvious where 100 characters is
set textwidth=100
" set colorcolumn=+1

set showcmd       " display incomplete commands
"set laststatus=2  " Always display the status line
set backspace=2   " Backspace deletes like most programs in insert mode

" Use the system clipboard for all yanks, deletes, etc.
set clipboard^=unnamed,unnamedplus

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」,『:』,【:】,“:”,‘:’,《:》

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

"
" Configure netrw - vims built-in file manager
"

" Change the size of the Netrw window when it creates a split. I think 30% is fine.
let g:netrw_winsize = 25
" Hide the banner (if you want). To show it temporarily you can use I inside Netrw.
let g:netrw_banner = 0
" Change the copy command. Mostly to enable recursive copy of directories
let g:netrw_localcopydircmd = 'cp -r'
" Hide dotfiles on load.
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3
" Highlight marked files in the same way search matches are.
hi! link netrwMarkFile Search

" Call the NetrwMapping function every netrw is opened
function! NetrwMapping()
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" Embed custom mappings into netrw
" See: https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
function! NetrwMapping()
    nmap <buffer> H u
    nmap <buffer> h -^
    nmap <buffer> l <CR>

    nmap <buffer> . gh
    nmap <buffer> P <C-w>z

    nmap <buffer> L <CR>:Lexplore<CR>
endfunction

" Originally inspired by https://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree
" and https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
let g:NetrwIsOpen=0
function! ToggleVExplorer()
    if g:NetrwIsOpen
        " just call Lexplore to close it
        Lexplore
        let g:NetrwIsOpen=0
    else
        " open in the directory of the curr file
        Lexplore %:p:h
        let g:NetrwIsOpen=1
    endif
endfunction

map <silent> <C-d> :call ToggleVExplorer()<CR>

" configure plugins
autocmd FileType yml,yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldlevelstart=20

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'


set grepprg=rg\ --vimgrep\ --smart-case\ --follow

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" Enables certain plugins
filetype plugin on

function! NetrwMouseOn()
     set mouse=n
endfunction

function! NetrwMouseOff()
     set mouse=
endfunction


au FileType netrw :call NetrwMouseOn()
au FileType netrw au BufEnter <buffer> :call NetrwMouseOn()
au FileType netrw au BufLeave <buffer> :call NetrwMouseOff()

" Map every left click to enter button
au FileType netrw nmap <buffer> <LeftMouse> <LeftMouse> <CR>

" Don't let MacVim.app override chosen colorscheme
let macvim_skip_colorscheme=1
