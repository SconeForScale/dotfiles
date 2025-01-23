vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- plugin loader
require("config.lazy")

-- movement bindings; laptop caps is bound to ctrl
-- standalone keyboard uses a qmk map to solve this
vim.keymap.set({"n", "v", "i"}, "<c-j>", "<left>")
vim.keymap.set({"n", "v", "i"}, "<c-k>", "<down>")
vim.keymap.set({"n", "v", "i"}, "<c-i>", "<up>")
vim.keymap.set({"n", "v", "i"}, "<c-l>", "<right>")

-- ctrl+i binding breaks tab; make a new tab function
-- this may not work in some terminals
vim.keymap.set("i", "<tab>", function()
    if vim.opt.expandtab:get() then
        return string.rep(" ", vim.opt.shiftwidth:get())
    else
        return "<tab>"
    end
end, { expr = true })

-- telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

-- nvim-tree
vim.keymap.set('n', '<leader>t', function()
  if vim.fn.bufname():match 'NvimTree_' then
    vim.cmd.wincmd 'p'
  else
    vim.cmd("NvimTreeFindFile")
  end
end)
-- clipboard
vim.keymap.set({"n", "v"}, "<leader>yc", '"+y')

-- theme
require("config.theme")

-- lsp servers setup
require("mason").setup()
require("mason-lspconfig").setup({})

-- completions
require("config.cmp")

-- lsp clients setup
require("config.basedpyright") -- python
require("config.gopls") -- go
require("config.ts_ls") -- js
require("config.rust_analyzer") -- rust

-- formatters
require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
})

-- workspace browser
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- file finder/text searcher
require("config.telescope")

-- manual format
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.opt.wildignore = { '*.o', '*.a', '__pycache__' }
vim.opt.formatoptions = { n = true, j = true, t = true }
