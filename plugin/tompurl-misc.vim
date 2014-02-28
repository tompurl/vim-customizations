let onWindows = 0
if has('win32')
    let onWindows = 1
endif

set nowrap
set expandtab
set shiftwidth=4
:map gf :e <cfile><CR>

if onWindows
    let &verbosefile = "C:/temp/vim_debug.out"
else
    let &verbosefile = "/tmp/vim_debug.out"
endif

":inoremap jj <esc>
inoremap uu <esc>

:map <leader>en :cd %:p:h <Bar> new<Space>
set shortmess=a "no more hitting enter to continue
map <leader>ma <ESC>:set filetype=mail<CR>
map <leader>cl <ESC>:clo<CR>
set visualbell

"Timestamp scripts
"nmap <leader>ts "=strftime("@ %H:%M")<CR>P
"imap <leader>ts <ESC>"=strftime("@ %H:%M")<CR>Pi
iabbrev dts <ESC>"=strftime("%y/%m/%d @ %T")<CR>PA
iabbrev ts  <ESC>"=strftime("@ %T")<CR>PA
nnoremap <leader>tsh  "=strftime("%T")<CR>P
inoremap <leader>tsh  <ESC>"=strftime("%T")<CR>PA


"Open this file from any other file
"Only works on Linux/Mac
let myvimrc = "$HOME/.vim/bundle/tompurl-vimrc/plugin/tompurl-misc.vim"
:nnoremap <leader>ev :execute "split " . myvimrc <cr>
:nnoremap <leader>sv :execute "source " . myvimrc <cr>

"Some simple abbreviations
:iabbrev @@ tom@tompurl.com 
:iabbrev ssig --<CR>Tom Purl<cr>tom@tompurl.com

""""""lvsthw chapter 9
""" Wrap words or selections in double-quotes
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" FIXME Does not work if the last selected char is the last char in the line.
:vnoremap <leader>" lvi"<esc>gv`<vi"<esc>
""" Wrap words or selections in single-quotes
:nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" H moves to the beginning of the line in normal mode
:nnoremap H ^
" L moves to the end of the line in normal mode
:nnoremap L $

""""""lvsthw chapter 10
" Nothing for me to do here. I am already using caps lock instead of escape,
">and I map it at an OS level.

" Vimscript file settings ------------------------- {{{
augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au FileType vim iabbrev <buffer> nf " TODO Short description ----------- {{{<cr><esc>xxifunction! TODO()<cr>echom "Hello!"<cr>endfunction<cr>" }}}
augroup END
" }}}

"""""lvsthw chapter 28
" Add a mapping that opens the previous buffer in a split of your choosing
:nnoremap <leader>bp :execute "rightbelow vsplit " . bufname("#") <cr>

"""""Start special settings for gpg diary files
" First, let's create the filetype
augroup filetypedetect_gpg
    au!
    au! BufRead,BufNewFile *.gpg setfiletype gpg
augroup END

" Now let's set some options
augroup filetype_gpg
    au!
    au FileType gpg setlocal spell
augroup END
" }}}

""" folding
set foldmethod=indent
set foldnestmax=10
"set nofoldenable
set foldlevel=2
set foldcolumn=5

""" Turn on omnicompletion
set ofu=syntaxcomplete#Complete

""" Supertab
"let g:SuperTabSetDefaultCompletionType = "":

""" Powerline
set laststatus=2
set encoding=utf-8
let g:Powerline_symbols = 'fancy'

""" Puppet stuff
augroup filetype_puppet
  autocmd!

  autocmd BufNewFile,BufRead *.pp set filetype=puppet

augroup END

""" JSON stuff
augroup filetype_json
    autocmd!
    "autocmd FileType json nnoremap <leader>li execute !cat % | python -mjson.tool
augroup END

vnoremap <leader>bb ovi**gvOvllli** 

" LVSTHW Exercises {{{1

" 31.6 Exercises {{{2
" Mark trailing whitespace as an error:
highlight MyErrors ctermbg=green guibg=green
inoremap <leader>w <ESC>:match MyErrors /\v\s$/<CR>
nnoremap <leader>w :match MyErrors /\v\s+$/<CR>
inoremap <leader>W <ESC>:match none<CR>
nnoremap <leader>W :match none<CR>
nnoremap <leader>ms /\v
" }}}2

" 32 Exercises {{{2

"nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen 5<cr>
nnoremap cn :cnext<cr>
nnoremap cp :cprevious<cr>

" }}}2

" 38 Exercises {{{2

nnoremap <leader>f :call FoldColumnToggle()<cr>
 
" FoldColumnToggle ----------- {{{
function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
       setlocal foldcolumn=4
    endif
endfunction
" }}} 

nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

" QuickfixToggle ----------- {{{
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else 
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}} 

" }}}2

" }}}1

" Help operator {{{1
" This operator will allow you to look up a word based on a motion in the
" online vim help.

" Help shortcuts
nnoremap <leader>h :set operatorfunc=HelpSearchOperator<cr>g@
vnoremap <leader>h :<c-u>call HelpSearchOperator(visualmode())<cr>
 
" Helpgrep shortcuts
" TODO
 
" HelpSearchOperator ----------- {{{
function! HelpSearchOperator(type)

    let saved_unamed_register = @@

    if a:type ==# 'v'
       execute "normal! `<v`>y"
    elseif a:type ==# 'char'
       execute "normal! `[v`]y"
    else
       return
    endif

    silent execute "help " . shellescape(@@)

    let @@ = saved_unamed_register
endfunction

" rtrim - Trim off all whitespace at the end of a string ----------- {{{
function! Rtrim(yourstring)
    echom "Hello!"
endfunction
" }}} 

" }}}
