-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	{
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ "williamboman/mason.nvim" },
        { "kyazdani42/nvim-tree.lua" },
	    { "williamboman/mason-lspconfig.nvim" },
    	{ "neovim/nvim-lspconfig" },
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{
			"stevearc/conform.nvim",
			branch = "nvim-0.9",
			opts = {}
		},
        { "simrat39/rust-tools.nvim" },
        { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
        { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },
	},
	{
		colorscheme = { "catppuccin" },
	}
)
