" all mappings goes here

" toggle gui elements in VIM (no impact in nvim-qt)
    nnoremap <F11> <Esc>:call svim#functions#ToggleGUICruft()<cr>

" spell checker
    map <leader>sp :setlocal spell! spelllang=en_us<cr>

" disable highlights
    nnoremap <leader>nh :noh<cr>
    " mapping similar to LunarVim
    nnoremap <leader>h :noh<cr>

" productivity
    nnoremap <leader>] ]]zz
    nnoremap <leader>[ [[zz
    nnoremap <leader>lu mqO<Esc>`q| " add a line above 
    nnoremap <leader>ld mqo<Esc>`q| " add a line below
    nnoremap <leader>cc <Esc>6i#<Esc>A| " add 6 # and place cursor at the end (comment begin)
    nnoremap <leader>vs :exe ':silent !code %'<CR>:redraw!<CR>
    " Ctrl-ScrollWheel for zooming in/out
    if exists('g:fvim_loaded') " fvim related
        nnoremap <silent> <C-ScrollWheelUp>   :set guifont=+<CR>
        nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
        nnoremap <silent> <C-=> :set guifont=+<CR>
        nnoremap <silent> <C--> :set guifont=-<CR>
    else 
        function! ZoomGuiFont(direction)
            let &guifont = substitute(&guifont, ':h\zs\d\+', '\=eval(submatch(0)+1*a:direction)', 'g')
        endfunc
        nnoremap <silent> <C-ScrollWheelUp>   :silent! call ZoomGuiFont(1)<CR>
        nnoremap <silent> <C-ScrollWheelDown> :silent! call ZoomGuiFont(-1)<CR>
        " Ctrl mapping does not work in gvim, fvim and vimr
        nnoremap <silent> <C-=> :silent! call ZoomGuiFont(1)<CR>
        nnoremap <silent> <C--> :silent! call ZoomGuiFont(-1)<CR>
        nnoremap <silent> <leader>= :silent! call ZoomGuiFont(1)<CR>
        nnoremap <silent> <leader>- :silent! call ZoomGuiFont(-1)<CR>
    endif
    " toggle full screen mode
    if has('nvim')
        if exists('g:fvim_loaded')
            nnoremap <leader>TF :FVimToggleFullScreen<CR>
        elseif has('gui_vimr')
            nnoremap <leader>TF :VimRToggleFullscreen<CR>
        else
            nnoremap <leader>TF :call svim#functions#ToggleFullScreen()<CR>
        endif
        inoremap <silent>  <S-Insert>  <C-R>+| "paste from system clipboard in insert mode
    elseif has('gui_macvim')
        nnoremap <leader>TF :call svim#functions#ToggleFullScreen()<CR>
    endif
    " save as root user
    if has('mac') || has('unix')
        cmap w!! w !sudo tee > /dev/null %
    endif

" quickfix mappings
    nnoremap <leader>qo :copen<cr>
    nnoremap <leader>qc :ccl<cr>
    nnoremap <leader>qn :cnext<cr>
    nnoremap <leader>qp :cprev<cr>

" spacemacs key bindings
    nnoremap <leader><TAB> :call svim#functions#BufferToggle()<cr>| " Toggle between presious and current buffer.
    nnoremap <leader><leader> :| " switch to command mode
    nnoremap <leader>fed :e $MYVIMRC<cr>| " open vim configuration file (.vimrc or init.vim)
    nnoremap <leader>gb  :GBranches<cr>| " open  page (from fugitive)
    nnoremap <leader>gt  :GTags<cr>| " open  page (from fugitive)
    nnoremap <leader>gg  :Git \| wincmd _ \| normal gu<cr>| " open git status page (from fugitive), and jump to Unstaged
    nnoremap <leader>gp  :Git push<cr> " push to remote branch
    nnoremap <leader>gc  :Commits<cr>| " open commit list in current branch
    nnoremap <leader>gd  :tabe \| Git diff \| wincmd o<cr>| " open git diff in new tab
    nnoremap <leader>gdd :tabe \| Git diff --staged \| wincmd o<cr>| " open git diff in new tab
    nnoremap <leader>tc :call svim#functions#ToggleCursorCol()<cr>| " toggle cursor column
    nnoremap <leader>tr :call svim#functions#ToggleRelativeNumber()<cr>| " toggle relative number

" LunarVim key bindings
    nnoremap <leader>q :qa<cr>

" keybindig for goyo
    nnoremap <leader>go :Goyo<cr>

" terminals : map esc key to switch to normal mode from terminal mode
    tnoremap <Esc> <C-\><C-n>
    for idx in range( 1, 9 )
        execute 'tnoremap <M-' . idx . '> <C-\><C-n>' . idx . 'gt'
    endfor
    if has('mac')
        for altc in items({'¡' : 1, '™': 2, '£': 3, '¢': 4, '∞': 5, '§': 6, '¶': 7, '•': 8, 'ª': 9}) " sed -n l => Alt + 1
            execute 'tnoremap ' . altc[0] . ' ' . '<C-\><C-n>' . altc[1] . 'gt'
        endfor
    endif
    for alph in ['w', 'h', 'j', 'k', 'l']
        execute 'tnoremap <C-w>' . alph . ' <C-\><C-n><C-w>' . alph
    endfor
    tnoremap <C-w><C-w> <C-\><C-n><C-w>w

" tabs : change tabs using \tn1, \tn2, \tn3...
    nnoremap <silent> <leader>tn :exe "tabn" nr2char(getchar())<cr>
    " move tab using S+H and S+L (mapping similar to LunarVim)
    nnoremap <silent> <S-H> :exe "tabp"<cr>
    nnoremap <silent> <S-L> :exe "tabn"<cr>

" windows : maximize window (virtually split only)
    nmap <leader>mm <C-w>1000>
    nmap <leader>mn <C-w>1000<

" for IndentLine plugin
    nnoremap <silent> <leader>ie :IndentLinesEnable<CR> :LeadingSpaceEnable<CR> 
    nnoremap <silent> <leader>id :IndentLinesDisable<CR> :LeadingSpaceDisable<CR> 

" set tags path inside .git folder
    nnoremap <leader>ta :tag 

" for plugin vim-plug - install and update plugins
    nnoremap <silent> <leader>pi :PlugInstall<CR> | " install plugins
    nnoremap <silent> <leader>pu :PlugUpdate<CR>  | " update plugins

" for plugin nerd tree : enable line numbers, make sure relative line numbers are used
    nnoremap <silent> <leader>e :NERDTreeToggle<CR> | " mapping similar to LunarVim
    nnoremap <silent> <leader>pt :NERDTreeToggle<Enter> :normal zz<CR> :wincmd p<CR>
    nnoremap <silent> <leader>ptf :NERDTreeFind<CR> :normal zz<CR> :wincmd p<CR>

" for plugin startify
    nnoremap <silent> <leader>; :Startify<CR> | " to match with LunarVim dashboard

" for plugin fzf
    nnoremap <leader>pf :GFiles<CR>
    nnoremap <leader>pF :Files<CR>
    nnoremap <leader>bb :Buffers<CR>
    nnoremap <leader>f  :GFiles<CR>  | " same as <leader>pf
    nnoremap <leader>b  :Buffers<CR> | " same as <leader>bb
    nnoremap <leader>w  :Windows<CR>
    nnoremap <leader>l  :BLines<CR>
    nnoremap <leader>L  :Lines<CR>
    nnoremap <leader>c  :Colors<CR>
    " Insert mode completion, fails on windows when it looks for /usr/share/dict/words.
    if has('macunix') || ('unix')
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        imap <c-x><c-l> <plug>(fzf-complete-line)
    endif
    " live grep - add Find and GFind command and mapping matching with LunarVim (<leader>st)
    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--no-hscroll --delimiter : --nth 4..'}), <bang>0)
    command! -bang -nargs=* GFind call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--no-hscroll --delimiter : --nth 4..'}), <bang>0)
    nnoremap <leader>t   :GFind<CR>
    nnoremap <leader>st  :GFind<CR>
    nnoremap <leader>sT  :Find<CR>
    " Open files in vertical horizontal split
    nnoremap <silent> <Leader>pfS :call fzf#run(fzf#wrap( { 'sink': 'botright split', 'down': '40%' } ))<CR>
    nnoremap <silent> <Leader>pfs :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink': 'botright split', 'down': '40%' } ))<CR>
    " Open files in horizontal split
    nnoremap <silent> <Leader>pfV :call fzf#run(fzf#wrap( { 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    nnoremap <silent> <Leader>pfv :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'vertical botright split', 'right': winwidth('.') / 2 } ))<CR>
    " Open files in another tab
    nnoremap <silent> <Leader>pfT :call fzf#run(fzf#wrap( { 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
    nnoremap <silent> <Leader>pft :call fzf#run(fzf#wrap( { 'source': 'git ls-files', 'sink':  'tabedit', 'window': 'botright 50vnew' } ))<CR>
    " Locate every file on the system
    command! -nargs=1 -bang Locate call fzf#run(fzf#wrap({'source': 'locate <q-args>', 'options': '-m'}, <bang>0))
    " An action can be a reference to a function that processes selected lines
    function! s:build_quickfix_list(lines)
      call setqflist(map(copy(a:lines), '{ "filename": v:val }')) | copen | cc
    endfunction
    " change fzf action to use ctrl-s instead of ctrl-x for horizontal split
    let g:fzf_action = { 'ctrl-c': function('s:build_quickfix_list'), 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }
    " change select-all from A-a to C-a. now can use C-a C-c to bring back all results to quickfix window
    let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" for plugin fzf-project
    let g:fzfSwitchProjectProjectDepth = 2 " one level deep for finding projects
    nnoremap <leader>pp :FzfSwitchProject<CR>| " select project using <Space>pp, similar to spacemacs and doom-emacs
    nnoremap <leader>p  :FzfSwitchProject<CR>| " efficient version (similar to f, b, t, w, l)
    let g:fzfSwitchProjectWorkspaces=[g:UC_WORKSPACE_FOLDER] " workspaces
    let g:fzfSwitchProjectProjects=[ g:UC_PLUGGED_DIR . '/vim-user-config', g:UC_HOME_DIR . '/.config/emacs/spacemacs/.emacs.d', g:UC_HOME_DIR . '/.config/emacs/doom-emacs/.emacs.d' ] " individual projects
    if has('nvim')
        call add(g:fzfSwitchProjectProjects, stdpath("config"))
    endif

" lsp mappings
    nnoremap <leader>lI :LspInstallInfo<CR>
    nnoremap <leader>li :LspInfo<CR>
    nnoremap <leader>ln :NullLsInfo<CR>

" Toggle header and cpp file - command is in functions.vim.
    nnoremap <silent> <leader>o :call svim#functions#SwitchSourceHeader()<CR>

" delete inactive buffers - command is in functions.vim.
    nnoremap <silent> <leader>bd :call svim#functions#DeleteInactiveBufs()<CR>

" refresh buffers if files changed outside vim - command is in functions.vim.
    nnoremap <silent> <leader>br :call svim#functions#BufDo("e")<cr><esc>

" add line above and below without leaving normal mode
    nnoremap <silent> <leader>ad :set paste<CR>m`o<Esc>``:set nopaste<CR>
    nnoremap <silent> <leader>au :set paste<CR>m`O<Esc>``:set nopaste<CR>

" copy and paste from system clipboard using \y and \p. 
" commented: system clipboard is default for copy, paste and delete.
    " nnoremap <leader>y "+y
    " nnoremap <leader>p "+p
    " nnoremap <leader>Y "+Y
    " nnoremap <leader>P "+P
    " nnoremap <leader>yy "+yy
    " vnoremap <leader>y "+y
    
" visual mode mapping 
    " for pasting but not yanking (change default behaviour)
    vnoremap p "_dP 
    " move text up and down
    vnoremap <M-j> :m .+1<CR>==
    vnoremap <M-k> :m .-2<CR>==
    
" update args with git listed files
    nnoremap <leader>a :args `git ls-files`<cr> 2<C-o>

" search TODO, FIXME or any text and put them in cwindow
    function! AgCommand(word, options)
        if !executable('ag')
            return s:warn('ag is not found, please install the_silver_searcher')
        endif
        cexpr system("ag --nogroup --column --vimgrep " . a:options . " " . a:word)
    endfunction
    function! RgCommand(word, options)
        if !executable('rg')
            return s:warn('rg is not found, please install ripgrep')
        endif
        cexpr system("rg --column --line-number --vimgrep " . a:options . " " . a:word)
    endfunction
    nnoremap <leader>stc  :silent vimgrep /TODO\\|FIXME/j % \| :cw<CR>
    nnoremap <leader>sta  :silent vimgrep /TODO\\|FIXME/j `git ls-files` \| :cw<CR>
    nnoremap <leader>sav  :execute 'silent vim! <cword> `git ls-files` \| copen \| cc'<cr>
    nnoremap <leader>saai :call AgCommand(expand("<cword>"), "--ignore-case")<cr>
    nnoremap <leader>saas :call AgCommand(expand("<cword>"), "--case-sensitive")<cr>
    nnoremap <leader>sari :call RgCommand(expand("<cword>"), "--ignore-case")<cr>
    nnoremap <leader>sars :call RgCommand(expand("<cword>"), "--case-sensitive")<cr>
    nnoremap <leader>sa   :call RgCommand(expand("<cword>"), "--case-sensitive")<cr>
    " nnoremap <leader>sa   :execute 'normal <leader>sars'<cr>
    nnoremap <leader>*    :Rg <C-R><C-W><CR>
    nnoremap <leader>#    :Ag <C-R><C-W><CR>
    nnoremap <leader>/    :Rg 
    nnoremap <leader>\t  /\|.\{-}\|<cr>| "search tags in vim help documents
    command! -nargs=+ VimCpp execute 'silent vim! <args> **/*.cpp **/*.c **/*.h' | copen | cc
    command! -nargs=+ VimH execute 'silent vim! <args> **/*.h' | copen | cc
    command! -nargs=+ Vim execute 'silent vim! <args> `git ls-files`' | copen | cc

" search and replace 
    nnoremap <leader>rc  :%s/\<<C-r>=expand("<cword>")<CR>\>/
    nnoremap <leader>raai :call AgCommand(expand("<cword>"), "-i")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>raas :call AgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rari :call RgCommand(expand("<cword>"), "-i")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rars :call RgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>ra   :call RgCommand(expand("<cword>"), "-s")<cr> :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    " nnoremap <leader>ra   :execute 'normal <leader>rars'<cr>
    nnoremap <leader>rav :Vim <cword><cr> :cfdo %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rad :argdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>
    nnoremap <leader>rcd :cfdo! %s/\<<C-r>=expand("<cword>")<CR>\>//gc\|w<left><left><left><left><left>

" use nvr to avoid nested nvim when using git commit in a terminal buffer
    if has('nvim')
        let $GIT_EDITOR = 'nvr -cc split --remote-wait'
    endif

" open terminal with splits (also git bash prompt)
    if has('win32')
        if has('nvim')
            let curWindow = ""
            let insertMode = "i"
        else
            let curWindow = "\+\+curwin"
            let insertMode = ""
        endif
        execute 'nnoremap <silent> <leader>asg  :new  \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asgv :vnew \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asgt :tabe \| term ' . curWindow . ' "c:\program files\Git\bin\bash.exe"<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asb  :new  \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asbv :vnew \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asbt :tabe \| term ' . curWindow . ' C:\Windows\System32\bash.exe<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asp  :new  \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>aspv :vnew \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>aspt :tabe \| term ' . curWindow . ' powershell<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asc  :new  \| term ' . curWindow . ' cmd<cr>' . insertMode
        execute 'nnoremap <silent> <leader>ascv :vnew \| term ' . curWindow . ' cmd<cr>' . insertMode
        execute 'nnoremap <silent> <leader>asct :tabe \| term ' . curWindow . ' cmd<cr>' . insertMode
        unlet curWindow insertMode
        nmap <leader>' <leader>asg
        nmap <leader><leader>' <leader>asgv
        nmap <leader><leader><leader>' <leader>asgt
        nmap <leader>" <leader>asc
        nmap <leader><leader>" <leader>ascv
        nmap <leader><leader><leader>" <leader>asct
    else
        nnoremap <silent> <leader>ascs :sp \| term<cr><insert>
        nnoremap <silent> <leader>ascv :vs \| term<cr><insert>
        nnoremap <silent> <leader>asct :tabe \| term<cr><insert>
        nnoremap <silent> <leader>asbs :sp \| term /bin/bash<cr><insert>
        nnoremap <silent> <leader>asbv :vs \| term /bin/bash<cr><insert>
        nnoremap <silent> <leader>asbt :tabe \| term /bin/bash<cr><insert>
        nmap <leader>' <leader>ascs
        nmap <leader><leader>' <leader>ascv
        nmap <leader><leader><leader>' <leader>asct
        nmap <leader>" <leader>asbs 
        nmap <leader><leader>" <leader>asbv
        nmap <leader><leader><leader>" <leader>asbt
    endif


" build rfwin projects
    nnoremap <leader>mrg :Dispatch ctxmake gfxrender<CR>
    nnoremap <leader>brg :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    nnoremap <leader>brgd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    nnoremap <leader>brt :!msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR>
    nnoremap <leader>brtd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR> 
    nnoremap <leader>bta :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender;src\pal\gfxvisualization;src\drivers\vd\vdtw\vdtw30n;src\drivers\vd\vdlfp /p:Configuration=Release /p:Platform=win32<CR>
