-- Define the source and target directories
local default_gp_dir = vim.fn.expand('~/.local/share/nvim/gp')
local custom_gp_dir = vim.fn.expand('~/Documents/gp')

-- Ensure the custom directory exists before creating a symlink
vim.fn.system('mkdir -p ' .. custom_gp_dir)

-- Function to check if a path is a symbolic link
local function is_symlink(path)
    local attr = vim.loop.fs_lstat(path)
    return attr and attr.type == "link"
end

-- Function to remove the directory or file safely
local function safe_remove(path)
    if vim.loop.fs_stat(path) then
        -- Check if it's a directory
        if is_symlink(path) then
            vim.fn.system('rm ' .. path)
        else
            vim.fn.system('rm -rf ' .. path)
        end
    end
end

-- Main logic: Ensure default_gp_dir is a symlink to custom_gp_dir
if not is_symlink(default_gp_dir) then
    -- Remove the directory/file if it exists (not a symlink)
    safe_remove(default_gp_dir)
    
    -- Create the symbolic link
    vim.fn.system('ln -s ' .. custom_gp_dir .. ' ' .. default_gp_dir)
end

