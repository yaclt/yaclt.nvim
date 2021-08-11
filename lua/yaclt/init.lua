local utils = require('yaclt.utils')

local M = {}

M.config = {
  cmd = 'yaclt',
}

function M.setup(config)
  if config ~= nil and config.cmd ~= nil then
    M.config.cmd = config.cmd
  end
end

function M.yacltNew(args)
  local commandString = string.format('%s new --plumbing %s', M.config.cmd, utils.joinArgs(args))
  print(commandString)
  local process = io.popen(commandString)
  local output = process:read('*all')
  process:close()
  print(utils.formatOutput(output))
  -- assert(process.close() == 0) -- assert command executed successfully
  -- local filepath = stdoutLines[0]
  -- vim.api.nvim_command('edit ' .. filepath)
end

return M
