
if !has('nvim')
    if has('win32')
        set directory=~\AppData\Local\Temp
        set backupdir=~\AppData\Local\Temp
        set undodir=~\AppData\Local\Temp
    else
        set directory=~/temp
        set backupdir=~/temp
        set undodir=~/temp
    endif
endif
