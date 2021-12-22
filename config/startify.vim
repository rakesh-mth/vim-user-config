" startify configurations

let g:startify_bookmarks = [WORKSPACE_FOLDER]
if has('win32')
    let g:startify_bookmarks = g:startify_bookmarks + [g:UC_HOME_DIR . '/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1']
endif


