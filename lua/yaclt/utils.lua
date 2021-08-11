local Job = require('plenary.job')
local config = require('yaclt').config

local M = {}

function M.joinOutput(output)
  if not (type(output) == 'table') then
    return output
  end

  local str = ''
  for _, val in pairs(output) do
    str = str .. val .. '\n'
  end
  return str
end

function M.trimTrailingNewlines(str)
  if str == nil then
    return nil
  end
  local n = #str
  while n > 0 and str:find("^%s", n) do n = n - 1 end
  return str:sub(1, n)
end

function M.runCommand(command, args)
  local allArgs = args or {}
  table.insert(allArgs, 1, command)
  table.insert(allArgs, '--plumbing')

  local stdout = nil
  local stderr = nil

  Job:new({
    command = config.cmd,
    args = allArgs,
    cwd = vim.fn.getcwd(),
    enabled_recording = true,
    on_stderr = function(_, data)
      stderr = stderr or {}
      table.insert(stderr, data)
    end,
    on_stdout = function(_, data)
      stdout = stdout or {}
      table.insert(stdout, data)
    end
  }):sync()

  return {
    stdout = M.trimTrailingNewlines(M.joinOutput(stdout)),
    stderr = M.trimTrailingNewlines(M.joinOutput(stderr))
  }
end

return M
