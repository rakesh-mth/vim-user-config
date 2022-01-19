" copy content of this file to ~/.config/nvim/init.vim on mac and linux when using neovim


" source gloabls.vim and vim-plug.vim. vim-plug.vim is used for installing vim-plug.
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/core/globals.vim'
exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/core/vim-plug.vim'

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
" source coc.nvim configs. coc.nvim is used with neovim < 0.5.
if !has('win32unix') && !has('nvim-0.5')
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/coc/coc.vim'
    exec 'source ' . g:UC_PLUGGED_DIR . '/vim-user-config/config/coc/coc-extensions.vim'
endif

" source lua files
if has('nvim-0.5') && exists("g:lspconfig")
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/lsp_config.lua'
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/treesitter.lua'
    exec 'luafile ' . g:UC_PLUGGED_DIR . '/vim-user-config/lua/svim/hop.lua'
endif

