require("config.lazy")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.theme")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("mason").setup()

require("mason-lspconfig").setup({})

-- not great ways to ensure linters/formatters installed so we list em here godspeed
-- pylint black eslint
-- require("mason-lspconfig").setup_handlers({
--	function(server_name)
--		require("lspconfig")[server_name].setup({})
--	end,
-- })

require("config.cmp")
require("config.basedpyright")

require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
})

require("config.gopls")
require("config.ts_ls")

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

vim.keymap.set('n', '<Leader>ex1', '<cmd>echo "Test 1"<cr>')
