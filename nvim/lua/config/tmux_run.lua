_G.runner_panes = {}

local function is_pane_valid(pane_id)
  if not pane_id then return false end
  local check_cmd = "tmux list-panes -F '#{pane_id}'"
  local existing_panes = vim.fn.system(check_cmd)
  return existing_panes:find(pane_id .. "\n", 1, true) ~= nil
end

local function send_cmd_to_pane(pane_id, cmd)
  local clear_cmd = vim.fn.shellescape("clear")
  local escaped_cmd = vim.fn.shellescape(cmd)
  local send_keys_clear = string.format("tmux send-keys -t %s %s Enter", pane_id, clear_cmd)
  local send_keys_actual = string.format("tmux send-keys -t %s %s Enter", pane_id, escaped_cmd)

  vim.fn.system(send_keys_clear)
  vim.fn.system(send_keys_actual)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to send command to tmux pane " .. pane_id, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function compile_and_run()
  vim.cmd('write')
  local bufnr = vim.api.nvim_get_current_buf()
  local fullpath = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(fullpath, ':h')
  local exe = vim.fn.fnamemodify(fullpath, ':r')
  local filetype = vim.bo.filetype
  local args = vim.fn.input("Enter arguments (optional): ")

  local cmd_core
  if filetype == 'c' then cmd_core = "gcc " .. fullpath .. " -o " .. exe .. " && " .. exe .. " " .. args
  elseif filetype == 'cpp' then cmd_core = "g++ " .. fullpath .. " -o " .. exe .. " && " .. exe .. " " .. args
  elseif filetype == 'rust' then
    local cargo_args = ""
    if args ~= "" then cargo_args = " -- " .. args end
    cmd_core = "cargo run" .. cargo_args
  elseif filetype == 'go' then cmd_core = "go run " .. fullpath .. " " .. args
  elseif filetype == 'sh' then cmd_core = "sh " .. fullpath .. " " .. args
  elseif filetype == 'python' then cmd_core = "python " .. fullpath .. " " .. args
  else
    vim.notify("No compile/run command for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  local cmd_final = cmd_core
  local target_pane_id = _G.runner_panes[bufnr]

  if is_pane_valid(target_pane_id) then
    if not send_cmd_to_pane(target_pane_id, cmd_final) then _G.runner_panes[bufnr] = nil end
  else
    local current_pane = os.getenv('TMUX_PANE')
    if not current_pane then
      vim.notify("Not running inside tmux?", vim.log.levels.WARN)
      vim.fn.VimuxRunCommand(vim.fn.shellescape(cmd_final))
      return
    end
    local escaped_dir = vim.fn.shellescape(dir)
    local create_cmd = string.format('tmux split-window -P -F "#{pane_id}" -v -p 20 -t %s -c %s', current_pane, escaped_dir)
    local new_pane_id = vim.fn.trim(vim.fn.system(create_cmd))
    if vim.v.shell_error ~= 0 or new_pane_id == "" then
      vim.notify("Failed to create tmux pane.", vim.log.levels.ERROR)
      _G.runner_panes[bufnr] = nil
      return
    end
    _G.runner_panes[bufnr] = new_pane_id
    if not send_cmd_to_pane(new_pane_id, cmd_final) then _G.runner_panes[bufnr] = nil end
  end
end

vim.keymap.set("n", "<leader>r", compile_and_run, { desc = "Compile and Run" })

vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    if os.getenv('TMUX_PANE') then
      for bufnr, pane_id in pairs(_G.runner_panes) do
        if is_pane_valid(pane_id) then
          vim.fn.system(string.format("tmux kill-pane -t %s", pane_id))
        end
      end
      _G.runner_panes = {}
    end
  end,
})
