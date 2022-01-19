" add python exe locations (virtualenvs)

if has('win32') || has('win32unix')
    let python2_vp  = g:UC_HOME_DIR . '/virtualenvs/python27/Scripts/'
    let python38_vp = g:UC_HOME_DIR . '/virtualenvs/python38/Scripts/'
    let python39_vp = g:UC_HOME_DIR . '/virtualenvs/python39/Scripts/'
    let python_exe  = 'python.exe' 
elseif has('mac') || has('unix')
    let python2_vp  = g:UC_HOME_DIR . '/.virtualenvs/python2.7/bin/'
    let python38_vp = g:UC_HOME_DIR . '/.virtualenvs/python3.8/bin/'
    let python39_vp = g:UC_HOME_DIR . '/.virtualenvs/python3.9/bin/'
    let python_exe  = 'python'
endif
if !empty(glob(python2_vp . python_exe))  | let g:python_host_prog  = python2_vp  . python_exe | endif
if !empty(glob(python38_vp. python_exe))  | let g:python3_host_prog = python38_vp . python_exe | endif
if !empty(glob(python39_vp . python_exe)) | let g:python3_host_prog = python39_vp . python_exe | endif

" modify path to use python from virtual env

if !empty(glob(python38_vp . 'nvr')) | let $PATH = python38_vp . ':' . $PATH | endif
if !empty(glob(python39_vp . 'nvr')) | let $PATH = python39_vp . ':' . $PATH | endif
