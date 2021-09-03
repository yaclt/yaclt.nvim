local M = {}

function M.startswith(text, prefix)
  return text:find(prefix, 1, true) == 1
end

function M.joinListToString(output)
  if not (type(output) == 'table') then
    return output
  end

  local str = ''
  for _, val in pairs(output) do
    str = str .. val .. '\n'
  end
  return str
end

function M.splitLines(str)
  local lines = {}
  for s in str:gmatch('[^\r\n]+') do
    table.insert(lines, s)
  end
  return lines
end

function M.trimTrailingNewlines(str)
  if str == nil then
    return nil
  end
  local n = #str
  while n > 0 and str:find('^%s', n) do
    n = n - 1
  end
  return str:sub(1, n)
end

return M
