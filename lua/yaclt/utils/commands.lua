local M = {}

function M.createCommands()
  vim.cmd('command! YacltNew :lua require("yaclt").new()')
  vim.cmd('command! YacltValidate :lua require("yaclt").validate()')
  vim.cmd('command! YacltPrepareRelease :lua require("yaclt").prepareRelease()')
end

return M
