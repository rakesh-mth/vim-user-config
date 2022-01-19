" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using neovim

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

" install plug.vim (bootstrap plugin)
let plugPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/autoload/plug.vim'
if empty(glob(plugPath))
    silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" add path to SVIM config in runtimepath
let &rtp = &rtp . ',' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH

" source all plugin configs
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/options.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/mappings.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/autocmd.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/python.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/startify.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/path.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/log.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/tags-config.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/indent-config.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/nerdtree-config.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/ultisnip-config.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/cpp-config.vim'

" source lua files
if has('nvim-0.5') && exists("g:lspconfig")
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/lsp_config.lua'
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/treesitter.lua'
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/hop.lua'
endif

" set viminfo for startify to work with vim
if !has('nvim') && has('win32') | set viminfo+=n~/_viminfo | endif

" configure options (string, number, list)
let &cdpath=g:UC_WORKSPACE_FOLDER . ',,' " cdpath to easily change directory using lcd (lcd foldername-in-cdpath)


" source plug configs. coc.nvim is used with neovim < 0.5.
if !has('win32unix') && !has('nvim-0.5')
    let CONFIG_DIR = expand('%:p:h')
    let COC_VIM_PATH =  CONFIG_DIR . "/../config/coc/coc.vim"
    let COC_EXTENSIONS_PATH = CONFIG_DIR . "/../config/coc/coc-extensions.vim"
    if filereadable(COC_VIM_PATH) | exec "source " . COC_VIM_PATH | endif
    if filereadable(COC_EXTENSIONS_PATH) | exec "source " . COC_EXTENSIONS_PATH | endif
endif


