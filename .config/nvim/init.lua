-- BOOTSTRAP

vim.loader.enable()

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

local function try(name, fn)
  local ok, err = pcall(fn)
  if not ok then vim.notify(name .. ': ' .. err, vim.log.levels.WARN) end
end

local function autocmd(group, event, opts)
  -- Reloading this config file would add duplicate autocommands
  -- unless they are part of a group.
  if type(group) == 'string' then
    -- The default behavior is to clear. We are explicit here anyway.
    group = vim.api.nvim_create_augroup(group, { clear = true })
  end
  opts = vim.tbl_extend('error', { group = group }, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

-- OPTIONS

vim.opt.updatetime = 200

pcall(function () vim.opt.winborder = 'rounded' end)

-- DIAGNOSTICS

vim.diagnostic.config({
  virtual_lines = { current_line =  true },
})

-- TREESITTER

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main#supported-features
autocmd('my.treesitter', 'FileType', {
  callback = function(args)
    -- Fails harmlessly when no parser exists for this filetype.
    if pcall(vim.treesitter.start, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- LANGUAGE SERVER PROTOCOL

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    -- '--log-verbose',
  },
})

vim.lsp.config('lua_ls', {
  settings = { Lua = {
    runtime = { version = 'LuaJIT' },
    workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
  } },
})

vim.lsp.enable({
  'clangd',
  'lua_ls',
  'pyright',
  'starpls',
  'ts_ls',
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gh', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gri', function () vim.lsp.buf.implementation({ loclist = true }) end)
vim.keymap.set('n', 'grr', function () vim.lsp.buf.references(nil, { loclist = true }) end)
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)

-- https://neovim.io/doc/user/lsp.html#lsp-config
autocmd('my.lsp', 'LspAttach', {
  callback = function (args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc
    local function keymap(mode, lhs, rhs, opts)
      opts = opts or {}
      opts = vim.tbl_extend('error', opts, { buffer = args.buf })
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function feedkeys(keys)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
    end

    local function pumvisible()
      return tonumber(vim.fn.pumvisible()) ~= 0
    end

    if client:supports_method('textDocument/documentHighlight') then
      local group = vim.api.nvim_create_augroup('my.cursor.' .. args.buf, {})
      autocmd(group, 'CursorHold', {
        buffer = args.buf,
        callback = function () vim.lsp.buf.document_highlight() end,
      })
      autocmd(group, 'CursorMoved', {
        buffer = args.buf,
        callback = function () vim.lsp.buf.clear_references() end,
      })
    end

    if client:supports_method('textDocument/completion') and vim.lsp.completion then
      -- Enable auto-completion.
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- Enter to accept completion.
      keymap('i', '<Enter>', function ()
        return pumvisible() and '<C-y>' or '<Enter>'
      end, { expr = true })
      -- Tab to step forward through completions.
      keymap('i', '<Tab>', function ()
        if pumvisible() then
          feedkeys '<C-n>'
        elseif next(vim.lsp.get_clients { bufnr = 0 }) then
          vim.lsp.completion.get()
        else
          feedkeys '<Tab>'
        end
      end)
      -- Shift-Tab to step backward through completions.
      keymap('i', '<S-Tab>', function ()
        if pumvisible() then
          feedkeys '<C-p>'
        else
          feedkeys '<S-Tab>'
        end
      end)
    end

  end,
})

-- PLUGIN: oil

try('oil', function ()
  require'oil'.setup {
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  }
  vim.keymap.set('n', '-', ':Oil %:p:h<Enter>', { remap = false, silent = true })
end)
