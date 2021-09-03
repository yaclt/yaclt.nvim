local M = {}

function M.setup(config)
  config = config or {}
  local configModule = require('yaclt.config')
  configModule.config = require('yaclt.utils').mergeTables(configModule.config, config)
end

function M.new(args)
  local result = require('yaclt.utils.jobs').runYaclt('new', args)
  local filepath = result.stdout
  local error = result.stderr
  if filepath ~= nil then
    vim.cmd('edit ' .. filepath)
  end

  if error ~= nil then
    print(error)
  end
end

function M.validate(args)
  local result = require('yaclt.utils.jobs').runYaclt('validate', args)
  local success = result.stdout
  local error = result.stderr

  if success == 'true' then
    print('All changelogs formatted properly!')
  end

  if error ~= nil then
    print(error)
  end
end

function M.prepareRelease(args)
  local result = require('yaclt.utils.jobs').runYaclt('prepare-release', args)
  local stdout = result.stdout
  local error = result.stderr

  if stdout ~= nil then
    local lines = require('yaclt.utils.strings').splitLines(stdout)
    local changelogFilepath = lines[#lines] -- changelogFilepath is last line of stdout
    vim.cmd('edit ' .. changelogFilepath)
  end

  if error ~= nil then
    print(error)
  end
end

return M
