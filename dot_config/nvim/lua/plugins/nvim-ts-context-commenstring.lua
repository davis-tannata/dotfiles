return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    -- nvim-treesitter `main` has no module system; skip the legacy module
    -- registration so this doesn't pull in nvim-treesitter at startup.
    init = function()
        vim.g.skip_ts_context_commentstring_module = true
    end,
    config = function()
        require('ts_context_commentstring').setup {
            enable_autocmd = false,
        }

        require('Comment').setup {
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
    end
}
