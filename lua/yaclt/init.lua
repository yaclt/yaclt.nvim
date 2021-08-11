local Job = require('plenary.job')

local M = {}

M.config = {
  cmd = 'yaclt',
}

function M.setup(config)
  if config ~= nil and config.cmd ~= nil then
    M.config.cmd = config.cmd
  end
end

function M.new(args)
  local allArgs = args
  table.insert(allArgs, 1, 'new')
  table.insert(allArgs, '--plumbing')
  local filepath = ''
  Job:new({
    command = M.config.cmd,
    args = allArgs,
    cwd = vim.fn.getcwd(),
    enabled_recording = true,
    on_stderr = function(_, data)
      print(data)
    end,
    on_stdout = function(_, data)
      filepath = data
    end
  }):sync()
  if filepath ~= '' then
    vim.cmd('edit ' .. filepath)
  end
end

return M
