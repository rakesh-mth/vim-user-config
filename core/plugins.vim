function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugins : add all plugins here

    " plugins that adds custom operator, following from - https://thoughtbot.com/upcase/videos/extending-the-vim-language
    Plug 'tpope/vim-surround' " adds cs{ change scope }, ds{ delete scope } and ys{ add scope } 
    Plug 'tpope/vim-commentary' " adds gc{motion}, gcc (comment a line)   
    Plug 'vim-scripts/ReplaceWithRegister' " adds ["reg]gr{motion}, ["reg]grr (replace a line from reg rgister)
    Plug 'tommcdo/vim-exchange' " adds cx{ motion }, cxx (fot line swap), and cxX (line swap in visual mode)
    Plug 'christoomey/vim-system-copy' 
    Plug 'christoomey/vim-sort-motion' 
    " plugin that adds custom text objects
    Plug 'kana/vim-textobj-user' " no text objects, used by other plugins
    Plug 'kana/vim-textobj-entire' " adds ae { entire_file } and ie { no_trailing_empty_lines } text object
    Plug 'kana/vim-textobj-indent' " ai, ii, aI, iI
    Plug 'kana/vim-textobj-line' " al, il
    " productivity plugins
    Plug 'arcticicestudio/nord-vim' " nord color scheme
    Plug 'trevordmiller/nova-vim' " nova color schema
    Plug 'morhetz/gruvbox' " grovebox color scheme
    Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only', Cond(has('nvim')) " solarized color scheme for neovim
    Plug 'altercation/vim-colors-solarized' " solarized color scheme. if not in gui then make sure terminal use solarized scheme.
    Plug 'vim-airline/vim-airline'
    Plug 'powerline/powerline-fonts'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf vim
    Plug 'junegunn/fzf.vim' " fzf vim extra (GFile, Buffers etc commands)
    Plug 'stsewd/fzf-checkout.vim' " Manage branches and tags with fzf. 
    Plug 'neomake/neomake', Cond(has('nvim'))
    Plug 'vim-syntastic/syntastic' " syntax checking
    Plug 'mhinz/vim-startify' " startup page
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'Yggdroot/indentLine' " add indent line
    Plug 'drmikehenry/vim-fontsize' " change font size using <leader><leader>+
    Plug 'szw/vim-tags' " auto generate tags using ctags, command TagsGenerate
    Plug 'soramugi/auto-ctags.vim' " auto generate tags using ctags, commands Ctags
    Plug 'airblade/vim-gitgutter' " git plugin to show changed lines 
    Plug 'arp242/auto_mkdir2.vim' " auto create directory during file save if directory does not exist
    Plug 'tpope/vim-fugitive' " git plugin that wraps git commands
    Plug 'tommcdo/vim-fubitive' " Extend fugitive.vim to support Bitbucket URLs in :Gbrowse
    Plug 'tpope/vim-dispatch' " background jobs. commands: :Make
    Plug 'jiangmiao/auto-pairs' " inserts quotes and parenthesis in pairs as you type
    Plug 'tpope/vim-unimpaired' " commonly used ex commands, ]q [q ]Q [Q etc...
    Plug 'tpope/vim-sensible' " some defaults agreed
    Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most. Mkdir!
    Plug 'godlygeek/tabular' " Tabular for aligning texts in tabular format
    " NERD tree will be loaded on the first invocation of NERDTreeToggle command
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    if has('win32unix')
    else
        Plug 'SirVer/ultisnips' " Track the engine. for snippets.
        if !has('nvim-0.5')
            " Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' } " code completion
            Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode. complete with YouCompleteMe
        endif
    endif
    if has('nvim-0.5')
        Plug 'neovim/nvim-lspconfig'
        Plug 'nvim-lua/completion-nvim'
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
    Plug 'HerringtonDarkholme/yats.vim' " Add a syntax file for typescript. YATS is the best
    " Plug 'mhartington/nvim-typescript', {'do': './install.sh'} " typescript support, commented out because of error on quiting vim / neovim
    Plug 'sheerun/vim-polyglot' " used by nova color schema, multiple programming language support (basic)
    Plug 'mattn/webapi-vim' " webapi neede by rust pluggin
    Plug 'rhysd/vim-healthcheck', Cond(!has('nvim'))
    " user vim configurations
    Plug 'rakesh-mth/vim-user-config' 

