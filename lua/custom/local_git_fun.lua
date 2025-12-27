-- GIt functions

-- Define a function to push the current branch
function _G.push_current_branch()
  local branch_name = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if not branch_name then
    print("Could not determine the current branch.")
    return
  end

  -- Construct and execute the git push command
  local push_command = string.format("git push -u origin %s", branch_name)
  local handle = io.popen(push_command)
  local exit_status = handle:read("*a")
  handle:close()

  print(exit_status)
end

-- Change the LCD to the current Git buffer root
function ChangeWorkingDirectoryToGitRoot()
  local buffer_directory = vim.fn.expand("%:p:h")
  local git_root_path = nil

  -- Run git rev-parse to find the root of the repository
  git_root_path = vim.fn.systemlist("git -C " .. buffer_directory .. " rev-parse --show-toplevel")[1]

  if git_root_path then
    require("nvim-tree").change_dir(git_root_path)
  else
    print("Not in a Git repository")
  end
end
