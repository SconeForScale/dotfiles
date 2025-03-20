
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").basedpyright.setup({
    capabilities = capabilities,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                exclude = {
                    "~/*",
                    "!~/projects/**",
                    "!~/qmk_firmware/**",
                    "!~/.dotfiles/**",
                }
            }
        }
    },
    before_init = function(_, config)
        -- handles venv usage - use local .venv if it exists, otherwise system python
        local venv_path = vim.fn.getcwd().."/.venv/bin/python"
        config.settings.python = {}
        if vim.fn.filereadable(venv_path) == 1 then
            config.settings.python.pythonPath = venv_path
        else
            config.settings.python.pythonPath = "/usr/bin/python"
        end
    end,
})


