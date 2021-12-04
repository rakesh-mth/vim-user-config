" lsp config for nvim version > 0.5


if has('nvim-0.5')
lua <<EOF
require'lspconfig'.golangci_lint_ls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.pylsp.setup{cmd={'pyls'}}
require'lspconfig'.clangd.setup{}
EOF
endif
