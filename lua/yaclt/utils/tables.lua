local M = {}

function M.cloneTableByValue(obj, seen)
  if type(obj) ~= 'table' then
    return obj
  end

  if seen and seen[obj] then
    return seen[obj]
  end

  local localSeen = seen or {}
  local resultingTable = setmetatable({}, getmetatable(obj))
  localSeen[obj] = result

  for key, value in pairs(obj) do
    resultingTable[M.cloneTableByValue(key, localSeen)] = M.cloneTableByValue(value, localSeen)
  end

  return resultingTable
end

function M.mergeTables(table1, table2)
  local resultingTable = M.cloneTableByValue(table1)

  for key, value in pairs(table2) do
    if (type(value) == 'table') and (type(resultingTable[key] or false) == 'table') then
      M.mergeTables(resultingTable[key], table2[key])
    else
      resultingTable[key] = value
    end
  end

  return resultingTable
end

return M
