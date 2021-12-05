" function for logging 

function! ToggleVerbose()
    if !&verbose
        let logPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/log/verbose.log'
        " echom logPath
        set verbosefile=logPath
        set verbose=15
    else
        set verbose=0
        set verbosefile=
    endif
endfunction
