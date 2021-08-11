local M = {}

function M.joinArgs(args)
  local argString = ''
  assert(args)
  for _, arg in ipairs(args) do
    local isOption = arg:find('--', 1, true) == 1 or (arg:find('-', 1, true) == 1 and string.len(arg) == 2)
    argString = argString .. ' '
    if isOption then
      argString = argString .. arg
    else
      argString = argString .. string.format('%q', arg)
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

function M.trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function M.formatOutput(output)
  local formatted = ''
  local lines = {}
  for s in output:gmatch("[^\r\n]+") do
    table.insert(lines, M.trim(s))
  end

  return M.joinLines(lines)
end

return M
