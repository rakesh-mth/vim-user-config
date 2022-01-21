" auto commands on events

" lsp for omni func complition - this is moved to lua file for lsp
" augroup enable omnifunc for lsp for python filetype
    " autocmd!
    " autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
" augroup END 

" auto switch to insert mode when terminal buffer becomes active
augroup auto_term_insert_and_do_not_close_on_last_window_exit
    autocmd!
    autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif
    " autocmd BufCreate,BufWinEnter,WinEnter term://* startinsert
    if has('nvim')
        autocmd TermOpen * set bufhidden=hide " hide buffer so that switching out of terminal window does not close terminal
        autocmd TermClose * bd! | if winnr('$') == 0 | tabprevious | endif " switch to previous tab if there are no more window
    endif
augroup END 

" auto open cwindow (copen) after search using vimgrep(or vim)
augroup qf_auto_open_on_vimgrep
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    cwindow
    " autocmd VimEnter        *     cwindow
augroup END

" returns true if NERDTree open/active
function! s:IsNerdTreeOpen() 
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
augroup plugin_nerd_tree
    autocmd FileType nerdtree setlocal relativenumber
    autocmd BufEnter *.cpp,*.h,*.py,*.el,*.sh,*.yml,*.bat,*.md,*.json,*.txt,.zshrc,.bashrc if &modifiable && s:IsNerdTreeOpen() && strlen(expand('%')) > 0 && !&diff | NERDTreeFind | wincmd p | endif
augroup END 

augroup plugin_goyo
    autocmd!    
    autocmd! User goyo.vim echom 'Goyo is now loaded!'
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
augroup END

augroup plugin_fugitive
    autocmd!    
    " map <tab> to = to match it with magit in emacs.
    autocmd FileType fugitive nmap <buffer> <tab> =
    " map q to gq for quit to match with magit in emacs. Note: q for
    " recording macro will not work if it is mapped to gq
    autocmd FileType fugitive nmap <buffer> q gq
    " put into insert mode after jump to line number 1 for git commit buffer
    autocmd FileType gitcommit 1 | startinsert
    " delete git commit buffer after :wq, git waits for nvr to finish
    autocmd FileType gitcommit,gitrebase set bufhidden=delete
augroup END

augroup plugin_lsp
    autocmd!
    " map q to exit lspinfo window
    autocmd FileType lspinfo nmap <buffer> q <C-w>c
    " map q to exit null-ls-info window
    autocmd FileType null-ls-info nmap <buffer> q <C-w>c
augroup END

function! VimEnterFunction()
    call svim#functions#AltMapping()
endfun

" auto source vimrc after writing new changes
augroup source_vimrc
    autocmd! BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" additional config only after VimEnter
augroup VimEnterGroup
    autocmd!
    autocmd VimEnter * call VimEnterFunction()
augroup END

