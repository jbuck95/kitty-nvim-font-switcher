-- Kitty Font Switcher
-- Automatically switches Kitty font based on Neovim filetype.
--
-- Install: require("config.kitty-font-switcher")
-- Requires: `listen_on unix:/tmp/kitty` in kitty.conf

local default_font_conf = "~/.config/kitty/font_default.conf"
local markdown_font_conf = "~/.config/kitty/font_markdown.conf"

local function switch_kitty_font()
  local current_ft = vim.bo.filetype
  local buf_name = vim.api.nvim_buf_get_name(0)

  if current_ft == "markdown" then
    vim.schedule(function()
      vim.fn.system(string.format("kitty @ load-config %s", markdown_font_conf))
    end)
    return
  end

  local code_filetypes = {
    lua = true, sh = true, python = true, rust = true,
    javascript = true, typescript = true, go = true,
    conf = true, kitty = true, help = true,
  }

  if code_filetypes[current_ft] then
    vim.schedule(function()
      vim.fn.system(string.format("kitty @ load-config %s", default_font_conf))
    end)
  end
end

local font_switcher_group = vim.api.nvim_create_augroup("KittyFontSwitcher", { clear = true })

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  pattern = "*",
  group = font_switcher_group,
  callback = switch_kitty_font,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = font_switcher_group,
  callback = function()
    vim.fn.system(string.format("kitty @ load-config %s", default_font_conf))
  end,
})
