""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""”
"Author:陈杨(chen yang)													“
"Date:2011-10-1															“
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""”

"===========几行基本配置================================================”
set number   "显示行号
set autoindent	"自动对齐
set smartindent   "智能对齐
set showmatch    "括号匹配模式
set ruler       "显示行状态
set incsearch   
set tabstop=4   "tab键为4个空格
set shiftwidth=4
set softtabstop=4
set cindent    "C语言格式对齐
set nobackup
set nocompatible	"不使用VI默认键盘布局
set mouse=a		"使鼠标管用
syntax enable   "使代码高亮
syntax on
colorscheme desert  "选择默认配色模式
set cursorline
set foldmethod=indent
set foldlevel=99
"namp f :<zc zo>
"===========基本配置结束================================================"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"下面使根据吴垠的《将VIM配置成IDE》文章设置的快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set helplang=cn
"set encoding=utf-8
"set tags=/sview/dchen_snap_11/vobs/TS_nextgen/tags
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
nmap t :Tlist<cr>
nmap f @=((foldclosed(line('.'))<0)?'zc':'zo')<cr>
"nmap f zo <cr>
set cscopequickfix=s-,c-,d-,i-,t-,e-
"cs add /sview/dchen_snap_11/vobs/cscope.out /sview/dchen_snap_11/vobs/TS_nextgen
cs add ./cscope.out ./
" <F6>查找下一个，<F7>查找上一个
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>
nmap <F4> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <F8> :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
nnoremap <silent> <F3> :Grep<CR>
filetype plugin indent on
set completeopt=longest,menu
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"""""""""""""""IDE结束"""""""""""""""""""""""""""""""""""""""""""""""""""

" Python support "
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
" Python end "


"========================扩展配置========================================

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==>General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set how many lines of history VIM has to remeber
set history=800
"set to auto read when a file is changedd from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==>VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""“”
"set 8 lines to curors - when moving verical..
set so=8

"set wildmenu  "Turn on Wild menu
set ruler  "Always show current position
set cmdheight=1   "The commandbar height
set hid   "Changer buffer - Without saving

"set backspace config
set backspace=eol,start,indent

"下面两个与自动补全不太兼容
"set ignorecase  "Ignore case when searching
"set smartcase

set hlsearch   "Highlight search things

set incsearch   "Make search act like search in modern browsers
set nolazyredraw   "Don't redraw while executing macros

set magic   "Set magic on,for regular expressions

set mat=2   "How many tenths of a second to blink

"No sound on errors
"set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==>Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==>Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab

set lbr
set tw=500

"set ai  "Auto indent
"set si  "Smart indent
set wrap  "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==>Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Really useful!
" In Viusal mode when you press * or # to search for the current selection
" *是向下查找，#是向上查找
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"when you press gv you vimgrep after the select text
"gv 命令有点问题.....
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*<left><left><left><left><left><left><left>

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
	let l:saved_reg = '@'
	execute "normal! vgvy"

	let l:pattern = escape(@",'\\/.*$^[]')
	let l:pattern = substitute(l:pattern,"\n$","","")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*')
	elseif a:direction == 'f' 
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map ½ $
imap ½ $
vmap ½ $
cmap ½ $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 2
"let g:miniBufExplModSelTarget = 0
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1
"let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>
