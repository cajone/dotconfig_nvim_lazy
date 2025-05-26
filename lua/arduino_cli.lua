-- ~/.config/nvim/lua/arduino_cli.lua

-- IMPORTANT: Configure your board's FQBN and Port here
local ARDUINO_FQBN = "esp32:esp32:esp32c3"
local ARDUINO_PORT = "/dev/ttyACM0" -- Adjust this if your port changes (e.g., /dev/ttyUSB0)

-- Function to get or create the output buffer
local function get_or_create_output_buffer()
  -- Using a more unique and less ambiguous name for the output buffer
  -- This helps avoid potential conflicts with standard buffer IDs or names.
  local buf_name = "ArduinoCLI_Output_Log"
  local buf_nr = vim.fn.bufnr(buf_name)

  if buf_nr == -1 or not vim.api.nvim_buf_is_valid(buf_nr) then
    -- Create a new scratch buffer (not listed, nofile, no swap)
    buf_nr = vim.api.nvim_create_buf(false, true)            -- false for 'listed', true for 'scratch'
    vim.api.nvim_buf_set_name(buf_nr, buf_name)
    vim.api.nvim_buf_set_option(buf_nr, 'bufhidden', 'wipe') -- Buffer wiped when hidden
    vim.api.nvim_buf_set_option(buf_nr, 'buftype', 'nofile') -- Not associated with a file on disk
    vim.api.nvim_buf_set_option(buf_nr, 'swapfile', false)   -- No swap file
    vim.api.nvim_buf_set_option(buf_nr, 'modifiable', false) -- Make it read-only by default
    vim.api.nvim_buf_set_option(buf_nr, 'filetype', 'log')   -- Set filetype for basic syntax highlighting
  end
  return buf_nr
end

-- Function to open and populate the output buffer
local function show_output(output, status)
  -- Debugging lines (these will print to the terminal where you launched nvim)
  print("--- show_output called (Final Version) ---")
  local output_buf_nr = get_or_create_output_buffer()
  print("Output buffer number (target for content): " .. tostring(output_buf_nr))

  local original_win_id = vim.api.nvim_get_current_win()            -- Store ID of the window we were in
  local original_buf_nr = vim.api.nvim_win_get_buf(original_win_id) -- Get the buffer number of the original window
  print("Original window ID: " .. tostring(original_win_id) .. ", Original buffer #: " .. tostring(original_buf_nr))

  local output_win_id = nil
  -- Try to find an existing window displaying the output buffer in the current tabpage
  for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do -- 0 is current tabpage
    if vim.api.nvim_win_get_buf(win_id) == output_buf_nr then
      output_win_id = win_id
      break
    end
  end

  if not output_win_id then
    -- If no window found for output buffer, create a new split and immediately show the output buffer in it
    -- 'sbuffer' creates a split and displays the given buffer, making it the current window.
    vim.cmd('sbuffer ' .. tostring(output_buf_nr))
    output_win_id = vim.api.nvim_get_current_win()                            -- Get the ID of the newly created window
    vim.api.nvim_win_set_height(output_win_id, math.floor(vim.o.lines * 0.3)) -- Set height to approx 30% of screen
    vim.api.nvim_win_set_option(output_win_id, 'winfixheight', true)          -- Prevent auto-resizing
    vim.cmd('wincmd J')                                                       -- Move the new window to the very bottom
    print("Created new output window with ID: " .. tostring(output_win_id))
  else
    -- If window already exists, ensure it's visible and active to update its content
    print("Reusing existing output window with ID: " .. tostring(output_win_id))
    vim.api.nvim_set_current_win(output_win_id)
  end

  -- At this point, `output_win_id` is the ID of the active window, and it should be showing `output_buf_nr`.
  -- Update buffer content
  vim.api.nvim_buf_set_option(output_buf_nr, 'modifiable', true) -- Make temporarily modifiable
  -- Clear existing content and insert new lines
  vim.api.nvim_buf_set_lines(output_buf_nr, 0, -1, false, vim.split(output, '\n'))
  vim.api.nvim_buf_set_option(output_buf_nr, 'modifiable', false) -- Set back to read-only
  vim.cmd('normal! G')                                            -- Scroll to the bottom of the output

  -- Restore focus to the original window where the user was editing
  vim.api.nvim_set_current_win(original_win_id)
  print("Restored focus to original window ID: " .. tostring(original_win_id))

  -- Provide a Neovim notification based on status
  if status == 0 then
    vim.notify("Arduino operation successful!", vim.log.levels.INFO, { title = "Arduino CLI" })
  else
    vim.notify("Arduino operation FAILED! Check the output window.", vim.log.levels.ERROR,
      { title = "Arduino CLI", timeout = 5000 })
  end
  print("--- show_output finished (Final Version) ---")
