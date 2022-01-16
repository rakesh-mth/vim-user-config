local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>.
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- enable lsp servers. commented because of below for loop.
-- nvim_lsp.golangci_lint_ls.setup{}
-- nvim_lsp.gopls.setup{}
-- nvim_lsp.pylsp.setup{cmd={'pyls'}}
-- nvim_lsp.clangd.setup{}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- [rakesh] commented because nvim-lsp-installer will be used below
-- local servers = { "golangci_lint_ls", "gopls", "pylsp", "clangd", "rust_analyzer", "tsserver" }
-- for _, lsp in ipairs(servers) do
-- 	nvim_lsp[lsp].setup({
-- 		on_attach = on_attach,
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- 	})
-- end

-- using nvim-lsp-installer
local lsp_installer = require("nvim-lsp-installer")
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
	}
	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- config for null-ls
require("null-ls").setup({
	sources = {
		-- lua formatter and linter
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.luacheck,
		-- python formatter and linter
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.diagnostics.flake8,
		-- spell completion
		require("null-ls").builtins.completion.spell,
	},
})
