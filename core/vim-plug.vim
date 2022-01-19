" install plug.vim (bootstrap plugin)
let plugPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/autoload/plug.vim'
if empty(glob(plugPath))
    silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" add path to config path in runtimepath for plug.vim
let &rtp = &rtp . ',' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH
