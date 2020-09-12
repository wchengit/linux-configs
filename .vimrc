set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'nerdtree'
Plugin 'ctrlp.vim'
Plugin 'supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'kshenoy/vim-signature'
Plugin 'easymotion/vim-easymotion'
Plugin 'unite.vim'
Plugin 'Shougo/vimproc.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"autocmd vimenter * if !argc() | NERDTree | endif

" Backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set wildmenu                      " tab-complete on the commandline
set wildmode=list:longest         " list all completions, fill in common prefix
"set visualbell                    " flash instead of beeping
set cursorline

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set tags=tags;
set hidden
"set number

set diffopt+=iwhite
set diffexpr=""

set matchpairs+=<:>

if exists('+colorcolumn')
  set colorcolumn=100
end

" airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"let g:EclimCompletionMethod = 'omnifunc'

map <F2> :Bufferlist<CR>
map <F3> :TlistToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F5> :set number!<CR>
map <F8> :ConqueTerm bash<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

ca cgrep SH grep -Irn --color --include=*.{h,hpp,cpp,def}
ca agrep SH grep -Irn --color

let g:ctrlp_map = '<c-p>'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

nnoremap <s-m> :bnext<CR>
nnoremap <c-m> :bprevious<CR>

map ,g :SH grep -Irn --color --include=*.{h,hpp,hh,c,cc,cpp,def,proto} <C-R><C-W> *<CR>
vmap ,g :SH grep -Irn --color --include=*.{h,hpp,hh,c,cc,cpp,def,proto} '<,'> *<CR>

map ,f :SH grep -Irn --color <C-R><C-W> *<CR>
vmap ,f :SH grep -Irn --color '<,'> *<CR>

map <C-K> :pyf /apps/infra/fixed/clang-tooling/latest/clang-format.py<cr>
imap <C-K> <c-o>:pyf /apps/infra/fixed/clang-tooling/latest/clang-format.py<cr>

"Unite
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>
nnoremap <space>d :UniteWithBufferDir file<cr>

nnoremap <space>. :cd %:p:h<cr>:pwd<cr>
nnoremap <space>2. :cd ..<cr>:pwd<cr>
nnoremap <space>3. :cd ../../<cr>:pwd<cr>
nnoremap <space>4. :cd ../../../<cr>:pwd<cr>


"set cmdheight=2

set t_Co=256
hi Comment ctermfg=19
hi SpecialKey ctermfg=blue
hi Directory ctermfg=blue
hi DiffAdd ctermbg=lightgreen
hi DiffChange ctermbg=lightblue
hi DiffText ctermbg=lightgray
hi Search ctermbg=195

"easymotion
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

"To use this mapping: first, delete some text (using a command such as daw or dt in normal mode, or x in visual mode). Then, use visual mode to select some other text, and press Ctrl-X. The two pieces of text should then be swapped.
:vnoremap <C-X> <Esc>`.``gvP``P

"disable youcompleteme
let g:loaded_youcompleteme = 1

"plugin example
":Subvert/blog{,s}/post{,s}/g  replace blog/Blog/BLOG/blogs...

"trailing whitespace
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>
"trailing whitespace --end

"Shell
command! -complete=shellcmd -nargs=+ SH call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  if bufexists("SHELL")
    b SHELL
    let newwin = 0
  else
    botright new SHELL
    let newwin = 1
  endif
  "resize -20
  setlocal buftype=nofile noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute 'silent $read !'. expanded_cmdline
  "setlocal nomodifiable
  1
  if newwin
    set syntax=c
    q
  endif
  b SHELL
endfunction
