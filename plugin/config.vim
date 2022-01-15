" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using neovim

" set commands : set default configs
    set showmatch           " Show matching brackets.
    set number              " Show the line numbers on the left side.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=4           " Render TABs using this many spaces.
    set shiftwidth=4        " Indentation amount for < and > commands.
    set path+=**            " search files in subfolders
    set relativenumber      " enable relative number, set rnu or set nornu, shortcuts
    set exrc                " load vimrc from current folder
    set secure              " disable shell, autocmd and write command when loading vimrc from local directory
    set foldmethod=indent   " fold method
    set foldnestmax=10      " fold settings
    set nofoldenable        " no fold on open a file
    set foldlevel=2         " fold level
    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.
    set splitbelow          " Horizontal split below current. -- More natural splits
    set splitright          " Vertical split to right of current. -- More natural splits
    set hlsearch            " search highlighting, not default in vim, default in neovim.
    set incsearch           " search while typing. `set is` or `set nois`. default in vim and neovim.
    set mouse=a             " enable mouse support (resize splits, etc...)
    set colorcolumn=120     " Indent line at what column? Set something like '99999' to not display it
    set scrolloff=5         " Determines the number of context lines you would like to see above and below the cursor
    set clipboard=unnamedplus   " use system clipboard ('+') for copy, paste and delete. all goes to '+' register.
    set cedit=\<C-Y>            " use C-y to go to command mode window (q:) from command mode
    " set cursorcolumn          " enable cursor column drawing
    if has('win32unix')
        set termguicolors   " enable true color
    else
        let colorterm=$COLORTERM
        if colorterm =~# 'truecolor' || colorterm =~# '24bit'
            set termguicolors       " enable true color
        endif
    endif
    set cursorline          " color the cursor line, highlight current line.
    set history=10000       " history of ex command. nvim default: 10000, vim default: 1000. keep is consistent to 10000.
    filetype plugin on
    syntax on
    let mapleader = "\<Space>" " map leader key to Space

" user home dir - g:UC_HOME_DIR should be defined in init.vim, redfine if it is not already.
    if !exists('g:UC_HOME_DIR')
        if has('win32') | let g:UC_HOME_DIR = $USERPROFILE | else | let g:UC_HOME_DIR = $HOME | endif
        let g:UC_HOME_DIR = substitute(g:UC_HOME_DIR, "\\", "\/", "g")
    endif
" vim and nvim folder - g:UC_VIM_FOLDER should be defined in init.vim, redfine if it is not already
    if !exists('g:UC_VIM_FOLDER')
        if has('nvim') | let g:UC_VIM_FOLDER = "nvim-config/rakesh-mth" | else | let g:UC_VIM_FOLDER = "vim-config/rakesh-mth" | endif
    endif
" vim folder full path - g:UC_VIM_CONFIG_FOLDER_FULL_PATH should be defined in init.vim, redfine if it is not already
    if !exists('g:UC_VIM_CONFIG_FOLDER_FULL_PATH')
        let g:UC_VIM_CONFIG_FOLDER_FULL_PATH = g:UC_HOME_DIR . '/.config/' . g:UC_VIM_FOLDER
    endif
" plugged folder - g:UC_PLUGGED_DIR should be defined in init.vim, redfine if it is not already
    if !exists('g:UC_PLUGGED_DIR')
        let g:UC_PLUGGED_DIR = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/plugged' " Specify a directory for plugins 
    endif
" workspace folder - g:WORKSPACE_DIR should be defined in init.vim, redefine if it is not already
    if !exists('g:UC_WORKSPACE_FOLDER')
        let g:UC_WORKSPACE_FOLDER= has('win32') ? 'f:\DevTrees' : $HOME . '/workspaces'
    endif