end

-- Generic function to run arduino-cli command
local function run_arduino_command(command_parts, action_name)
  local current_file = vim.fn.expand("%:p")
  local file_ext = vim.fn.fnamemodify(current_file, ':e')

  -- Basic check to ensure it's an .ino file
  if file_ext ~= 'ino' then
    vim.notify("Current file is not an .ino sketch. Please open your Arduino sketch.", vim.log.levels.WARN,
      { title = "Arduino CLI", timeout = 5000 })
    return -1 -- Indicate failure
  end

  table.insert(command_parts, current_file) -- Add the sketch file path
  local cmd = table.concat(command_parts, " ")

  vim.notify(action_name .. "...", vim.log.levels.INFO, { title = "Arduino CLI", timeout = 2000 }) -- Short notification
  -- print("Full command: " .. cmd) -- Uncomment for debugging if needed in the external terminal

  -- Execute the command and capture its output and exit status
  local output, status = vim.fn.system(cmd)

  -- Display the captured output in the dedicated buffer
  show_output(output, status)

  return status -- Return status for potential future error handling
end

-- Function to compile the current sketch
function _G.ArduinoCompileCurrentSketch()
  run_arduino_command({ "arduino-cli", "compile", "--fqbn", ARDUINO_FQBN }, "Compiling Arduino sketch")
end

-- Function to upload the current sketch
function _G.ArduinoUploadCurrentSketch()
  run_arduino_command({ "arduino-cli", "upload", "-p", ARDUINO_PORT, "--fqbn", ARDUINO_FQBN }, "Uploading Arduino sketch")
end

-- Function to compile AND upload the current sketch
function _G.ArduinoBuildAndUploadCurrentSketch()
  run_arduino_command({ "arduino-cli", "compile", "--upload", "-p", ARDUINO_PORT, "--fqbn", ARDUINO_FQBN },
    "Compiling and Uploading Arduino sketch")
end

-- Create Neovim User Commands
-- These allow you to run commands like :ArduinoCompile, :ArduinoUpload, etc.
vim.api.nvim_create_user_command('ArduinoCompile', _G.ArduinoCompileCurrentSketch, {})
vim.api.nvim_create_user_command('ArduinoUpload', _G.ArduinoUploadCurrentSketch, {})
vim.api.nvim_create_user_command('ArduinoBuildAndUpload', _G.ArduinoBuildAndUploadCurrentSketch, {})

-- Keybindings for convenience
-- Ensure your <leader> key is set in your init.lua if you are using it (e.g., vim.g.mapleader = ' ')
vim.keymap.set('n', '<leader>ac', ':ArduinoCompile<CR>', { desc = 'Arduino: Compile Sketch' })
vim.keymap.set('n', '<leader>au', ':ArduinoUpload<CR>', { desc = 'Arduino: Upload Sketch' })
vim.keymap.set('n', '<leader>ab', ':ArduinoBuildAndUpload<CR>', { desc = 'Arduino: Compile & Upload Sketch' })
