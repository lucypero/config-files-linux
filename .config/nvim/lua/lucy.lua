local api = vim.api
local lucy = {}

-- Table to string
function lucy.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function lucy.nn(lhs, rhs)
  api.nvim_set_keymap('n', lhs, rhs, {noremap = true})
end

function lucy.nns(lhs, rhs)
  api.nvim_set_keymap('n', lhs, rhs, {noremap = true, silent = true})
end

function lucy.makeScratch()
  api.nvim_command('enew')
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "hide"
  vim.bo.swapfile = false
end

------------------- Telescope ------------------

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

function lucy.t_cmd(mode,opts)
  local opts_final = themes.get_ivy()
  opts = opts or {}
  for k,v in pairs(opts) do opts_final[k] = v end
  builtin[mode](opts_final)
end

function lucy.fix_compiler_output()
  api.nvim_command('%s/\\\\r\\\\n/\r/g')
end

return lucy
