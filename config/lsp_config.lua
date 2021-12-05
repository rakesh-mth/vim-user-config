lspconfig = require'lspconfig'

lspconfig.golangci_lint_ls.setup{}
lspconfig.gopls.setup{}
lspconfig.pylsp.setup{cmd={'pyls'}}
lspconfig.clangd.setup{}
