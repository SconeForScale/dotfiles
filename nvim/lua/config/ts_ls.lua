local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    }
})
