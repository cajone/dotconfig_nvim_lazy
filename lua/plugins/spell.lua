-- M = {
--   "matkrin/telescope-spell-errors.nvim",
--   config = function()
--       require("telescope").load_extension("spell_errors")
--   end,
--   dependencies = "nvim-telescope/telescope.nvim",
-- }
-- return M


-- require("plugins.telescope_spellcheck")

-- Create a command to trigger spell check with Telescope
vim.api.nvim_create_user_command("SpellCheck", function()
    require("plugins.telescope_spellcheck").spellcheck_with_telescope()
end, {})

M = {}
-- ~/.config/nvim/lua/plugins/telescope_spellcheck.lua


-- Function to get all misspelled words from the current buffer
function M.get_misspelled_words()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local misspelled_words = {}

    for _, line in ipairs(lines) do
        -- Use Vim's built-in spell check to get misspelled words
        local words = {}
        for word in string.gmatch(line, "%S+") do
            if vim.fn.spellbadword(word) ~= "" then
                table.insert(words, word)
            end
        end

        for _, word in ipairs(words) do
            -- Ensure each misspelled word is unique
            if not vim.tbl_contains(misspelled_words, word) then
                table.insert(misspelled_words, word)
            end
        end
    end

    return misspelled_words
end

-- Function to open Telescope with misspelled words
function M.spellcheck_with_telescope()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    local misspelled_words = M.get_misspelled_words()

    if #misspelled_words == 0 then
        vim.notify("No misspelled words found!", vim.log.levels.INFO)
        return
    end

    telescope.pickers.new({}, {
        prompt_title = "Misspelled Words",
        finder = require("telescope.finders").new_table({
            results = misspelled_words,
        }),
        sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            -- Define actions for the picker
            map("i", "<CR>", actions.close)
            map("n", "<CR>", actions.close)

            return true
        end,
    }):find()
end

return M
