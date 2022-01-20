function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugins : add all plugins here

    " plugins that adds custom operator, following from - https://thoughtbot.com/upcase/videos/extending-the-vim-language
    Plug 'tpope/vim-surround' " adds cs{ change scope }, ds{ delete scope } and ys{ add scope } 
    Plug 'tpope/vim-commentary' " adds gc{motion}, gcc (comment a line)   
    Plug 'vim-scripts/ReplaceWithRegister' " adds ["reg]gr{motion}, ["reg]grr (replace a line from reg rgister)
    Plug 'tommcdo/vim-exchange' " adds cx{ motion }, cxx (for line swap), and cxX (line swap in visual mode)
    Plug 'christoomey/vim-system-copy' 
    Plug 'christoomey/vim-sort-motion' 
    " plugin that adds custom text objects
    Plug 'kana/vim-textobj-user' " no text objects, used by other plugins
    Plug 'kana/vim-textobj-entire' " adds ae { entire_file } and ie { no_trailing_empty_lines } text object
    Plug 'kana/vim-textobj-indent' " ai, ii, aI, iI
    Plug 'kana/vim-textobj-line' " al, il
    " color scheme
    Plug 'morhetz/gruvbox' " grovebox color scheme
    Plug 'arcticicestudio/nord-vim' " nord color scheme
    Plug 'trevordmiller/nova-vim' " nova color schema
    Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only', Cond(has('nvim')) " solarized color scheme for neovim
    Plug 'altercation/vim-colors-solarized' " solarized color scheme. if not in gui then make sure terminal use solarized scheme.
    Plug 'vim-airline/vim-airline'
    Plug 'powerline/powerline-fonts' " install fonts manually (using install.ps1 or install.sh) for airline status
    " productivity plugins
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf vim
    Plug 'junegunn/fzf.vim' " fzf vim extra (GFile, Buffers etc commands)
    Plug 'benwainwright/fzf-project' " switch between project
    Plug 'stsewd/fzf-checkout.vim' " Manage branches and tags with fzf. 
    Plug 'tpope/vim-fugitive' " git plugin that wraps git commands
    Plug 'tommcdo/vim-fubitive' " Extend fugitive.vim to support Bitbucket URLs in :Gbrowse
    Plug 'neomake/neomake', Cond(has('nvim'))
    Plug 'nanotee/zoxide.vim', Cond(has('nvim'))
    Plug 'vim-syntastic/syntastic' " syntax checking
    Plug 'mhinz/vim-startify' " startup page
    Plug 'Yggdroot/indentLine' " add indent line
    Plug 'drmikehenry/vim-fontsize' " change font size using <leader><leader>+
    Plug 'soramugi/auto-ctags.vim' " auto generate tags using ctags, commands Ctags
    Plug 'airblade/vim-gitgutter' " git plugin to show changed lines 
    Plug 'arp242/auto_mkdir2.vim' " auto create directory during file save if directory does not exist
    Plug 'tpope/vim-dispatch' " background jobs. commands: :Make
    Plug 'jiangmiao/auto-pairs' " inserts quotes and parenthesis in pairs as you type
    Plug 'tpope/vim-unimpaired' " commonly used ex commands, ]q [q ]Q [Q etc...
    Plug 'tpope/vim-sensible' " some defaults agreed
    Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most. Mkdir!
    Plug 'godlygeek/tabular' " Tabular for aligning texts in tabular format
    Plug 'phaazon/hop.nvim', Cond(has('nvim')) " easy motion like plugin
    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    if has('nvim-0.5')
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " treesitter for better text color
        Plug 'nvim-lua/plenary.nvim'  " dependencies for luss-ls
        Plug 'neovim/nvim-lspconfig'  " nvim lsp configure
        Plug 'williamboman/nvim-lsp-installer' " nvim lsp install and configure using nvim-lspconfig
        Plug 'tamago324/nlsp-settings.nvim' " to configure Neovim LSP using json files
        Plug 'jose-elias-alvarez/null-ls.nvim', {'commit': '288c4582f62f04944412acaed098fc16a1818464'} " null-ls language server for formatter and linter (in addition to lsp)
        Plug 'ms-jpq/coq_nvim', {'branch': 'coq'} " run :COQdeps (only once) and then :COQnow
        Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    else
        Plug 'sheerun/vim-polyglot' " used by nova color schema, multiple programming language support (basic). tree-sitter is replacing this plugin.
        Plug 'HerringtonDarkholme/yats.vim' " Add a syntax file for typescript. YATS is the best. tree-sitter is replacing this plugin.
        Plug 'octol/vim-cpp-enhanced-highlight' " tree-sitter is replacing this plugin.
        " Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' } " code completion
        Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode. complete with YouCompleteMe
        if !has('win32unix') " vim not in msys
            Plug 'SirVer/ultisnips' " Track the engine. for snippets.
        endif
    endif
    Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
    " Code to execute when the plugin is lazily loaded on demand
    Plug 'junegunn/goyo.vim' " , { 'for': 'markdown' }
    Plug 'junegunn/limelight.vim' " limelight used with goyo (see autocmd)
    " language support
    Plug 'kevinoid/vim-jsonc' " vim syntax highlight plugin for json with c-style (// and /**/) comments
    Plug 'PProvost/vim-ps1' " powershell syntax coloring
    Plug 'rust-lang/rust.vim' " rust language support
    Plug 'fatih/vim-go' " , { 'do': ':GoUpdateBinaries' } " golang support
    Plug 'mattn/webapi-vim' " webapi neede by rust pluggin
    Plug 'rhysd/vim-healthcheck', Cond(!has('nvim')) " CheckHealth in vim


    " Plug 'szw/vim-tags' " auto generate tags using ctags, command TagsGenerate. disable because this plugin will change `:cd` during GFile or other fzf commands.
    " Plug 'ludovicchabant/vim-gutentags' " auto generate tags - no external dependncies other than ctags. will use this instead of auto-ctags
    " Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " typescript support, commented out because of error on quiting vim / neovim


