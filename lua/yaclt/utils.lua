local M = {}

function M.joinArgs(args)
  local argString = ''
  assert(args)
  for _, arg in ipairs(args) do
    local isOption = arg:find('--', 1, true) == 1 or (arg:find('-', 1, true) == 1 and string.len(arg) == 2)
    argString = argString .. ' '
    if not isOption then
      argString = argString .. '"'
    end
    argString = argString .. arg
    if not isOption then
      argString = argString .. '"'
    end
  end

  return argString
end

function M.joinLines(lines)
  local output = ''
  for _, line in ipairs(lines) do
    output = output .. '\n' .. line
  end
  return output
end

return M