" add python exe locations (virtualenvs)
    if has('win32') || has('win32unix')
        let python2_vp  = g:UC_HOME_DIR . '/virtualenvs/python27/Scripts/'
        let python38_vp = g:UC_HOME_DIR . '/virtualenvs/python38/Scripts/'
        let python39_vp = g:UC_HOME_DIR . '/virtualenvs/python39/Scripts/'
        let python_exe  = 'python.exe' 
    elseif has('mac') || has('unix')
        let python2_vp  = g:UC_HOME_DIR . '/.virtualenvs/python2.7/bin/'
        let python38_vp = g:UC_HOME_DIR . '/.virtualenvs/python3.8/bin/'
        let python39_vp = g:UC_HOME_DIR . '/.virtualenvs/python3.9/bin/'
        let python_exe  = 'python'
    endif
    if !empty(glob(python2_vp . python_exe))  | let g:python_host_prog  = python2_vp  . python_exe | endif
    if !empty(glob(python38_vp. python_exe))  | let g:python3_host_prog = python38_vp . python_exe | endif
    if !empty(glob(python39_vp . python_exe)) | let g:python3_host_prog = python39_vp . python_exe | endif
    if !empty(glob(python38_vp . 'nvr')) | let $PATH = python38_vp . ':' . $PATH | endif
    if !empty(glob(python39_vp . 'nvr')) | let $PATH = python39_vp . ':' . $PATH | endif

" add ruby and gem (user) path to PATH. install neovim gem using `gem install --user-install neovim`
    if has('mac') " use homebrew ruby
        let $PATH = '/usr/local/opt/ruby/bin/:'.$PATH 
        let gem_path = trim(system('gem environment gempath | cut -d ":" -f 1'))
        let ruby_host_prog = gem_path . '/bin/neovim-ruby-host'
        if !empty(glob(ruby_host_prog)) | let g:ruby_host_prog = ruby_host_prog | endif
    endif

" add fzf into path on windows. use from pluggin instead of system installed using choco.
    if has('win32')
         let $PATH = $USERPROFILE."\\.fzf\\bin;".$PATH
    endif

" install plug.vim (bootstrap plugin)
    let plugPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/autoload/plug.vim'
    if empty(glob(plugPath))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    let &rtp = &rtp . ',' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH

" set viminfo for startify to work with vim
    if !has('nvim') && has('win32') | set viminfo+=n~/_viminfo | endif


" configure option (string, number, list) and env variables
    if has('win32')
        let $PATH='C:\Program Files\Git\bin;'.$PATH " add git-bash in the path for fzf + bat to work correctly
    endif
    let &cdpath=g:UC_WORKSPACE_FOLDER . ',,' " cdpath to easily change directory using lcd (lcd foldername-in-cdpath)

" lsp for omni func complition
    " autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

" toggle gui elements in VIM (no impact in nvim-qt)
    function! ToggleGUICruft()
      if &guioptions==''
        exec('set guioptions=imTr')
      else
        exec('set guioptions-=imTr')
      endif
    endfunction
    nnoremap <F11> <Esc>:call ToggleGUICruft()<cr>

" spell checker
    map <leader>sp :setlocal spell! spelllang=en_us<cr>

