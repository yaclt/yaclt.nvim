local M = {}

local function execute(args_table)
  local command = table.remove(args_table, 1)
  if command == 'new' then
    require('yaclt').new(args_table)
  elseif command == 'validate' then
    require('yaclt').validate(args_table)
  elseif command == 'prepare-release' then
    require('yaclt').prepareRelease(args_table)
  else
    print('ERROR: Unknown command: ' .. command)
  end
end

function M.parse(arg_string)
  local args_table = {}
  local spat, epat, buf, quoted = [=[^(['"])]=], [=[(['"])$]=]
  for str in arg_string:gmatch('%S+') do
    local squoted = str:match(spat)
    local equoted = str:match(epat)
    local escaped = str:match([=[(\*)['"]$]=])
    if squoted and not quoted and not equoted then
      buf, quoted = str, squoted
    elseif buf and equoted == quoted and #escaped % 2 == 0 then
      str, buf, quoted = buf .. ' ' .. str, nil, nil
    elseif buf then
      buf = buf .. ' ' .. str
    end
    if not buf then
      table.insert(args_table, (str:gsub(spat, ''):gsub(epat, '')))
    end
  end
  if buf then
    print('Missing matching quote for ' .. buf)
    return
  end
  execute(args_table)
end

return M
