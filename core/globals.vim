" add all globals here

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
