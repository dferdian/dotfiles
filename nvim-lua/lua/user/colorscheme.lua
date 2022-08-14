--
-- Darkplus Theme
--

-- local colorscheme = "darkplus"
--
-- vim.g.onedarker_italic_keywords = false
-- vim.g.onedarker_italic_functions = false
-- vim.g.onedarker_italic_comments = true
-- vim.g.onedarker_italic_loops = false
-- vim.g.onedarker_italic_conditionals = false

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
--   -- vim.notify("colorscheme " .. colorscheme .. " not found!")
--   return
-- end

--
-- Github Theme (https://github.com/projekt0n/github-nvim-theme)
--

-- local status_ok, github_theme = pcall(require, "github-theme")
-- if not status_ok then
--   return
-- end
--
-- github_theme.setup({
--   theme_style = "dimmed",
--   overrides = function(c)
--     return {
--       TabLine = { fg = c.fg, bg = c.bg }, -- tab pages line, not active tab page label
--       TabLineFill = { bg = c.bg2 }, -- tab pages line, where there are no labels
--       TabLineSel = { link = 'PmenuSel' }, -- tab pages line, active tab page label
--     }
--   end
-- })

--
-- Catppuccin Themes (https://github.com/catppuccin/nvim) --
--

-- local status_ok, catppuccin = pcall(require, "catppuccin")
-- if not status_ok then
--   return
-- end
--
-- local ucolors = require "catppuccin.utils.colors"
-- local frappe = require("catppuccin.palettes").get_palette "frappe"
-- local mocha = require("catppuccin.palettes").get_palette "mocha"
--
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
--
-- catppuccin.setup()
--
-- vim.cmd [[colorscheme catppuccin]]

--
-- NightFox Theme (https://github.com/EdenEast/nightfox.nvim)
--

local status_ok, catppuccin = pcall(require, "nightfox")
if not status_ok then
  return
end

require('nightfox').setup({})

-- setup must be called before loading
vim.cmd("colorscheme nordfox") -- nightfox
