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
  vim.api.nvim_set_keymap('n', lhs, rhs, {noremap = true})
end

------------------- Telescope ------------------

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

function lucy.t_cmd(mode,theme,opts)
  local opts_final = themes.get_ivy()
  opts = opts or {}
  for k,v in pairs(opts) do opts_final[k] = v end
  builtin[mode](opts_final)
end

return lucy
