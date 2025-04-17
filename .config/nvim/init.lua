vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

-- https://github.com/nvim-treesitter/nvim-treesitter#available-modules
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "python",
    "typescript",
    "javascript",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt.updatetime = 200
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { '*' },
  callback = function() vim.lsp.buf.document_highlight() end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
  pattern = { '*' },
  callback = function() vim.lsp.buf.clear_references() end,
})

-- https://neovim.io/doc/user/lsp.html#lsp-config
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc
    local function keymap(lhs, rhs, opts, mode)
        opts = type(opts) == 'string' and { desc = opts }
            or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
        mode = mode or 'n'
        vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function feedkeys(keys)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
    end

    local function pumvisible()
        return tonumber(vim.fn.pumvisible()) ~= 0
    end

    if client.supports_method('textDocument/completion') then
      -- Enable auto-completion
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- Enter to accept completion.
      keymap('<Enter>', function()
          return pumvisible() and '<C-y>' or '<Enter>'
      end, { expr = true }, 'i')
      -- Tab to step forward through completions.
      keymap('<Tab>', function()
        if pumvisible() then
          feedkeys '<C-n>'
        elseif next(vim.lsp.get_clients { bufnr = 0 }) then
          vim.lsp.completion.get()
        else
          feedkeys '<Tab>'
        end
      end, {}, 'i')
      -- Shift-Tab to step backward through completions.
      keymap('<S-Tab>', function()
            if pumvisible() then
                feedkeys '<C-p>'
            else
                feedkeys '<S-Tab>'
            end
        end, {}, 'i')
    end

  end,
})

require'lspconfig'.clangd.setup{}
require'lspconfig'.lua_ls.setup{
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
}
require'lspconfig'.pyright.setup{}
require'lspconfig'.ts_ls.setup{}

vim.lsp.enable({'clangd', 'pyright', 'ts_ls'})

vim.o.winborder = 'rounded'

vim.diagnostic.config({
  virtual_lines = true
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gh', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gr', function () vim.lsp.buf.references(nil, { loclist = true }) end)
