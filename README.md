# kitty-nvim-font-switcher

Dynamically switch Kitty fonts based on Neovim filetype.

- **Coding** → `JetBrainsMono Nerd Font Mono`
- **Markdown** → `GaramondMono Nerd Font Mono`

```
kitty/              # Kitty configs (font_default.conf, font_markdown.conf)
nvim/               # Neovim autocommand (kitty-font-switcher.lua)
fonts/              # Garamond Mono (OFL) + Nerd Font patched variant (OFL)
install.sh          # Copy fonts + configs
```

## Install

```bash
git clone https://github.com/jbuck95/kitty-nvim-font-switcher.git && cd kitty-nvim-font-switcher && ./install.sh
```

- Add `listen_on unix:/tmp/kitty` to your kitty.conf
- Add to your Neovim config (`init.lua` or `autocmds.lua`):
  ```lua
  -- Kitty Font Switcher
  local function switch_kitty_font()
    local ft = vim.bo.filetype
    local conf = ft == "markdown"
      and "~/.config/kitty/font_markdown.conf"
      or "~/.config/kitty/font_default.conf"
    vim.schedule(function()
      vim.fn.system("kitty @ load-config " .. conf)
    end)
  end

  local group = vim.api.nvim_create_augroup("KittyFontSwitcher", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
    pattern = "*", group = group,
    callback = switch_kitty_font,
  })
  vim.api.nvim_create_autocmd("VimLeave", {
    group = group,
    callback = function()
      vim.fn.system("kitty @ load-config ~/.config/kitty/font_default.conf")
    end,
  })
  ```
  Oder die separate Datei `nvim/lua/config/kitty-font-switcher.lua` nutzen:
  ```lua
  require('config.kitty-font-switcher')
  ```
- Install `ttf-jetbrains-mono-nerd` (Arch) or equivalent

## License

- Fonts: SIL OFL 1.1
- Scripts/configs: MIT