" disable highlights
    nnoremap <leader>nh :noh<cr>    

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
    let s:fullScreen = 0
    function! ToggleFullScreen()
        if (s:fullScreen == 1) | let s:fullScreen = 0 | else | let s:fullScreen = 1 | endif
        if has('gui_macvim') " macvim
            if (&fullscreen == 1) | set nofullscreen | else | set fullscreen | endif
        elseif exists('g:GuiLoaded') " nvim-qt
            call GuiWindowFullScreen(s:fullScreen)
        endif
    endfunc
    if has('nvim')
        if exists('g:fvim_loaded')
            nnoremap <leader>TF :FVimToggleFullScreen<CR>
        elseif has('gui_vimr')
            nnoremap <leader>TF :VimRToggleFullscreen<CR>
        else
            nnoremap <leader>TF :call ToggleFullScreen()<CR>
        endif
        inoremap <silent>  <S-Insert>  <C-R>+| "paste from system clipboard in insert mode
    elseif has('gui_macvim')
        nnoremap <leader>TF :call ToggleFullScreen()<CR>
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
    " Toggle buffer
    let s:bufferState = 0
    function! BufferToggle()
      if(s:bufferState == 1) | let s:bufferState = 0 | bp | else | let s:bufferState = 1 | bn | endif
    endfunc
    nnoremap <leader><TAB> :call BufferToggle()<cr>| " Toggle between presious and current buffer.
    nnoremap <leader><leader> :| " switch to command mode
    nnoremap <leader>fed :e $MYVIMRC<cr>| " open vim configuration file (.vimrc or init.vim)
    nnoremap <leader>gb  :GBranches<cr>| " open  page (from fugitive)
    nnoremap <leader>gt  :GTags<cr>| " open  page (from fugitive)
    nnoremap <leader>gg  :Git \| wincmd _ \| normal gu<cr>| " open git status page (from fugitive), and jump to Unstaged
    nnoremap <leader>gp  :Git push<cr> " push to remote branch
    nnoremap <leader>gc  :Commits<cr>| " open commit list in current branch
    nnoremap <leader>gd :tabe \| Git diff \| wincmd o<cr>| " open git diff in new tab
    nnoremap <leader>gdd :tabe \| Git diff --staged \| wincmd o<cr>| " open git diff in new tab
    " Toggle cursor column
    function! ToggleCursorCol() abort
      if &cursorcolumn | set nocursorcolumn | else | set cursorcolumn | endif
    endfunction
    " toggle relativenumber
    function! ToggleRelativeNumber() abort " can also use: nornu and rnu
      if &relativenumber | set relativenumber! | else | set relativenumber | endif
    endfunction
    nnoremap <leader>tc :call ToggleCursorCol()<cr>| " toggle cursor column
    nnoremap <leader>tr :call ToggleRelativeNumber()<cr>| " toggle relative number

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

" tabs : change tabs using \tn1, \tn2, \tn3..., and Alt-1, Alt-2, Alt-3...
    function! AltMapping()
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

" for plugin nerd tree : enable line numbers, make sure relative line numbers are used
    nnoremap <silent> <leader>pt :NERDTreeToggle<Enter> :normal zz<CR> :wincmd p<CR>
    nnoremap <silent> <leader>ptf :NERDTreeFind<CR> :normal zz<CR> :wincmd p<CR>

" for plugin fzf
    noremap <leader>pf :GFiles<CR>
    noremap <leader>pF :Files<CR>
    noremap <leader>bb :Buffers<CR>
    noremap <leader>f  :GFiles<CR>  | " same as <leader>pf
    noremap <leader>b  :Buffers<CR> | " same as <leader>bb
    noremap <leader>w  :Windows<CR>
    noremap <leader>l  :BLines<CR>
    noremap <leader>L  :Lines<CR>
    noremap <leader>c  :Colors<CR>
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
    noremap <leader>t   :GFind<CR>
    noremap <leader>st  :GFind<CR>
    noremap <leader>sT  :Find<CR>
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
    noremap <leader>pp :FzfSwitchProject<CR>| " select project using <Space>pp, similar to spacemacs and doom-emacs
    noremap <leader>p  :FzfSwitchProject<CR>| " efficient version (similar to f, b, t, w, l)
    let g:fzfSwitchProjectWorkspaces=[g:UC_WORKSPACE_FOLDER] " workspaces
    let g:fzfSwitchProjectProjects=[ stdpath("config"), g:UC_PLUGGED_DIR . '/vim-user-config', g:UC_HOME_DIR . '/.config/emacs/spacemacs/.emacs.d', g:UC_HOME_DIR . '/.config/emacs/doom-emacs/.emacs.d' ] " individual projects

" move files from copen to args from https://stackoverflow.com/questions/5686206/search-replace-using-quickfix-list-in-vim
    command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
    function! QuickfixFilenames()
      " Building a hash ensures we get each buffer only once
      let buffer_numbers = {}
      for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
      endfor
      return join(values(buffer_numbers))
    endfunction

