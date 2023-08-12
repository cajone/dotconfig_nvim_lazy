-- In your init.lua

require("lualine").setup({
    options = {
        icon_enabled = false,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' },
        theme = "jellybeans",
    },
    sections = {
        lualine_a = {
            {
                "filename",
                path = 1,
            },
        },
        lualine_b = {
            "branch",
        },
        lualine_c = {
            {
                "diagnostics",
                sources = {"nvim_lsp"},
                symbols = {error = "E", warn = "W", info = "I", hint = "H"},
            },
        },
        lualine_x = {
            "filetype",
        },
        lualine_y = {
            "progress",
        },
        lualine_z = { -- This is the new section for the LCD
            function()
                return vim.fn.getcwd()
            end,
        },
    },
})

