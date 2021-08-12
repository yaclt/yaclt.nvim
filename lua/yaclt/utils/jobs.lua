local Job = require('plenary.job')

local M = {}

function M.runCommand(command, args)
  local config = require('yaclt.config').config
  local allArgs = args or {}
  table.insert(allArgs, 1, command)
  table.insert(allArgs, '--plumbing')

  local stdout = nil
  local stderr = nil

  Job
    :new({
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
      end,
    })
    :sync()

  local strings = require('yaclt.utils.strings')

  return {
    stdout = strings.trimTrailingNewlines(strings.joinOutput(stdout)),
    stderr = strings.trimTrailingNewlines(strings.joinOutput(stderr)),
  }
end

return M