" Toggle header and cpp file
    function! SwitchSourceHeader()
        if (expand("%:e") == "cpp" || expand("%:e") == "c")
            execute 'tag ' . expand("%:t:r") . '.h'
        elseif (expand("%:e") == "h")
            execute 'tag ' . expand("%:t:r") . '.cpp'
        else
            echo "file in not either .h, .c or .cpp"
        endif
    endfunction
    nnoremap <silent> <leader>o :call SwitchSourceHeader()<CR>

" delete inactive buffers
    function! DeleteInactiveBufs()
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
    command! Bdi :call DeleteInactiveBufs()
    nnoremap <silent> <leader>bd :call DeleteInactiveBufs()<CR>

" refresh buffers if files changed outside vim 
    " Like bufdo but restore the current buffer.
    function! BufDo(command)
        let currBuff=bufnr("%")
        execute 'bufdo ' . a:command 
        execute 'buffer ' . currBuff 
    endfunction
    command! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
    noremap <leader>br :Bufdo e<cr><esc>

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
    noremap <leader>a :args `git ls-files`<cr> 2<C-o>

" search TODO, FIXME or any text and put them in cwindow
    function! AgCommand(word, options)
        if !executable('ag')
            return s:warn('ag is not found, please install the_silver_searcher')
        endif
        cexpr system("ag --nogroup --column --vimgrep " . a:options . " " . a:word)
    endfunc
    function! RgCommand(word, options)
        if !executable('rg')
            return s:warn('rg is not found, please install ripgrep')
        endif
        cexpr system("rg --column --line-number --vimgrep " . a:options . " " . a:word)
    endfunc
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
        " delete git commit buffer after :wq, git waits for nvr to finish
        augroup git_commit
            autocmd! FileType gitcommit,gitrebase set bufhidden=delete
        augroup END
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

" auto commands on events
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

    " auto source vimrc after writing new changes
    augroup source_vimrc
        autocmd! BufWritePost $MYVIMRC source $MYVIMRC
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
        autocmd FileType gitcommit,gitrebase 1 | startinsert
    augroup END

    function! VimEnterFunction()
        call AltMapping()
    endfun
    augroup VimEnterGroup
        autocmd!
        autocmd VimEnter * call VimEnterFunction()
    augroup END

" build rfwin projects
    noremap <leader>mrg :Dispatch ctxmake gfxrender<CR>
    noremap <leader>brg :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brgd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brt :!msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR>
    noremap <leader>brtd :Dispatch! msbuild CitrixReceiver\WFCAll.sln  /t:src\drivers\vd\vdtw\vdtw30n /p:Configuration=Release /p:Platform=win32<CR> 
    noremap <leader>bta :!msbuild CitrixReceiver\WFCAll.sln  /t:src\pal\gfxrender;src\pal\gfxvisualization;src\drivers\vd\vdtw\vdtw30n;src\drivers\vd\vdlfp /p:Configuration=Release /p:Platform=win32<CR>


" source plug configs. coc.nvim is used with neovim < 0.5.
if !has('win32unix') && !has('nvim-0.5')
    let CONFIG_DIR = expand('%:p:h')
    let COC_VIM_PATH =  CONFIG_DIR . "/../config/coc/coc.vim"
    let COC_EXTENSIONS_PATH = CONFIG_DIR . "/../config/coc/coc-extensions.vim"
    if filereadable(COC_VIM_PATH) | exec "source " . COC_VIM_PATH | endif
    if filereadable(COC_EXTENSIONS_PATH) | exec "source " . COC_EXTENSIONS_PATH | endif
endif

" source all plugin configs
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/tags-config.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/indent-config.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/nerdtree-config.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/ultisnip-config.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/cpp-config.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/startify.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/log.vim'

" source lua files
if has('nvim-0.5') && exists("g:lspconfig")
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/lsp_config.lua'
endif
