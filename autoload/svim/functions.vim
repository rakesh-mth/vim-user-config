" move files from copen to args from https://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim
function! svim#functions#QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction
command! -nargs=0 -bar Qargs execute 'args ' . svim#functions#QuickfixFilenames()

" Toggle header and cpp file
function! svim#functions#SwitchSourceHeader()
    if (expand("%:e") == "cpp" || expand("%:e") == "c")
        execute 'tag ' . expand("%:t:r") . '.h'
    elseif (expand("%:e") == "h")
        execute 'tag ' . expand("%:t:r") . '.cpp'
    else
        echo "file in not either .h, .c or .cpp"
    endif
endfunction

" delete inactive buffers
function! svim#functions#DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && getbufvar(i, "&buftype") != "terminal" && index(tablist, i) == -1
            "bufno exists AND isn't modified AND isn't terminal buffer AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! BufferDeleteInactive :call svim#functions#DeleteInactiveBufs()

" refresh buffers if files changed outside vim 
" Like bufdo but restore the current buffer.
function! svim#functions#BufDo(command)
    let currBuff=bufnr("%")
    execute 'bufdo ' . a:command 
    execute 'buffer ' . currBuff 
endfunction
command! -nargs=+ -complete=command Bufdo call svim#functions#BufDo(<q-args>)
