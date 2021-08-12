local M = {}

function M.setup(config)
  config = config or {}
  local configModule = require('yaclt.config')
  configModule.config = require('yaclt.utils').mergeTables(configModule.config, config)
end

function M.new(args)
  local result = require('yaclt.utils.jobs').runCommand('new', args)
  local filepath = result.stdout
  local error = result.stderr
  if filepath ~= nil then
    vim.cmd('edit ' .. filepath)
  end
end

function M.validate(args)
  local result = require('yaclt.utils.jobs').runCommand('validate', args)
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
