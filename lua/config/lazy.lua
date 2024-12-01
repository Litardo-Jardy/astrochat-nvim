local plugins = {}

local plugins_files = vim.fn.glob(vim.fn.stdpath('config') .. '/lua/plugins/*.lua', true, true) or {}

for _, file in ipairs(plugins_files) do
   local plugin = dofile(file)
   if type(plugin) == 'table' then
      for _, p in ipairs(plugin) do
	  table.insert(plugins, p)
      end
   end
end

require('lazy').setup(plugins)
