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


" set viminfo for startify to work with vim
if !has('nvim') && has('win32') | set viminfo+=n~/_viminfo | endif

" configure options (string, number, list)
let &cdpath=g:UC_WORKSPACE_FOLDER . ',,' " cdpath to easily change directory using lcd (lcd foldername-in-cdpath)
