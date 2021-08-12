local M = {}

M.config = {
  cmd = 'yaclt',
}

function M.setup(config)
  config = config or {}
  M.config = require('yaclt.utils').mergeTables(M.config, config)
end

function M.new(args)
  local result = require('yaclt.utils').runCommand('new', args)
  local filepath = result.stdout
  local error = result.stderr
  if filepath ~= nil then
    vim.cmd('edit ' .. filepath)
  end
end

function M.validate(args)
  local result = require('yaclt.utils').runCommand('validate', args)
  local success = result.stdout
  local error = result.stderr

  if success == 'true' then
    print('All changelogs formatted properly!')
  end

  if error ~= nil then
    print(error)
  end
end

return M
