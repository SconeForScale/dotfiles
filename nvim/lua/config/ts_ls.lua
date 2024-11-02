local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").ts_ls.setup({
    capabilities = capabilities,
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    }
})
