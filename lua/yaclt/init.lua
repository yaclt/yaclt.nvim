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
  local commandString = M.config.cmd .. ' new --plumbing'
  if args ~= nil then
    for _, arg in ipairs(args) do
      commandString = commandString .. ' ' .. arg
    end
  end

  print(commandString)
  -- local process = io.popen(M.config.cmd)
  -- local stdoutLines = process:lines()
  -- print(stdoutLines)
  -- assert(process.close() == 0) -- assert command executed successfully
  -- local filepath = stdoutLines[0]
  -- vim.api.nvim_command('edit ' .. filepath)
end

return M
