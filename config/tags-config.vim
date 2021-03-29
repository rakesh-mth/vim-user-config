" for plugin vim-tags and auto-ctags - auto generate tags on file saving. using vim-tags by defualt.

let g:auto_ctags = 0
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_tags_args = ['--tag-relative=yes', '--recurse=yes', '--sort=yes', '--exclude=layout', '--exclude=outputs', '--exclude=sdk']
let g:auto_ctags_set_tags_option = ''
let g:vim_tags_auto_generate = 0
let g:vim_tags_directories = ['.git', '.hg', '.svn', '.bzr', '_darcs', 'CVS']
let g:vim_tags_ignore_files = []
let g:vim_tags_project_tags_command = "fd -e cpp -e h -e json -e yml -e txt | ctags -f .git/tags --tag-relative=yes --extra=+f -L - "
" let g:vim_tags_use_vim_dispatch = 1

" set tags path inside .git folder
set tags=./tags,.git/tags
