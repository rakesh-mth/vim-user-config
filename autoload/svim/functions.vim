" common functions

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


" Like bufdo but restore the current buffer. will be used for buffer refresh.
function! svim#functions#BufDo(command)
    let currBuff=bufnr("%")
    execute 'bufdo ' . a:command 
    execute 'buffer ' . currBuff 
endfunction
command! -nargs=+ -complete=command Bufdo call svim#functions#BufDo(<q-args>)


" toggle gui elements in VIM (no impact in nvim-qt)
function! svim#functions#ToggleGUICruft()
  if &guioptions==''
    exec('set guioptions=imTr')
  else
    exec('set guioptions-=imTr')
  endif
endfunction


" toggle full screen in gui mode
let s:fullScreen = 0
function! svim#functions#ToggleFullScreen()
    if (s:fullScreen == 1) | let s:fullScreen = 0 | else | let s:fullScreen = 1 | endif
    if has('gui_macvim') " macvim
        if (&fullscreen == 1) | set nofullscreen | else | set fullscreen | endif
    elseif exists('g:GuiLoaded') " nvim-qt
        call GuiWindowFullScreen(s:fullScreen)
    endif
endfunc


" Toggle buffer
let s:bufferState = 0
function! svim#functions#BufferToggle()
  if(s:bufferState == 1) | let s:bufferState = 0 | bp | else | let s:bufferState = 1 | bn | endif
endfunc


" Toggle cursor column
function! svim#functions#ToggleCursorCol() abort
  if &cursorcolumn | set nocursorcolumn | else | set cursorcolumn | endif
endfunction


" toggle relativenumber
function! svim#functions#ToggleRelativeNumber() abort " can also use: nornu and rnu
  if &relativenumber | set relativenumber! | else | set relativenumber | endif
endfunction


" tabs : change tabs using Alt-1, Alt-2, Alt-3...
function! svim#functions#AltMapping()
    nnoremap <M-0> 10gt
    for idx in range( 1, 9 )
        execute 'nnoremap <M-' . idx . '> ' . '<C-[>' . idx . 'gt'
    endfor
    if has('mac')
        for altc in items({'¡' : 1, '™': 2, '£': 3, '¢': 4, '∞': 5, '§': 6, '¶': 7, '•': 8, 'ª': 9}) " sed -n l => Alt + 1
            execute 'nnoremap ' . altc[0] . ' ' . '<C-[>' . altc[1] . 'gt'
        endfor
    endif
endfunction

