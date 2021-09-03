local M = {}

function M.setup(config)
  config = config or {}
  local configModule = require('yaclt.config')
  configModule.config = require('yaclt.utils.tables').mergeTables(configModule.config, config)
end

-- the --edit flag has to be overridden to false because we're opening it manually in the current nvim instance
local function removeEditArg(args)
  local stringUtils = require('yaclt.utils.strings')
  local indexOfEdit = -1
  for index, val in pairs(args) do
    if stringUtils.startswith(val, '--edit') then
      indexOfEdit = index
      break
    end
  end

  if indexOfEdit == -1 then
    return args
  end

  table.remove(args, indexOfEdit)
  -- check if they did --edit true
  if table[indexOfEdit] == 'true' then
    table.remove(args, indexOfEdit)
  end
  return args
end

function M.new(args)
  local result = require('yaclt.utils.jobs').runYaclt('new', removeEditArg(args))
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
  local result = require('yaclt.utils.jobs').runYaclt('validate', removeEditArg(args))
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
  local result = require('yaclt.utils.jobs').runYaclt('prepare-release', removeEditArg(args))
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
