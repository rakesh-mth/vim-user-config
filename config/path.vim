if has('win32')
    " add git-bash in the path for fzf + bat to work correctly
    let $PATH='C:\Program Files\Git\bin;'.$PATH 
    " add fzf into path on windows. use from pluggin instead of system installed using choco.
     let $PATH = $USERPROFILE."\\.fzf\\bin;".$PATH
     " add lua binaries into path for luacheck
     let $PATH = "C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\bin;".$PATH
endif


if has('mac') 
    " add ruby and gem (user) path to PATH. install neovim gem using `gem install --user-install neovim`. use homebrew ruby.
    let $PATH = '/usr/local/opt/ruby/bin/:'.$PATH 
    let gem_path = trim(system('gem environment gempath | cut -d ":" -f 1'))
    let ruby_host_prog = gem_path . '/bin/neovim-ruby-host'
    if !empty(glob(ruby_host_prog)) | let g:ruby_host_prog = ruby_host_prog | endif
endif
